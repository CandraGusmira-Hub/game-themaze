extends Resource
# ItemDefinition — Static definition for an item type.
# Stored as .tres resources in res://resources/items/

class_name ItemDefinition

@export var item_id: String = ""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var icon: Texture2D
@export var max_stack: int = 99
@export_enum("material", "consumable", "tool", "placeable") var item_type: String = "material"

# Consumable effects (applied when consumed via Inventory)
@export var is_consumable: bool = false
@export var health_restore: float = 0.0
@export var hunger_restore: float = 0.0
@export var thirst_restore: float = 0.0
