extends Control
@export var total_levels: int = 3  

const FILE_BEGIN = "res://Scenes/Levels/level_"
const BUTTON_SCENE = preload("res://Scenes/Objects/level_button.tscn")  
 

func generate_level_buttons():
	var grid = $LevelGrid
	for i in range(1, total_levels + 1):
		var button = BUTTON_SCENE.instantiate()  
		button.level_number = i  # Assign the exported variable
		grid.add_child(button)

func _on_level_button_pressed(level_number):
	if level_number == 1:
		var instruction_panel = load("res://Scenes/Main Menu/instruction_menu.tscn").instantiate()
		get_tree().current_scene.add_child(instruction_panel)
	else:
		get_tree().change_scene_to_file(FILE_BEGIN + str(level_number) + ".tscn")

func _ready():
	generate_level_buttons()

func _on_return_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")
