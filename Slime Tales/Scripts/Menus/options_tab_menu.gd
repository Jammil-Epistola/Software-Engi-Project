extends Node


func _on_controls_pressed() -> void:
	$TabContainer.current_tab = 0


func _on_audio_pressed() -> void:
	$TabContainer.current_tab = 1


func _on_language_pressed() -> void:
	$TabContainer.current_tab = 2


func _on_accessibility_pressed() -> void:
	$TabContainer.current_tab = 3
