extends Sprite2D


@export var water_icon : CompressedTexture2D
@export var fire_icon : CompressedTexture2D
@export var plant_icon : CompressedTexture2D
@export var electric_icon : CompressedTexture2D


func _ready():
	%Player.player_changed_element.connect(_on_player_changed_element)


func _on_player_changed_element(element):
	if element == 0:
		texture = water_icon
	elif element == 1:
		texture = fire_icon
	elif element == 2:
		texture = plant_icon
	else:
		texture = electric_icon
