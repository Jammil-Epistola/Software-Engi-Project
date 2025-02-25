extends CharacterBody2D

# Constants
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const DASH_SPEED = 300.0
const WALL_JUMP_FORCE = Vector2(100, -250)
const GRAVITY = 800.0
const MAX_FALL_SPEED = 500.0
const COYOTE_TIME = 0.15

# States
var is_dashing = false
var can_wall_jump = false
var coyote_timer = 0.0
var is_jumping = false

#Health Points
@export var maxHealth = 3
@onready var currentHealth: int = maxHealth

@onready var one_way_platforms = get_tree().get_nodes_in_group("one_way")
@onready var anim = $AnimatedSprite2D
@onready var GameManager = get_node("/root/GameManager") 

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_jump()
	handle_wall_mechanics()
	handle_dash()
	handle_movement()
	handle_animations()
	
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)

func enemybounce():
	velocity.y = JUMP_VELOCITY

func playerhitknockback(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x
	
func handle_jump():
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= get_process_delta_time()

	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer > 0.0):
		velocity.y = JUMP_VELOCITY
		$Sfx/sfxJump.play()
		coyote_timer = 0.0
		is_jumping = true  # Set flag to control animation transition
		anim.play("jumpfall")

func handle_wall_mechanics():
	if is_on_wall() and not is_on_floor():
		can_wall_jump = true

	if can_wall_jump and Input.is_action_just_pressed("jump"):
		velocity = WALL_JUMP_FORCE * Vector2(-sign(get_wall_normal().x), 1)
		can_wall_jump = false

func handle_dash():
	if Input.is_action_just_pressed("dash") and not is_dashing:
		is_dashing = true
		velocity.x = sign(velocity.x) * DASH_SPEED
		$Sfx/sfxDash.play()
		anim.play("dash")
		await get_tree().create_timer(0.2).timeout
		is_dashing = false

func handle_movement():
	if is_dashing:
		return

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle moving down through one-way platforms
	if Input.is_action_just_pressed("move_down"):
		disable_one_way_collision()
	elif Input.is_action_just_released("move_down"):
		enable_one_way_collision()

func disable_one_way_collision():
	for platform in one_way_platforms:
		var collision = platform.get_node_or_null("CollisionShape2D")
		if collision:
			collision.set_deferred("disabled", true)

func enable_one_way_collision():
	await get_tree().create_timer(0.2).timeout
	for platform in one_way_platforms:
		var collision = platform.get_node_or_null("CollisionShape2D")
		if collision:
			collision.set_deferred("disabled", false)

func handle_animations():
	if is_dashing:
		anim.play("dash")
		return

	if is_jumping:
		# Prevent fall animation until jump animation finishes
		if anim.animation != "jumpfall":
			is_jumping = false  # Reset flag when jump animation ends

	if not is_on_floor():
		if velocity.y < 0:
			if not is_jumping:
				anim.play("jumpfall")
		elif velocity.y > 0:
			if not is_jumping:
				anim.play("jumpfall")
	elif velocity.x != 0:
		anim.play("walk")
	else:
		anim.play("idle")

	# Flip sprite based on direction
	if velocity.x > 0:
		anim.flip_h = false
	elif velocity.x < 0:
		anim.flip_h = true

	# Wall stick animation
	if is_on_wall() and not is_on_floor():
		anim.play("wall_stick")

#Dead
func die():
	print("Player died. Playing death animation...")
	set_physics_process(false)  # Disable player movement
	set_process_input(false)    # Ignore input
	anim.play("dead") 
	await anim.animation_finished  # Wait for animation to finish
	await get_tree().create_timer(1.0).timeout  # Small delay
	GameManager.reload_scene()  # Now reload scene

func attack():
	if Input.is_action_just_pressed("attack"):
		anim.play("attack")
		await anim.animation_finished
