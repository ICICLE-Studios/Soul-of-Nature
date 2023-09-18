extends CharacterBody2D

enum Element {
	WATER,
	FIRE,
	PLANT,
	ELECTRIC
}

signal player_changed_element(new_element : Element)
signal player_leveled_up(new_player_level : int)

const SPEED = 150.0
const SPRITE_PATH_BASE = "res://sprites/characters/PlayerSoul/ElementsSoulPlayer%s.png"

@onready var sprite = $Sprite
@onready var level_label = $LevelLabel
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

var selected_element : Element = Element.PLANT
var current_level = 1
var player_fireball_scene = preload("res://scenes/attacks/player_fireball.tscn")
var player_plant_scene = preload("res://scenes/attacks/player_plant.tscn")


func _ready():
	$Sprite/AnimationPlayer.play("player_idle")


func _process(delta):
	if Input.is_action_just_pressed("next_player_element"):
		_switch_to_next_element()
	
	if Input.is_action_just_pressed("attack"):
		_attack()


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


func _level_up():
	current_level += 1
	player_leveled_up.emit(current_level)
	level_label.text = str(current_level)


func _switch_to_next_element():
	if selected_element == Element.WATER:
		selected_element = Element.FIRE
	elif selected_element == Element.FIRE:
		selected_element = Element.PLANT
	elif selected_element == Element.PLANT:
		selected_element = Element.ELECTRIC
	else:
		selected_element = Element.WATER
	
	player_changed_element.emit(selected_element)


func _attack():
	
	if selected_element == Element.WATER:
		_fire_attack()
	elif selected_element == Element.FIRE:
		_fire_attack()
	elif selected_element == Element.PLANT:
		_plant_attack()
	elif selected_element == Element.ELECTRIC:
		_fire_attack()


func _fire_attack():
	var fireball_instance = player_fireball_scene.instantiate()
	fireball_instance.position = position
	attack_group.add_child(fireball_instance)
	fireball_instance.killed_enemy.connect(_level_up)


func _plant_attack():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, get_global_mouse_position())
	var result = space_state.intersect_ray(query)
	
	var target_attack_location = get_global_mouse_position()
	
	if result:
		target_attack_location = result.position
	
	var plant_instance = player_plant_scene.instantiate()
	plant_instance.position = target_attack_location
	attack_group.add_child(plant_instance)
	plant_instance.killed_enemy.connect(_level_up)


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
