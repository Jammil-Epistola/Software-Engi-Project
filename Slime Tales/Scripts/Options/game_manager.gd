extends Node

const MAX_LIVES = 3
var lives = MAX_LIVES
var hearts = []
var player

func _ready():
	reset_lives()  
	setup_hearts() 
	find_player()  


func find_player():
	await get_tree().process_frame  # Wait for the scene to fully load
	player = get_tree().current_scene.find_child("Player", true, false)
	if not player:
		print("Error: Player reference is null!")


func reset_lives():
	lives = MAX_LIVES


func setup_hearts():
	var heart_ui = get_tree().current_scene.find_child("HeartUI", true, false)
	if not heart_ui:
		print("Warning: No HeartUI found in this scene. Skipping heart setup.")
		return  # Don't proceed if no UI exists (like in Main Menu)

	var heart_container = heart_ui.find_child("HBoxContainer", true, false)
	if heart_container:
		hearts = heart_container.get_children()
		print("Hearts setup complete:", hearts)

func update_hearts_ui():
	if hearts.is_empty():
		print("Warning: Hearts array is empty! Skipping UI update.")
		return  # Stop the function if no hearts exist

	for h in range(3):
		if hearts[h]:  
			if h < lives:
				hearts[h].show()
			else:
				hearts[h].hide()

func decrease_health():
	if lives <= 0:
		print("Player already dead, ignoring damage")
		return

	lives -= 1
	print("player lose heart")
	update_hearts_ui()

	if lives <= 0:
		if player:
			player.die()
		else:
			print("Error: Player reference is null!")
			
func reload_scene():
	print("Reloading scene...")
	get_tree().reload_current_scene()
