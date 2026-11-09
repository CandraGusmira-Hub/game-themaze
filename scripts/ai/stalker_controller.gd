extends CharacterBody3D
# StalkerController — Finite State Machine for The Stalker enemy.
#
# Rules (TECHNICAL_DESIGN.md Section 11 & GDD Section 5.3):
# - 5 States: PATROL, DETECT, CHASE, ATTACK, RETURN_TO_PATROL
# - Proximity detection + line of sight check
# - Attacks player within reach, causing survival damage
# - Loses target if player retreats sufficiently or enters safe haven (The Glade)

class_name StalkerController

enum State {
	PATROL,
	DETECT,
	CHASE,
	ATTACK,
	RETURN_TO_PATROL
}

@export var walk_speed: float = 2.5
@export var chase_speed: float = 4.8
@export var detection_radius: float = 12.0
@export var lose_target_radius: float = 18.0
@export var attack_range: float = 1.8
@export var attack_damage: float = 20.0
@export var attack_cooldown: float = 1.5

# Patrol waypoints relative to initial spawn or in global coords
@export var patrol_points: Array[Vector3] = [
	Vector3(0, 0, -18),
	Vector3(14, 0, -24),
	Vector3(0, 0, -32),
	Vector3(-14, 0, -24)
]

var current_state: State = State.PATROL
var current_patrol_index: int = 0
var target_player: PlayerController = null
var attack_timer: float = 0.0

@onready var detection_ray: RayCast3D = $DetectionRay


func _ready() -> void:
	await get_tree().process_frame
	_find_player()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 9.8 * delta

	attack_timer = max(0.0, attack_timer - delta)

	match current_state:
		State.PATROL:
			_process_patrol(delta)
		State.DETECT:
			_process_detect(delta)
		State.CHASE:
			_process_chase(delta)
		State.ATTACK:
			_process_attack(delta)
		State.RETURN_TO_PATROL:
			_process_return(delta)

	move_and_slide()


func _find_player() -> void:
	var players := get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		target_player = players[0] as PlayerController
	else:
		target_player = get_tree().root.find_child("Player", true, false) as PlayerController


func _can_see_player() -> bool:
	if target_player == null:
		_find_player()
		if target_player == null:
			return false

	var dist := global_position.distance_to(target_player.global_position)
	if dist > detection_radius:
		return false

	# The Stalker refuses to cross into The Glade (safe haven, Z > 0)
	if target_player.global_position.z > 0.0:
		return false

	if detection_ray:
		detection_ray.target_position = to_local(target_player.global_position + Vector3(0, 1.0, 0))
		detection_ray.force_raycast_update()
		if detection_ray.is_colliding():
			var col := detection_ray.get_collider()
			return col == target_player

	return true


func _process_patrol(_delta: float) -> void:
	if _can_see_player():
		current_state = State.CHASE
		print("[The Stalker] Player detected! Switching to CHASE.")
		return

	if patrol_points.size() == 0:
		velocity.x = 0
		velocity.z = 0
		return

	var dest := patrol_points[current_patrol_index]
	var dist := global_position.distance_to(dest)
	if dist < 1.2:
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()
		dest = patrol_points[current_patrol_index]

	var dir := (dest - global_position).normalized()
	velocity.x = dir.x * walk_speed
	velocity.z = dir.z * walk_speed
	_look_towards(dest)


func _process_detect(_delta: float) -> void:
	current_state = State.CHASE


func _process_chase(_delta: float) -> void:
	if target_player == null:
		current_state = State.RETURN_TO_PATROL
		return

	var dist := global_position.distance_to(target_player.global_position)

	# Player escaped into Glade or beyond lose radius
	if dist > lose_target_radius or target_player.global_position.z > 0.0:
		print("[The Stalker] Target lost or fled into Glade. Returning to patrol.")
		current_state = State.RETURN_TO_PATROL
		return

	if dist <= attack_range:
		current_state = State.ATTACK
		return

	var dir := (target_player.global_position - global_position).normalized()
	velocity.x = dir.x * chase_speed
	velocity.z = dir.z * chase_speed
	_look_towards(target_player.global_position)


func _process_attack(_delta: float) -> void:
	velocity.x = 0
	velocity.z = 0

	if target_player == null:
		current_state = State.RETURN_TO_PATROL
		return

	var dist := global_position.distance_to(target_player.global_position)
	if dist > attack_range:
		current_state = State.CHASE
		return

	_look_towards(target_player.global_position)

	if attack_timer <= 0.0:
		attack_timer = attack_cooldown
		var survival: SurvivalComponent = target_player.get_node_or_null("SurvivalComponent")
		if survival:
			survival.take_damage(attack_damage)
			print("[The Stalker] Struck player for %d damage!" % attack_damage)


func _process_return(_delta: float) -> void:
	if _can_see_player():
		current_state = State.CHASE
		return

	if patrol_points.size() == 0:
		current_state = State.PATROL
		return

	var dest := patrol_points[current_patrol_index]
	var dist := global_position.distance_to(dest)
	if dist < 1.5:
		current_state = State.PATROL
		return

	var dir := (dest - global_position).normalized()
	velocity.x = dir.x * walk_speed
	velocity.z = dir.z * walk_speed
	_look_towards(dest)


func _look_towards(target_pos: Vector3) -> void:
	var look_at_pos := Vector3(target_pos.x, global_position.y, target_pos.z)
	if global_position.distance_to(look_at_pos) > 0.1:
		look_at(look_at_pos, Vector3.UP)
