extends Control
# HUD — Handles on-screen survival vitals, interaction prompts, and inventory UI.

class_name HUD

@onready var health_bar: ProgressBar = $VitalsContainer/HealthBar
@onready var hunger_bar: ProgressBar = $VitalsContainer/HungerBar
@onready var thirst_bar: ProgressBar = $VitalsContainer/ThirstBar
@onready var stamina_bar: ProgressBar = $VitalsContainer/StaminaBar

@onready var prompt_label: Label = $CenterContainer/PromptLabel
@onready var inventory_panel: PanelContainer = $InventoryPanel
@onready var item_list: ItemList = $InventoryPanel/VBoxContainer/ItemList
@onready var use_button: Button = $InventoryPanel/VBoxContainer/ButtonHBox/UseButton

@onready var dialogue_panel: PanelContainer = $DialoguePanel
@onready var speaker_label: Label = $DialoguePanel/VBoxContainer/SpeakerLabel
@onready var dialogue_text: Label = $DialoguePanel/VBoxContainer/DialogueText
@onready var dialogue_dismiss_btn: Button = $DialoguePanel/VBoxContainer/DismissButton

@onready var pause_panel: PanelContainer = $PausePanel
@onready var resume_btn: Button = $PausePanel/VBoxContainer/ResumeButton
@onready var save_btn: Button = $PausePanel/VBoxContainer/SaveButton
@onready var load_btn: Button = $PausePanel/VBoxContainer/LoadButton
@onready var quit_btn: Button = $PausePanel/VBoxContainer/QuitButton

var player: PlayerController = null
var survival: SurvivalComponent = null
var inventory: InventoryComponent = null


func _ready() -> void:
	prompt_label.text = ""
	inventory_panel.visible = false
	if dialogue_panel:
		dialogue_panel.visible = false
		dialogue_dismiss_btn.pressed.connect(close_dialogue)
	use_button.pressed.connect(_on_use_button_pressed)

	if pause_panel:
		pause_panel.visible = false
		resume_btn.pressed.connect(toggle_pause)
		save_btn.pressed.connect(_on_save_pressed)
		load_btn.pressed.connect(_on_load_pressed)
		quit_btn.pressed.connect(_on_quit_pressed)

	# Locate player in the active scene tree
	await get_tree().process_frame
	_find_and_connect_player()


func _find_and_connect_player() -> void:
	var players := get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0] as PlayerController
	else:
		# Fallback: search by type
		player = get_tree().root.find_child("Player", true, false) as PlayerController

	if player:
		survival = player.get_node_or_null("SurvivalComponent")
		inventory = player.get_node_or_null("InventoryComponent")

		if survival:
			survival.health_changed.connect(_on_health_changed)
			survival.hunger_changed.connect(_on_hunger_changed)
			survival.thirst_changed.connect(_on_thirst_changed)
			survival.stamina_changed.connect(_on_stamina_changed)

			health_bar.value = survival.health
			hunger_bar.value = survival.hunger
			thirst_bar.value = survival.thirst
			stamina_bar.value = survival.stamina

		if inventory:
			inventory.inventory_updated.connect(_update_inventory_display)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		_toggle_inventory()
	elif event.is_action_pressed("pause"):
		toggle_pause()


func toggle_pause() -> void:
	if pause_panel == null:
		return
	var is_paused := not pause_panel.visible
	pause_panel.visible = is_paused

	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		if not inventory_panel.visible and not dialogue_panel.visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_save_pressed() -> void:
	SaveManager.save_game(player)


func _on_load_pressed() -> void:
	SaveManager.load_game(player)
	toggle_pause()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _process(_delta: float) -> void:
	_update_interaction_prompt()


func _update_interaction_prompt() -> void:
	if player == null or player.interaction_ray == null:
		prompt_label.text = ""
		return

	if player.interaction_ray.is_colliding():
		var col := player.interaction_ray.get_collider()
		var node: Node = col as Node
		while node != null:
			if node is Interactable:
				prompt_label.text = (node as Interactable).get_interaction_prompt()
				return
			node = node.get_parent()

	prompt_label.text = ""


func _toggle_inventory() -> void:
	var is_open: bool = not inventory_panel.visible
	inventory_panel.visible = is_open

	if is_open:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		_update_inventory_display()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _update_inventory_display() -> void:
	if item_list == null or inventory == null:
		return

	item_list.clear()
	var all_items := inventory.get_all_items()

	for item_id in all_items.keys():
		var count: int = all_items[item_id]
		var def := inventory.get_definition(item_id)
		var display_name: String = def.display_name if def else item_id.capitalize()
		var text: String = "%s (x%d)" % [display_name, count]
		var idx: int = item_list.add_item(text)
		item_list.set_item_metadata(idx, item_id)


func _on_use_button_pressed() -> void:
	var selected := item_list.get_selected_items()
	if selected.size() == 0 or inventory == null or player == null:
		return

	var idx: int = selected[0]
	var item_id: String = str(item_list.get_item_metadata(idx))
	inventory.use_item(item_id, player)


func show_dialogue(npc_name: String, message: String) -> void:
	if dialogue_panel == null:
		return
	speaker_label.text = npc_name
	dialogue_text.text = message
	dialogue_panel.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func close_dialogue() -> void:
	if dialogue_panel:
		dialogue_panel.visible = false
	if not inventory_panel.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_health_changed(val: float, max_val: float) -> void:
	health_bar.max_value = max_val
	health_bar.value = val


func _on_hunger_changed(val: float, max_val: float) -> void:
	hunger_bar.max_value = max_val
	hunger_bar.value = val


func _on_thirst_changed(val: float, max_val: float) -> void:
	thirst_bar.max_value = max_val
	thirst_bar.value = val


func _on_stamina_changed(val: float, max_val: float) -> void:
	stamina_bar.max_value = max_val
	stamina_bar.value = val
