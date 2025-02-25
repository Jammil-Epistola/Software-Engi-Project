extends AudioStreamPlayer

const menu_music = preload("res://Assets/BGMs/HeatleyBros - HeatleyBros VI - 8 Bit Play - Loop Version.mp3")
const level_music = preload("res://Assets/BGMs/HeatleyBros - HeatleyBros VI - Simple Fun.mp3")  

func _ready():
	# Make sure MusicPlayer persists across scenes
	get_tree().root.child_entered_tree.connect(_on_scene_changed)
	_on_scene_changed(get_tree().current_scene)

func _on_scene_changed(_node):
	var current_scene = get_tree().current_scene
	if current_scene == null:
		return  

	# Get scene file path (same approach as your next level script)
	var current_scene_file = current_scene.scene_file_path

	if "Main Menu" in current_scene_file:
		_play_music(menu_music)
	elif "level_" in current_scene_file:
		_play_music(level_music)

func _play_music(music: AudioStream, volume = -10.0):
	if stream == music:
		return  # Don't restart if the same music is already playing

	stream = music
	volume_db = volume
	play()
