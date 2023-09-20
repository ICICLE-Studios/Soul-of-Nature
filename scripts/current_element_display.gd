extends Sprite2D


const GAME_ELEMENT = preload("res://scripts/game_element.gd").GameElement

@export var water_icon : CompressedTexture2D
@export var fire_icon : CompressedTexture2D
@export var plant_icon : CompressedTexture2D
@export var electric_icon : CompressedTexture2D


func _ready():
	%Player.player_changed_element.connect(_on_player_changed_element)
	texture = water_icon


func _on_player_changed_element(element : GAME_ELEMENT) -> void:
	if element == GAME_ELEMENT.WATER:
		texture = water_icon
		$ChangeToWaterAudio.play()
	elif element == GAME_ELEMENT.FIRE:
		texture = fire_icon
		$ChangeToFireAudio.play()
	elif element == GAME_ELEMENT.PLANT:
		texture = plant_icon
		$ChangeToPlantAudio.play()
	else:
		texture = electric_icon
		$ChangeToThunderAudio.play()
