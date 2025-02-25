extends Control

func _on_default_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/level_select.tscn")


func _on_custom_btn_pressed() -> void:
	# Hide the other tabs
	$options_tab/VBoxContainer/Audio.visible = false
	$options_tab/VBoxContainer/Language.visible = false
	$options_tab/VBoxContainer/Accessibility.visible = false
	
	# Ensure Controls tab is shown
	$options_tab/TabContainer/ControlsTab.visible = true
	$options_tab/BackBtn.visible = true
	$options_tab/ConfirmBtn.visible = true
	$Bg/DefaultPanel.visible = false
	$Bg/CustomPanel.visible = false
	
	# Show the Options Menu
	$options_tab.show()


func _on_confirm_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/level_select.tscn")


func _on_back_btn_pressed() -> void:
	$options_tab.hide()
	$Bg/DefaultPanel.show()
	$Bg/CustomPanel.show()
