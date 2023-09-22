class_name PauseManager
extends Node


signal game_paused()
signal game_unpaused()

static var game_is_paused : bool = false


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
	game_is_paused = true


func _unpause_game():
	game_is_paused = false
