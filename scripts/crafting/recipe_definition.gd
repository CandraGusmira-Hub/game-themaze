extends Resource
# RecipeDefinition — Static data resource defining a crafting recipe.
# Stored in res://resources/recipes/

class_name RecipeDefinition

@export var recipe_id: String = ""
@export var display_name: String = ""
@export var output_item_id: String = ""
@export var output_quantity: int = 1

# Dictionary of { item_id: String -> count: int }
@export var required_materials: Dictionary = {}
