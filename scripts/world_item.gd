## A stationary object found in the map that can be destroyed by the Player in order to gain levels on a specific Element.
extends StaticBody2D


const GAME_ELEMENT = preload("res://scripts/game_element.gd").GameElement

## The Player will have its Element level increased by this quantity whenever this World Item is broken.
## The Element type is specified in [code]item_element[/code].
@export var levels_on_break : int = 1

## The Element of this World Item.
@export var item_element : GAME_ELEMENT


## Call this method whenever a Player Attack affects this World Item.
func touched_by_player_attack(attack_element : GAME_ELEMENT) -> void:
	if _can_be_defeated_by_element(attack_element):
		be_defeated()


## Returns [code]true[/code] if the passed GameElement counters this World Item's Element. [code](item_element)[/code]
func _can_be_defeated_by_element(element : GAME_ELEMENT) -> bool:
	# If this World item's Element is of Neutral type, be defeated by any Element.
	if item_element == GAME_ELEMENT.NEUTRAL:
		return true
	elif element == GAME_ELEMENT.WATER:
		return item_element == GAME_ELEMENT.FIRE
	elif element == GAME_ELEMENT.FIRE:
		return item_element == GAME_ELEMENT.PLANT
	elif element == GAME_ELEMENT.PLANT:
		return item_element == GAME_ELEMENT.ELECTRIC
	elif element == GAME_ELEMENT.ELECTRIC:
		return item_element == GAME_ELEMENT.WATER
		
	return false


## Destroys this World Item.
func be_defeated() -> void:
	%Player._level_up_element(item_element, 1)
	queue_free()
