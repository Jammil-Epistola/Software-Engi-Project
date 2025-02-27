class_name HotkeyRebindButton
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button  

@export var action_name : String = "move_left"

func _ready():
	set_process_unhandled_input(false)
	set_action_name()
	set_text_for_key()
	
func set_action_name() -> void:
	label.text = "Unassigned"
	match action_name:
		"move_left":
			label.text = "Move Left"
		"move_right":
			label.text = "Move Right"
		"move_down":
			label.text = "Move Down"
		"jump":
			label.text = "Jump"
		"interact":
			label.text = "Interact"
		"attack":
			label.text = "Attack"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	if action_events.is_empty():
		button.text = "None"
		return
	
	var action_event = action_events[0]

	# Handle controller inputs
	if action_event is InputEventJoypadButton:
		button.text = "Gamepad " + str(action_event.button_index)
	elif action_event is InputEventJoypadMotion:
		button.text = "Joystick Axis " + str(action_event.axis)
	else:
		# Handle keyboard inputs
		button.text = OS.get_keycode_string(action_event.physical_keycode)


func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press any key..."
		set_process_unhandled_input(true)
		
		# Disable other buttons while rebinding
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_input(false)
		set_text_for_key()

func _unhandled_input(event):
	# Accept both keyboard and controller inputs
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventJoypadMotion:
		rebind_action_key(event)
		button.button_pressed = false
	
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)

	set_process_unhandled_input(false)
	set_text_for_key()
	set_action_name()
