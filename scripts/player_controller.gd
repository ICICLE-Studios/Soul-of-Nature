extends CharacterBody2D


const SPEED = 150.0

@onready var attack_group = %Attacks

var player_fireball_scene = preload("res://scenes/attacks/player_fireball.tscn")


func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()


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


func attack():
	var fireball_instance = player_fireball_scene.instantiate()
	fireball_instance.position = position
	attack_group.add_child(fireball_instance)
