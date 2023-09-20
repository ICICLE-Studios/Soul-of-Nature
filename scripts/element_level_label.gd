extends Label


const GAME_ELEMENT = preload("res://scripts/game_element.gd").GameElement

@export var target_element : GAME_ELEMENT

func _ready():
	%Player.player_leveled_up_element.connect(_on_player_leveled_up_element)


func _on_player_leveled_up_element(element : GAME_ELEMENT, level : int) -> void:
	if element == target_element:
		text = str(level)
