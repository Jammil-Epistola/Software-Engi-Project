extends Control

@export var level_number: int = 1  

func _ready():
	var button = $LevelBtn  
	button.text = str(level_number)  

	# Prevent duplicate connections
	if not button.pressed.is_connected(_on_level_btn_pressed):
		button.pressed.connect(_on_level_btn_pressed)

func _on_level_btn_pressed():
	# Get the Level Select node dynamically
	var level_select = get_parent().get_parent()  # Assuming it's two levels up

	if level_select and level_select.has_method("_on_level_button_pressed"):
		level_select._on_level_button_pressed(level_number)  # Call function in Level Select
	else:
		print("Error: Level Select node not found!")
