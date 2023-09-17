class_name PlayerCamera
extends Camera2D
## Handles the main camera's movement.


const mouse_look_range = 100.0

@onready var player = %Player


func _physics_process(delta):
	var player_position = player.position
	var mouse_position = get_viewport().get_mouse_position()
	var window_size = get_viewport().size
	
	var normalized_mouse_position_x = (float(mouse_position.x) - float(window_size.x / 2)) / float(window_size.x)
	var normalized_mouse_position_y = (float(mouse_position.y) - float(window_size.y / 2)) / float(window_size.y)
	
	var mouse_look = Vector2(
			normalized_mouse_position_x * mouse_look_range,
			normalized_mouse_position_y * mouse_look_range)
	
	var target_camera_position = player_position + mouse_look
	
	position = target_camera_position
