extends Node
# WorldTimeManager — Autoload managing world time and day/night progression.
#
# Rules (TECHNICAL_DESIGN.md Section 4 & GDD Section 6.5):
# - 24-hour clock cycle
# - Gradual lighting transitions
# - Night cycle triggers increased danger and Maze gate behavior

signal time_changed(hour: int, minute: int)
signal day_night_transition(is_night: bool)

# Time speed: 1.0 means 1 real second = 1 in-game minute (24-minute full day)
@export var minutes_per_second: float = 1.0

# Current time in hours (0.0 to 24.0). Starts at 08:00 (Morning)
var current_hour_decimal: float = 8.0
var is_night: bool = false

var _sun_light: DirectionalLight3D = null


func _ready() -> void:
	await get_tree().process_frame
	_find_sun()


func _physics_process(delta: float) -> void:
	current_hour_decimal += (minutes_per_second / 60.0) * delta
	if current_hour_decimal >= 24.0:
		current_hour_decimal -= 24.0

	var hour: int = int(current_hour_decimal)
	var minute: int = int((current_hour_decimal - hour) * 60.0)
	time_changed.emit(hour, minute)

	var was_night := is_night
	is_night = (current_hour_decimal >= 20.0 or current_hour_decimal < 6.0)

	if is_night != was_night:
		day_night_transition.emit(is_night)
		print("[WorldTime] Shifted to %s at %02d:%02d" % ["NIGHT" if is_night else "DAY", hour, minute])

	_update_sun_lighting()


func _find_sun() -> void:
	var suns := get_tree().get_nodes_in_group("sun")
	if suns.size() > 0:
		_sun_light = suns[0] as DirectionalLight3D
	else:
		_sun_light = get_tree().root.find_child("Sun", true, false) as DirectionalLight3D


func _update_sun_lighting() -> void:
	if _sun_light == null:
		return

	# Map 0..24 hours to sun angle (-90 sunrise at 6:00, 0 noon at 12:00, 90 sunset at 18:00)
	var sun_angle_deg := (current_hour_decimal - 6.0) * (360.0 / 24.0)
	_sun_light.rotation_degrees.x = -sun_angle_deg

	if is_night:
		_sun_light.light_energy = 0.08
		_sun_light.light_color = Color(0.15, 0.2, 0.35)
	else:
		# Day sunlight
		var peak_factor: float = clamp(sin(deg_to_rad(sun_angle_deg)), 0.1, 1.0)
		_sun_light.light_energy = 1.2 * peak_factor
		_sun_light.light_color = Color(1.0, 0.96, 0.88)
