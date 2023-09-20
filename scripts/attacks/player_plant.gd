extends Area2D


signal killed_enemy()

const GAME_ELEMENT = preload("res://scripts/game_element.gd").GameElement


func _on_destroy_timer_timeout():
	queue_free()


func hit_enemy(body):
	# Not an Enemy? Ignore.
	if not body.get_collision_layer_value(2):
		return
		
	body.touched_by_player_attack(GAME_ELEMENT.PLANT)
	queue_free()
