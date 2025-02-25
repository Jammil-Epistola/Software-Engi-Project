extends CanvasLayer

@onready var image_display = $Control/Panel/TextureRect
@onready var text_display = $Control/Panel/Label
@onready var prev_button = $Control/Panel/PrevBtn
@onready var next_button = $Control/Panel/NextBtn
@onready var start_btn: Button = $Control/Panel/StartBtn

var slides = [
	{"image": preload("res://Assets/Sprites/Instructions/1.png"), "text": "Press A and D to move left or right."},
	{"image": preload("res://Assets/Sprites/Instructions/2.png"), "text": "Press Space/W to Jump."},
	{"image": preload("res://Assets/Sprites/Instructions/3.png"), "text": "Press LShift to Dash."},
	{"image": preload("res://Assets/Sprites/Instructions/4.png"), "text": "Wall jump by jumping near a wall."},
	{"image": preload("res://Assets/Sprites/Instructions/5.png"), "text": "Eliminate the mushroom by jumping on it."},
	{"image": preload("res://Assets/Sprites/Instructions/6.png"), "text": "Reach the Door or Portal to the next level."}
]

var current_slide = 0

func _ready():
	start_btn.hide()  # Hide the start button initially
	update_slide()

func update_slide():
	image_display.texture = slides[current_slide]["image"]
	text_display.text = slides[current_slide]["text"]

	prev_button.disabled = (current_slide == 0)
	next_button.disabled = (current_slide == slides.size() - 1)

	# Show "Press Any Key to Start" button when on last slide
	if current_slide == slides.size() - 1:
		start_btn.show()
		prev_button.hide()
		next_button.hide()
		set_process_input(true)  # Start listening for key inputs
	else:
		start_btn.hide()
		next_button.show()
		set_process_input(false)  # Stop listening when not on last slide

func _on_prev_btn_pressed() -> void:
	if current_slide > 0:
		current_slide -= 1
		update_slide()

func _on_next_btn_pressed() -> void:
	if current_slide < slides.size() - 1:
		current_slide += 1
		update_slide()

func _on_start_btn_pressed() -> void:
	start_game()

func _input(event):
	if start_btn.visible and event.is_pressed():
		start_game()

func start_game():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
