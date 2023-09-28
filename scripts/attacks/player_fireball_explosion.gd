extends Area2D


const GAME_ELEMENT = preload("res://scripts/game_element.gd").GameElement


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body : Node2D):
	# Not an Enemy? Ignore.
	if not body.get_collision_layer_value(2):
		return
	
	body.touched_by_player_attack(GAME_ELEMENT.FIRE)


func _on_destroy_timer_timeout():
	queue_free()
