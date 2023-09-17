extends CharacterBody2D

const SPEED = 50.0


@export var player: Node2D
@onready var nav_agent = $Navigation/NavigationAgent2D
var detection = null;
var start_position;

func _ready():
	start_position = self.global_position
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
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

func _on_timer_timeout():
	makepath()

func _on_area_2d_body_entered(body):
	if body.get_collision_layer() == 1: 
		detection = body
		print("Entra jugador")

func _on_area_2d_body_exited(body):
	if body.get_collision_layer() == 1:
		print("Sale jugador")
		detection = null


