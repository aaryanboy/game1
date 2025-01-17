extends CharacterBody2D

@export var speed = 100  # Player movement speed

# Reference to the AnimatedSprite2D node
@onready var animated_sprite = $AnimatedSprite2D

# Track player state
var is_attacking = false  # Check if the player is currently attacking
var last_direction = "idle front"  # Keep track of the last direction

func _physics_process(delta):
	# Handle attack
	if Input.is_action_just_pressed("ui_select") and not is_attacking:
		play_attack_animation()
		return  # Skip movement while attacking

	# Handle player movement
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		animated_sprite.flip_h = false  # Reset horizontal flip
		last_direction = "walk right"
		animated_sprite.play("walk right")
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		animated_sprite.flip_h = true  # Flip sprite for left
		last_direction = "walk left"
		animated_sprite.play("walk left")
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
		animated_sprite.flip_h = false  # Reset horizontal flip
		last_direction = "walk front"
		animated_sprite.play("walk front")
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		animated_sprite.flip_h = false  # Reset horizontal flip
		last_direction = "walk back"
		animated_sprite.play("walk back")
	else:
		# Handle idle states
		if direction.x == 0 and direction.y == 0 and not is_attacking:
			if "walk" in last_direction:
				last_direction = last_direction.replace("walk", "idle")
			animated_sprite.play(last_direction)

	# Apply movement
	if not is_attacking:
		velocity = direction.normalized() * speed
		move_and_slide()

func play_attack_animation():
	is_attacking = true

	# Determine the attack animation based on the last direction
	match last_direction:
		"idle right", "walk right":
			animated_sprite.flip_h = false  # Reset flip
			animated_sprite.play("attack right")
		"idle left", "walk left":
			animated_sprite.flip_h = true  # Flip sprite
			animated_sprite.play("attack left")
		"idle front", "walk front":
			animated_sprite.flip_h = false  # Reset flip
			animated_sprite.play("attack front")
		"idle back", "walk back":
			animated_sprite.flip_h = false  # Reset flip
			animated_sprite.play("attack back")

	# Wait for the attack animation to finish
	$AnimatedSprite2D.animation_finished.connect(on_attack_finished)

func on_attack_finished():
	is_attacking = false
	$AnimatedSprite2D.animation_finished.disconnect(on_attack_finished)
