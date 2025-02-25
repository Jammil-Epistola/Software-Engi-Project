extends Control


func _on_keyboard_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/choose_Keyboard_layout.tscn")


func _on_controller_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/choose_GamePad_layout.tscn")
