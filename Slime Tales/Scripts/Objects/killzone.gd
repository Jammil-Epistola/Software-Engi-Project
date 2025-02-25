extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	var player = get_tree().current_scene.find_child("Player", true, false)
	if body == player:  # Check if the body is the player
		print("Killzone triggered, forcing death!")

		GameManager.reset_lives()  
		body.die()  

		timer.start()  

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
