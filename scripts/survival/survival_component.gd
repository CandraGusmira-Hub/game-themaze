extends Node
# SurvivalComponent — Manages player core survival attributes:
# Health, Hunger, Thirst, and Stamina.
#
# Rules (TECHNICAL_DESIGN.md Section 7):
# - Separated from PlayerController
# - Bounds: 0 to 100
# - Hunger & Thirst tick down over time
# - Starvation/Dehydration gradually damages Health
# - Stamina regenerates when not sprinting

class_name SurvivalComponent

signal health_changed(current: float, max_val: float)
signal hunger_changed(current: float, max_val: float)
signal thirst_changed(current: float, max_val: float)
signal stamina_changed(current: float, max_val: float)
signal player_died

const MAX_VALUE: float = 100.0

@export var max_health: float = 100.0
@export var max_hunger: float = 100.0
@export var max_thirst: float = 100.0
@export var max_stamina: float = 100.0

# Decay & regen rates (units per real-time second)
@export var hunger_decay_rate: float = 0.5     # ~200 seconds for full bar
@export var thirst_decay_rate: float = 0.8     # ~125 seconds for full bar
@export var stamina_regen_rate: float = 15.0   # recovers from 0 in ~6.6 seconds
@export var sprint_stamina_cost: float = 20.0  # ~5 seconds of continuous sprinting
@export var critical_damage_rate: float = 2.0  # damage/sec when starved/dehydrated

var health: float = 100.0
var hunger: float = 100.0
var thirst: float = 100.0
var stamina: float = 100.0

var _is_sprinting_this_frame: bool = false
var _is_dead: bool = false


func _ready() -> void:
	health = max_health
	hunger = max_hunger
	thirst = max_thirst
	stamina = max_stamina
	_emit_all()


func _physics_process(delta: float) -> void:
	if _is_dead:
		return

	# Decay hunger and thirst
	hunger = max(0.0, hunger - hunger_decay_rate * delta)
	thirst = max(0.0, thirst - thirst_decay_rate * delta)

	hunger_changed.emit(hunger, max_hunger)
	thirst_changed.emit(thirst, max_thirst)

	# Stamina handling
	if _is_sprinting_this_frame:
		stamina = max(0.0, stamina - sprint_stamina_cost * delta)
		stamina_changed.emit(stamina, max_stamina)
	else:
		if stamina < max_stamina:
			stamina = min(max_stamina, stamina + stamina_regen_rate * delta)
			stamina_changed.emit(stamina, max_stamina)

	# Starvation / Dehydration penalty
	if hunger <= 0.0 or thirst <= 0.0:
		take_damage(critical_damage_rate * delta)

	_is_sprinting_this_frame = false


func consume_sprint_stamina() -> bool:
	if stamina > 2.0:
		_is_sprinting_this_frame = true
		return true
	return false


func has_stamina() -> bool:
	return stamina > 2.0


func take_damage(amount: float) -> void:
	if _is_dead:
		return
	health = max(0.0, health - amount)
	health_changed.emit(health, max_health)
	if health <= 0.0:
		_die()


func heal(amount: float) -> void:
	if _is_dead:
		return
	health = min(max_health, health + amount)
	health_changed.emit(health, max_health)


func restore_hunger(amount: float) -> void:
	hunger = min(max_hunger, hunger + amount)
	hunger_changed.emit(hunger, max_hunger)


func restore_thirst(amount: float) -> void:
	thirst = min(max_thirst, thirst + amount)
	thirst_changed.emit(thirst, max_thirst)


func _die() -> void:
	_is_dead = true
	print("[Survival] Player has died.")
	player_died.emit()


func _emit_all() -> void:
	health_changed.emit(health, max_health)
	hunger_changed.emit(hunger, max_hunger)
	thirst_changed.emit(thirst, max_thirst)
	stamina_changed.emit(stamina, max_stamina)
