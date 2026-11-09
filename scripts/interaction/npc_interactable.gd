extends Interactable
# NPCInteractable — Handles NPC dialogue and quest progression upon player interaction.

class_name NPCInteractable

signal dialogue_opened(npc_name: String, text: String)

@export var character_name: String = "Kaia (The Scout)"
@export var quest: QuestDefinition

var quest_state: int = QuestDefinition.QuestState.NOT_STARTED


func interact(interactor: Node) -> void:
	if interactor == null or quest == null:
		return

	var inventory: InventoryComponent = interactor.get_node_or_null("InventoryComponent")
	var message := ""

	match quest_state:
		QuestDefinition.QuestState.NOT_STARTED:
			quest_state = QuestDefinition.QuestState.IN_PROGRESS
			message = quest.dialogue_initial
			print("[Quest] Accepted: %s" % quest.title)

		QuestDefinition.QuestState.IN_PROGRESS:
			if inventory and inventory.has_item(quest.required_item_id, quest.required_count):
				# Complete quest
				inventory.remove_item(quest.required_item_id, quest.required_count)
				inventory.add_item(quest.reward_item_id, quest.reward_count)
				quest_state = QuestDefinition.QuestState.COMPLETED
				message = quest.dialogue_completed
				print("[Quest] Completed: %s! Rewarded %dx %s" % [quest.title, quest.reward_count, quest.reward_item_id])
			else:
				message = quest.dialogue_in_progress

		QuestDefinition.QuestState.COMPLETED:
			message = quest.dialogue_completed

	dialogue_opened.emit(character_name, message)

	# Display on HUD if available
	var hud := get_tree().root.find_child("HUD", true, false)
	if hud and hud.has_method("show_dialogue"):
		hud.show_dialogue(character_name, message)
	else:
		print("[%s]: %s" % [character_name, message])


func get_interaction_prompt() -> String:
	return "Press [E] to talk to %s" % character_name
