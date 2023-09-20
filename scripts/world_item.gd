class_name WorldItem
extends StaticBody2D

enum Element {
	WATER,
	FIRE,
	PLANT,
	ELECTRIC
}

@export var target_element : Element

func kill():
	queue_free()
