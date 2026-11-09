extends CharacterBody3D
# PlayerController — First-person player movement and interaction.
#
# Node structure (scenes/player/player.tscn):
#   Player (CharacterBody3D)   <- this script
#   ├── CollisionShape3D       <- CapsuleShape3D
#   ├── Head (Node3D)
#   │   └── Camera3D
#   ├── InteractionRay (RayCast3D)
#   └── PlayerAudio (AudioStreamPlayer3D)
#
# Survival integration (stamina consumption) is handled by SurvivalComponent
# and connected in Phase 3. Sprint speed is applied here but stamina
# deduction is deferred — a signal hook is left as a placeholder.

class_name PlayerController


# ── Movement constants ────────────────────────────────────────────────────────
const WALK_SPEED: float = 4.0        # metres per second
const SPRINT_SPEED: float = 7.0      # metres per second
const JUMP_VELOCITY: float = 4.5     # metres per second (upward impulse)
const GRAVITY: float = 9.8           # metres per second squared

# ── Camera constants ──────────────────────────────────────────────────────────
const MOUSE_SENSITIVITY: float = 0.002  # radians per pixel
const PITCH_MIN: float = -1.483         # -85 degrees in radians
const PITCH_MAX: float = 1.483          #  85 degrees in radians

# ── Interaction constants ─────────────────────────────────────────────────────
const INTERACTION_DISTANCE: float = 2.5  # metres (matches InteractionRay length)

# ── Node references (assigned in _ready) ─────────────────────────────────────
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var interaction_ray: RayCast3D = $InteractionRay
@onready var survival: SurvivalComponent = get_node_or_null("SurvivalComponent")
@onready var inventory: InventoryComponent = get_node_or_null("InventoryComponent")

# ── State ─────────────────────────────────────────────────────────────────────
var is_sprinting: bool = false

# ── Signal ───────────────────────────────────────────────────────────────────
# Emitted each physics frame while sprinting. SurvivalComponent listens here
# in Phase 3 to deduct stamina.
signal sprinting(delta: float)


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	# Mouse look
	if event is InputEventMouseMotion:
		_handle_mouse_look(event.relative)

	# Interaction (single press, not held)
	if event.is_action_pressed("interact"):
		_try_interact()


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_jump()
	_handle_movement(delta)
	move_and_slide()


# ── Private helpers ───────────────────────────────────────────────────────────

func _handle_mouse_look(relative: Vector2) -> void:
	# Horizontal rotation: rotate the whole body left/right
	rotate_y(-relative.x * MOUSE_SENSITIVITY)
	# Vertical rotation: rotate only the head up/down, clamped
	head.rotate_x(-relative.y * MOUSE_SENSITIVITY)
	head.rotation.x = clamp(head.rotation.x, PITCH_MIN, PITCH_MAX)


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta


func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


func _handle_movement(delta: float) -> void:
	var direction := Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	direction = direction.normalized()

	var wants_sprint := Input.is_action_pressed("sprint") and direction != Vector3.ZERO
	if wants_sprint and survival:
		is_sprinting = survival.consume_sprint_stamina()
	else:
		is_sprinting = wants_sprint

	var speed := SPRINT_SPEED if is_sprinting else WALK_SPEED

	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if is_sprinting:
			sprinting.emit(delta)
	else:
		# Decelerate to a stop — no sliding
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)


func _try_interact() -> void:
	if not interaction_ray.is_colliding():
		return

	var target := interaction_ray.get_collider()
	if target == null:
		return

	# Walk up the scene tree to find an Interactable ancestor if the ray
	# hits a child node (e.g. a collision shape owned by the interactable).
	var node := target as Node
	while node != null:
		if node is Interactable:
			(node as Interactable).interact(self)
			return
		node = node.get_parent()
