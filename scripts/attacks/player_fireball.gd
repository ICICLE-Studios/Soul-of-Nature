extends Area2D


signal killed_enemy()

const GAME_ELEMENT = preload("res://scripts/game_element.gd").GameElement
const FIREBALL_EXPLOSION = preload("res://scenes/attacks/player_fireball_explosion.tscn")
const SPEED = 300.0

var _motion_direction : Vector2


func _ready():
	_motion_direction = get_local_mouse_position().normalized()
	if _motion_direction.is_zero_approx():
		_motion_direction = Vector2(1.0, 0.0)


func _physics_process(delta):
	position += _motion_direction * SPEED * delta


func _on_destroy_timer_timeout():
	queue_free()


func hit_enemy(body):
	# Not an Enemy? Ignore.
	if not body.get_collision_layer_value(2):
		return
		
	body.touched_by_player_attack(GAME_ELEMENT.FIRE)
	var instance = FIREBALL_EXPLOSION.instantiate()
	get_node("/root/Level").add_child(instance) # ILLO ESTA MIERDA PETA, COMO LO HACEMOS???
	instance.position = position
	queue_free()
