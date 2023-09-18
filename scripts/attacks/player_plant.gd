class_name PlayerPlant
extends Area2D


signal killed_enemy()


func _on_destroy_timer_timeout():
	queue_free()


func hit_enemy(body):
	if body.get_collision_layer() == 2:
		body.kill()
		killed_enemy.emit()
		queue_free()
