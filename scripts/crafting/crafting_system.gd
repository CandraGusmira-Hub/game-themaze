extends Node
# CraftingSystem — Validates and processes crafting recipes against inventory.
#
# Rules (TECHNICAL_DESIGN.md Section 9):
# - Validates that all materials exist in required counts before deducting
# - Consistent atomic execution: no items lost on failure

class_name CraftingSystem

signal item_crafted(recipe_id: String, output_item_id: String, count: int)
signal crafting_failed(recipe_id: String, reason: String)


static func can_craft(recipe: RecipeDefinition, inventory: InventoryComponent) -> bool:
	if recipe == null or inventory == null:
		return false

	for mat_id in recipe.required_materials.keys():
		var req_count: int = recipe.required_materials[mat_id]
		if not inventory.has_item(mat_id, req_count):
			return false

	return true


static func craft(recipe: RecipeDefinition, inventory: InventoryComponent) -> bool:
	if recipe == null or inventory == null:
		return false

	if not can_craft(recipe, inventory):
		print("[Crafting] Insufficient materials for recipe '%s'." % recipe.recipe_id)
		return false

	# Deduct all required materials
	for mat_id in recipe.required_materials.keys():
		var req_count: int = recipe.required_materials[mat_id]
		inventory.remove_item(mat_id, req_count)

	# Add output item
	inventory.add_item(recipe.output_item_id, recipe.output_quantity)
	print("[Crafting] Successfully crafted %dx '%s'." % [recipe.output_quantity, recipe.output_item_id])
	return true
