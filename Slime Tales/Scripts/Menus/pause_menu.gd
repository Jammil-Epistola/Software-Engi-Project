extends Control

@onready var options_tab_menu = $options_tab
@onready var pause_menu = $PanelContainer

func _ready():
	self.visible = false
	options_tab_menu.visible = false

func resume():
	get_tree().paused = false
	self.visible = false
	options_tab_menu.visible = false

func pause():
	get_tree().paused = true
	self.visible = true
	options_tab_menu.visible = false
	

func testEsc():
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_help_button_pressed() -> void:
	pause_menu.visible = false

func _on_continue_button_pressed() -> void:
	resume()

func _on_options_button_pressed() -> void:
	options_tab_menu.visible = true
	pause_menu.visible = false
	
func _on_back_pressed() -> void:
	options_tab_menu.visible = false
	pause_menu.visible = true
	
func _on_return_button_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")
	

func _process(_delta):
	testEsc()
