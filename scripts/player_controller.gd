extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta):
	var horizontalInput = Input.get_axis("ui_left", "ui_right")
	var verticalInput = Input.get_axis("ui_up", "ui_down")
	
	if horizontalInput:
		velocity.x = horizontalInput * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if verticalInput:
		velocity.y = verticalInput * SPEED 
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

