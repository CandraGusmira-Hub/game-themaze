extends Node3D
# MazeGate — Controls the primary gate dividing The Glade and The Outer Maze.
# Implements the safe transition protocol required by TECHNICAL_DESIGN.md.

class_name MazeGate

signal gate_opened
signal gate_closed

@export var is_open: bool = true
@export var move_speed: float = 2.0

@onready var gate_door: AnimatableBody3D = $GateDoor
@onready var safety_area: Area3D = $SafetyArea

var _target_y: float = 0.0
var _closed_y: float = 0.0
var _open_y: float = 5.0


func _ready() -> void:
	_closed_y = 0.0
	_open_y = 5.0
	_target_y = _open_y if is_open else _closed_y
	if gate_door:
		gate_door.position.y = _target_y


func _physics_process(delta: float) -> void:
	if gate_door:
		gate_door.position.y = move_toward(gate_door.position.y, _target_y, move_speed * delta)


func open_gate() -> void:
	_target_y = _open_y
	is_open = true
	gate_opened.emit()


func close_gate() -> bool:
	# Safety check: do not close if an actor is inside the doorway area
	if safety_area and safety_area.has_overlapping_bodies():
		for body in safety_area.get_overlapping_bodies():
			if body is CharacterBody3D:
				print("[MazeGate] Safety warning: actor detected in threshold, refusing to close.")
				return false

	_target_y = _closed_y
	is_open = false
	gate_closed.emit()
	return true


func toggle_gate() -> bool:
	if is_open:
		return close_gate()
	else:
		open_gate()
		return true
