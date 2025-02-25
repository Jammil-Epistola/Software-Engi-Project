extends RigidBody2D

@onready var sfx_squish: AudioStreamPlayer = $Sfx/sfxSquish
@onready var enimi_anim = $AnimatedSprite2D
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):  # Make sure your player is in the "player" group
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if (y_delta > 18):
			print("enimi kill")
			body.enemybounce()
			sfx_squish.play()
			enimi_anim.play("hit")
			
			await get_tree().create_timer(sfx_squish.stream.get_length()).timeout
			queue_free()  # Now delete the enemy
		else:
			print("player lose heart")
			GameManager.decrease_health()
			if (x_delta > 0):
				body.playerhitknockback(800)
			else:
				body.playerhitknockback(-800)
