extends Node
# InventoryComponent — Manages the player's stored items.
#
# Rules (TECHNICAL_DESIGN.md Section 8):
# - Stores items by string item_id and integer count (not by display_name)
# - Validates item presence before removing
# - Handles consumables by applying effects to the owner's SurvivalComponent

class_name InventoryComponent

signal inventory_updated
signal item_added(item_id: String, count: int)
signal item_removed(item_id: String, count: int)
signal item_used(item_id: String)

@export var max_slots: int = 20

# Internal storage: { item_id: String -> count: int }
var _items: Dictionary = {}

# Cached definitions: { item_id: String -> ItemDefinition }
var _definitions: Dictionary = {}


func _ready() -> void:
	_load_registered_definitions()


func _load_registered_definitions() -> void:
	# Pre-load known MVP items
	var known_items: Array[String] = ["wood", "cloth", "bandage", "basic_torch", "water_flask"]
	for id in known_items:
		var path := "res://resources/items/" + id + ".tres"
		if ResourceLoader.exists(path):
			_definitions[id] = load(path)


func get_definition(item_id: String) -> ItemDefinition:
	if _definitions.has(item_id):
		return _definitions[item_id]
	var path := "res://resources/items/" + item_id + ".tres"
	if ResourceLoader.exists(path):
		var def: ItemDefinition = load(path)
		_definitions[item_id] = def
		return def
	return null


func add_item(item_id: String, count: int = 1) -> bool:
	if count <= 0:
		return false

	var current: int = _items.get(item_id, 0)
	_items[item_id] = current + count
	item_added.emit(item_id, count)
	inventory_updated.emit()
	print("[Inventory] Added %dx '%s'. Total: %d" % [count, item_id, _items[item_id]])
	return true


func remove_item(item_id: String, count: int = 1) -> bool:
	if count <= 0 or not has_item(item_id, count):
		return false

	_items[item_id] -= count
	if _items[item_id] <= 0:
		_items.erase(item_id)

	item_removed.emit(item_id, count)
	inventory_updated.emit()
	print("[Inventory] Removed %dx '%s'." % [count, item_id])
	return true


func has_item(item_id: String, count: int = 1) -> bool:
	return _items.get(item_id, 0) >= count


func get_item_count(item_id: String) -> int:
	return _items.get(item_id, 0)


func get_all_items() -> Dictionary:
	return _items.duplicate()


func use_item(item_id: String, target_actor: Node = null) -> bool:
	if not has_item(item_id, 1):
		print("[Inventory] Cannot use '%s': item not in inventory." % item_id)
		return false

	var def := get_definition(item_id)
	if def == null or not def.is_consumable:
		print("[Inventory] Item '%s' is not consumable." % item_id)
		return false

	var actor: Node = target_actor if target_actor != null else get_parent()
	var survival: SurvivalComponent = null

	if actor:
		survival = actor.get_node_or_null("SurvivalComponent")

	if survival:
		if def.health_restore > 0:
			survival.heal(def.health_restore)
		if def.hunger_restore > 0:
			survival.restore_hunger(def.hunger_restore)
		if def.thirst_restore > 0:
			survival.restore_thirst(def.thirst_restore)

		remove_item(item_id, 1)
		item_used.emit(item_id)
		print("[Inventory] Consumed '%s'." % item_id)
		return true

	return false
