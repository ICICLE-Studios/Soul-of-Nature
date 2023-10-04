extends Area2D


var from : Vector2
var to : Vector2
var line : Line2D

var enemiesDetected = []
var boneIndex:int = 0
const GAME_ELEMENT = preload("res://scripts/game_element.gd").GameElement
@onready var lightning_line = get_node("/root/Level/Lightning_Line")


func _ready():
	body_entered.connect(_on_body_entered)
	line = lightning_line.duplicate()
	line.get_child(0).autostart = true
	get_node("/root/Level").add_child(line)
	
var bodyEnemy:Node2D



func _on_body_entered(body : Node2D):
	
	# Not an Enemy? Ignore.
	if not body.get_collision_layer_value(2):
		return
	
	if from == Vector2(0,0):
		from = position
		line.add_point(from, 0)
	
	if(body._can_be_defeated_by_element(GAME_ELEMENT.ELECTRIC) && enemiesDetected.size()<=3):
		enemiesDetected.append(body)
		to = body.position
		boneIndex+=1
		line.add_point(to,boneIndex)
		body.touched_by_player_attack(GAME_ELEMENT.ELECTRIC)
		pass

	
func _on_destroy_timer_timeout():
	queue_free()

