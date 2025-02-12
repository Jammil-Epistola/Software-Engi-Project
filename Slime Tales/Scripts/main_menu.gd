extends Control

func _ready():
	MusicPlayer.play_music_level()
#Start
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/test_level.tscn")
	
#Option
func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Options Menu/options_menu.tscn")
	
#Exit
func _on_exit_button_pressed() -> void:
	get_tree().quit()
