extends Interactable
# PickupItem — 3D world item that can be picked up into inventory.
# Extends Interactable for RayCast interaction.

class_name PickupItem

@export var item_id: String = "wood"
@export var count: int = 1


func interact(interactor: Node) -> void:
	if interactor == null:
		return

	var inventory: InventoryComponent = interactor.get_node_or_null("InventoryComponent")
	if inventory:
		var success := inventory.add_item(item_id, count)
		if success:
			print("[Pickup] %s picked up %dx %s" % [interactor.name, count, item_id])
			queue_free()
	else:
		print("[Pickup] Interactor %s has no InventoryComponent." % interactor.name)


func get_interaction_prompt() -> String:
	return "Press [E] to pick up %s" % item_id.capitalize()
