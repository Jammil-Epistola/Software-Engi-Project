extends Control

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")


func _on_yt_link_pressed() -> void:
	OS.shell_open("https://www.youtube.com/user/HeatleyBros")
