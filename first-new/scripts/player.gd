extends KinematicBody2D

var velocity = Vector2()

func _ready():
	pass  # Player initialization or other setup

func _process(delta):
	velocity = Vector2()  # Reset velocity each frame
	
	# Handle movement
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	# Move the player (with collision)
	velocity = move_and_slide(velocity)

	# Check if the player is touching a boundary (collision with boundary tiles)
	if is_on_wall():
		# Handle boundary hit logic (like stopping movement or bouncing back)
		print("Hit boundary!")
