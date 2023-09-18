extends CharacterBody2D


const SPEED = 150.0
const SPRITE_PATH_BASE = "res://sprites/characters/PlayerSoul/ElementsSoulPlayer%s.png"

@onready var sprite = $Sprite
@onready var attack_group = %Attacks

# Load the corresponding Player Sprites
@onready var look_down_sprite = load(SPRITE_PATH_BASE % "1")
@onready var look_down_right_sprite = load(SPRITE_PATH_BASE % "2")
@onready var look_right_sprite = load(SPRITE_PATH_BASE % "3")
@onready var look_up_right_sprite = load(SPRITE_PATH_BASE % "4")
@onready var look_up_sprite = load(SPRITE_PATH_BASE % "5")
@onready var look_up_left_sprite = load(SPRITE_PATH_BASE % "6")
@onready var look_left_sprite = load(SPRITE_PATH_BASE % "7")
@onready var look_down_left_sprite = load(SPRITE_PATH_BASE % "8")

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
	look_at_target_direction()


func attack():
	var fireball_instance = player_fireball_scene.instantiate()
	fireball_instance.position = position
	attack_group.add_child(fireball_instance)


func look_at_target_direction():
	var direction = Vector2(get_global_mouse_position() - position).normalized()
	
	if direction.y < -0.35 and direction.x > 0.35:
		sprite.texture = look_up_right_sprite
	elif direction.y < -0.35 and direction.x < -0.35:
		sprite.texture = look_up_left_sprite
	elif direction.y > 0.35 and direction.x > 0.35:
		sprite.texture = look_down_right_sprite
	elif direction.y > 0.35 and direction.x < -0.35:
		sprite.texture = look_down_left_sprite
	elif direction.y > 0.35:
		sprite.texture = look_down_sprite
	elif direction.y < -0.35:
		sprite.texture = look_up_sprite
	elif direction.x > 0:
		sprite.texture = look_right_sprite
	elif direction.x < 0:
		sprite.texture = look_left_sprite
