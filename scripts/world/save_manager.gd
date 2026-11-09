extends Node
# SaveManager — Autoload singleton managing game persistence.
#
# Rules (TECHNICAL_DESIGN.md Section 13):
# - JSON formatted with schema_version
# - Validates data on loading
# - Handles missing or corrupt save files gracefully

signal save_completed(success: bool)
signal load_completed(success: bool)

const SAVE_PATH: String = "user://savegame.json"
const CURRENT_SCHEMA_VERSION: int = 1


func save_game(player: PlayerController = null, time_manager: Node = null) -> bool:
	var root := get_tree().root

	if player == null:
		player = root.find_child("Player", true, false) as PlayerController

	if time_manager == null:
		time_manager = root.find_child("WorldTimeManager", true, false) as WorldTimeManager

	var save_data: Dictionary = {
		"schema_version": CURRENT_SCHEMA_VERSION,
		"timestamp": Time.get_datetime_string_from_system(),
		"player": {},
		"inventory": {},
		"world_time": 8.0,
		"quest_progress": {}
	}

	if player:
		save_data["player"]["position"] = [
			player.global_position.x,
			player.global_position.y,
			player.global_position.z
		]
		var survival: SurvivalComponent = player.get_node_or_null("SurvivalComponent")
		if survival:
			save_data["player"]["health"] = survival.health
			save_data["player"]["hunger"] = survival.hunger
			save_data["player"]["thirst"] = survival.thirst
			save_data["player"]["stamina"] = survival.stamina

		var inv: InventoryComponent = player.get_node_or_null("InventoryComponent")
		if inv:
			save_data["inventory"] = inv.get_all_items()

	if time_manager:
		save_data["world_time"] = time_manager.current_hour_decimal

	var npc := root.find_child("NPC_Kaia", true, false) as NPCInteractable
	if npc:
		save_data["quest_progress"]["kaia_state"] = npc.quest_state

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		print("[SaveManager] Error opening save file for writing: %s" % FileAccess.get_open_error())
		save_completed.emit(false)
		return false

	var json_string := JSON.stringify(save_data, "  ")
	file.store_string(json_string)
	file.close()

	print("[SaveManager] Game saved successfully to: %s" % SAVE_PATH)
	save_completed.emit(true)
	return true


func load_game(player: PlayerController = null, time_manager: Node = null) -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		print("[SaveManager] No save file found at %s." % SAVE_PATH)
		load_completed.emit(false)
		return false

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		print("[SaveManager] Failed to read save file.")
		load_completed.emit(false)
		return false

	var content := file.get_as_text()
	file.close()

	var test_json_conv := JSON.new()
	var parse_err := test_json_conv.parse(content)
	if parse_err != OK:
		print("[SaveManager] Corrupt save file: JSON parse error.")
		load_completed.emit(false)
		return false

	var save_data: Dictionary = test_json_conv.data
	if not save_data.has("schema_version") or save_data["schema_version"] != CURRENT_SCHEMA_VERSION:
		print("[SaveManager] Unsupported or outdated save schema version.")
		load_completed.emit(false)
		return false

	var root := get_tree().root

	if player == null:
		player = root.find_child("Player", true, false) as PlayerController

	if time_manager == null:
		time_manager = root.find_child("WorldTimeManager", true, false) as WorldTimeManager

	if player and save_data.has("player"):
		var p_data: Dictionary = save_data["player"]
		if p_data.has("position"):
			var pos_arr: Array = p_data["position"]
			if pos_arr.size() == 3:
				player.global_position = Vector3(pos_arr[0], pos_arr[1], pos_arr[2])

		var survival: SurvivalComponent = player.get_node_or_null("SurvivalComponent")
		if survival:
			survival.health = p_data.get("health", 100.0)
			survival.hunger = p_data.get("hunger", 100.0)
			survival.thirst = p_data.get("thirst", 100.0)
			survival.stamina = p_data.get("stamina", 100.0)
			survival._emit_all()

		var inv: InventoryComponent = player.get_node_or_null("InventoryComponent")
		if inv and save_data.has("inventory"):
			inv._items = save_data["inventory"].duplicate()
			inv.inventory_updated.emit()

	if time_manager and save_data.has("world_time"):
		time_manager.current_hour_decimal = save_data["world_time"]

	var npc := root.find_child("NPC_Kaia", true, false) as NPCInteractable
	if npc and save_data.has("quest_progress"):
		npc.quest_state = save_data["quest_progress"].get("kaia_state", 0)

	print("[SaveManager] Game loaded successfully.")
	load_completed.emit(true)
	return true
