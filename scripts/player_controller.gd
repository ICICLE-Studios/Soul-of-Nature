class_name PlayerController
extends CharacterBody2D


const GAME_ELEMENT = preload("res://scripts/game_element.gd").GameElement

signal player_changed_element(new_element : GAME_ELEMENT)
signal player_leveled_up_element(element : GAME_ELEMENT, level : int) #TODO: USAME XD

const SPEED = 150.0
const SPRITE_PATH_BASE = "res://sprites/characters/PlayerSoul/ElementsSoulPlayer%s.png"
const PLAYER_FIREBALL_SCENE = preload("res://scenes/attacks/player_fireball.tscn")
const PLAYER_PLANT_SCENE = preload("res://scenes/attacks/player_plant.tscn")

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

var selected_element = GAME_ELEMENT.FIRE
var current_element_roulette_index = 0

var current_water_level = 1
var current_fire_level = 1
var current_plant_level = 1
var current_electric_level = 1

const ELEMENT_ROULETTE = [
	GAME_ELEMENT.WATER,
	GAME_ELEMENT.FIRE,
	GAME_ELEMENT.PLANT,
	GAME_ELEMENT.ELECTRIC
]


func defeated_enemy():
	print_debug("Defeated Enemy!")


func _ready():
	$Sprite/AnimationPlayer.play("player_idle")


func _process(delta):
	if Input.is_action_just_pressed("next_player_element"):
		_switch_to_next_element()
	
	if Input.is_action_just_pressed("attack"):
		_attack()
		
	if Input.is_action_just_pressed("spawn_enemy"):
		var enemy = load("res://scenes/enemies/soul_enemy.tscn")
		var instance = enemy.instantiate()
		%Enemies.add_child(instance)
		instance.player = %Player
		print("hey yo")

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


func _level_up_element(element : GAME_ELEMENT, quantity : int) -> void:
	if element == GAME_ELEMENT.NEUTRAL:
		return
	
	if element == GAME_ELEMENT.WATER:
		current_water_level += 1
		player_leveled_up_element.emit(element, current_water_level)
	elif element == GAME_ELEMENT.FIRE:
		current_fire_level += 1
		player_leveled_up_element.emit(element, current_fire_level)
	elif element == GAME_ELEMENT.PLANT:
		current_plant_level += 1
		player_leveled_up_element.emit(element, current_plant_level)
	elif element == GAME_ELEMENT.ELECTRIC:
		current_electric_level += 1
		player_leveled_up_element.emit(element, current_electric_level)


func _switch_to_next_element():
	current_element_roulette_index += 1
	
	if current_element_roulette_index >= ELEMENT_ROULETTE.size():
		current_element_roulette_index = 0
	
	selected_element = ELEMENT_ROULETTE[current_element_roulette_index]
	player_changed_element.emit(selected_element)


func _attack():
	
	if selected_element == GAME_ELEMENT.WATER:
		_fire_attack()
	elif selected_element == GAME_ELEMENT.FIRE:
		_fire_attack()
	elif selected_element == GAME_ELEMENT.PLANT:
		_plant_attack()
	elif selected_element == GAME_ELEMENT.ELECTRIC:
		_fire_attack()


func _fire_attack():
	var fireball_instance = PLAYER_FIREBALL_SCENE.instantiate()
	fireball_instance.position = position
	attack_group.add_child(fireball_instance)


func _plant_attack():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, get_global_mouse_position())
	var result = space_state.intersect_ray(query)
	var target_attack_location = get_global_mouse_position()
	
	if result:
		target_attack_location = result.position
	
	var plant_instance = PLAYER_PLANT_SCENE.instantiate()
	plant_instance.position = target_attack_location
	attack_group.add_child(plant_instance)


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
