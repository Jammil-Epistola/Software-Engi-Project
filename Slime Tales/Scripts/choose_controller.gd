extends Control


func _on_keyboard_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/test_level.tscn")


func _on_controller_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/test_level.tscn")
