extends CharacterBody2D

@export var speed = 100

# Reference to the AnimatedSprite2D node
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Handle player movement
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		animated_sprite.play("walk right")  # Play walk right animation
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		animated_sprite.play("walk left")  # Play walk left animation
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
		animated_sprite.play("walk front")  # Play walk front animation
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		animated_sprite.play("walk back")  # Play walk back animation
	else:
		animated_sprite.play("idle")  # Default to idle animation when not moving

	# Apply movement
	velocity = direction.normalized() * speed
	move_and_slide()
