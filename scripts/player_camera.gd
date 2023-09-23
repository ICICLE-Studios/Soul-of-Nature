class_name PlayerCamera
extends Camera2D
## Handles the main camera's movement.


const MOUSE_LOOK_RANGE = 0.2

@onready var player = %Player


func _input(event):
	if PauseManager.game_is_paused:
		return
	
	if event is InputEventMouseButton:
		
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom += Vector2(0.2, 0.2)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom -= Vector2(0.2, 0.2)
		
		zoom.x = clampf(zoom.x, 0.5, 4.0)
		zoom.y = clampf(zoom.y, 0.5, 4.0)


func _physics_process(_delta):
	if PauseManager.game_is_paused:
		return
	
	position = player.position + get_local_mouse_position() * MOUSE_LOOK_RANGE
