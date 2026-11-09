extends Resource
# QuestDefinition — Static data structure for quests.
# Stored in res://resources/quests/

class_name QuestDefinition

enum QuestState {
	NOT_STARTED,
	IN_PROGRESS,
	COMPLETED
}

@export var quest_id: String = ""
@export var title: String = ""
@export_multiline var description: String = ""

# Objective requirement
@export var required_item_id: String = "wood"
@export var required_count: int = 3

# Completion reward
@export var reward_item_id: String = "bandage"
@export var reward_count: int = 1

# Dialogue strings for different states
@export_multiline var dialogue_initial: String = "You're finally awake. The Maze is dangerous, but we desperately need wood to reinforce our shelter. Bring me 3 wood branches from the corridors."
@export_multiline var dialogue_in_progress: String = "Have you found the wood yet? Be careful near the central monolith."
@export_multiline var dialogue_completed: String = "You made it back! This will keep our shelter secure for now. Take these supplies—you've earned them."
