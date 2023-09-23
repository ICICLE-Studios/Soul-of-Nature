extends MarginContainer


func _ready():
	PauseManager.game_paused.connect(_on_game_paused)
	PauseManager.game_unpaused.connect(_on_game_unpaused)


func _on_game_paused():
	visible = true


func _on_game_unpaused():
	visible = false
