class_name PlayerCamera
extends Camera2D
## Handles the main camera's movement.


const MOUSE_LOOK_RANGE = 0.2

@onready var player = %Player


func _physics_process(delta):
	position = player.position + get_local_mouse_position() * MOUSE_LOOK_RANGE
