extends AudioStreamPlayer

const menu_music = preload("res://Assets/BGMs/HeatleyBros - HeatleyBros VI - 8 Bit Play - Loop Version.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()

func play_music_level():
	_play_music(menu_music)
