class_name PlayerFireball
extends Area2D

const SPEED = 300.0

var motion_direction : Vector2

func _ready():
	motion_direction = get_local_mouse_position().normalized()
	if motion_direction.is_zero_approx():
		motion_direction = Vector2(1.0, 0.0)

func _physics_process(delta):
	position += motion_direction * SPEED * delta

func _on_destroy_timer_timeout():
	queue_free()
