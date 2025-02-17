extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var audio_stream_player_2d = $AudioStreamPlayer2D as AudioStreamPlayer2D
@onready var one_way_platforms = get_tree().get_nodes_in_group("one_way")

func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		audio_stream_player_2d.play()

	# Handle moving down through one-way platforms.
	if Input.is_action_just_pressed("move_down"):
		disable_one_way_collision()

	elif Input.is_action_just_released("move_down"):
		enable_one_way_collision()

	# Handle movement.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func disable_one_way_collision():
	for platform in get_tree().get_nodes_in_group("one_way"):
		var collision = platform.get_node_or_null("CollisionShape2D")
		if collision:
			collision.set_deferred("disabled", true)

func enable_one_way_collision():
	await get_tree().create_timer(0.2).timeout
	
	for platform in get_tree().get_nodes_in_group("one_way"):
		var collision = platform.get_node_or_null("CollisionShape2D")
		if collision:
			collision.set_deferred("disabled", false)
