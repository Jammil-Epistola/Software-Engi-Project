extends Control

func _ready():
	self.visible = false

func resume():
	get_tree().paused = false
	self.visible = false

func pause():
	get_tree().paused = true
	self.visible = true

func testEsc():
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_continue_button_pressed() -> void:
	resume()

func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_return_button_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _process(delta):
	testEsc()
