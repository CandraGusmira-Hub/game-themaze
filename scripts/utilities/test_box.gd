extends Interactable
# TestBox — Validation object for Phase 1 controller testing.
# Remove or replace after Phase 1 validation is complete.

class_name TestBox


func interact(interactor: Node) -> void:
	print("[TestBox] Interaction triggered by: ", interactor.name)


func get_interaction_prompt() -> String:
	return "Press [E] to interact"
