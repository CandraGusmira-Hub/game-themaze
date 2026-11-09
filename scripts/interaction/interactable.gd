extends Node3D
# Interactable — Base class for all interactable objects.
# Every object the player can interact with must extend this class.
#
# Usage:
#   class_name MyObject
#   extends Interactable
#
#   func interact(_interactor: Node) -> void:
#       # your logic here
#
#   func get_interaction_prompt() -> String:
#       return "Press [E] to open"

class_name Interactable


# Override in subclasses to define what happens when the player interacts.
# interactor: the Node that triggered the interaction (usually the player).
func interact(_interactor: Node) -> void:
	pass


# Override in subclasses to provide a contextual prompt shown on the HUD.
# Returns an empty string by default (no prompt shown).
func get_interaction_prompt() -> String:
	return ""
