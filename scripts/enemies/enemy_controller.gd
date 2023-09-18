extends CharacterBody2D


const SPEED = 50.0
const SPRITE_PATH_BASE = "res://sprites/characters/%s/%s%s.png"

@export var player: Node2D
@export var enemy_folder_name : String = "EnemySoul"
@export var enemy_file_name : String = "ElementsSoulEnemy"

@onready var nav_agent = $Navigation/NavigationAgent2D
@onready var sprite = $Sprite

# Load the corresponding Enemy Sprites
@onready var look_down_sprite = load(SPRITE_PATH_BASE % [enemy_folder_name, enemy_file_name, "1"])
@onready var look_down_right_sprite = load(SPRITE_PATH_BASE % [enemy_folder_name, enemy_file_name, "2"])
@onready var look_right_sprite = load(SPRITE_PATH_BASE % [enemy_folder_name, enemy_file_name, "3"])
@onready var look_up_right_sprite = load(SPRITE_PATH_BASE % [enemy_folder_name, enemy_file_name, "4"])
@onready var look_up_sprite = load(SPRITE_PATH_BASE % [enemy_folder_name, enemy_file_name, "5"])
@onready var look_up_left_sprite = load(SPRITE_PATH_BASE % [enemy_folder_name, enemy_file_name, "6"])
@onready var look_left_sprite = load(SPRITE_PATH_BASE % [enemy_folder_name, enemy_file_name, "7"])
@onready var look_down_left_sprite = load(SPRITE_PATH_BASE % [enemy_folder_name, enemy_file_name, "8"])

var detection = null
var start_position


func _ready():
	start_position = self.global_position
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	sprite.texture = look_down_sprite
	pass


func _physics_process(_delta):
	var dir = to_local(nav_agent.get_next_path_position()).normalized() 
	velocity = dir * SPEED
	move_and_slide()


func makepath():
	if detection:
		nav_agent.target_position = player.global_position
	else:
		nav_agent.target_position = start_position
	
	look_at_target_direction()


func _on_timer_timeout():
	makepath()


func look_at_target_direction():
	var direction = Vector2(nav_agent.get_next_path_position() - position).normalized()
	
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


func _on_area_2d_body_entered(body):
	if body.get_collision_layer() == 1: 
		detection = body
		print("Entra jugador")


func _on_area_2d_body_exited(body):
	if body.get_collision_layer() == 1:
		print("Sale jugador")
		detection = null
