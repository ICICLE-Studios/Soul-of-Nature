extends Node


signal game_paused()
signal game_unpaused()

var game_is_paused : bool = false


func _ready():
	pass


func _input(event):
	if not event.is_action_pressed("pause_game"):
		return

	if game_is_paused:
		_unpause_game()
	else:
		_pause_game()


func _pause_game():
	Engine.time_scale = 0.0
	game_is_paused = true
	game_paused.emit()


func _unpause_game():
	Engine.time_scale = 1.0
	game_is_paused = false
	game_unpaused.emit()
