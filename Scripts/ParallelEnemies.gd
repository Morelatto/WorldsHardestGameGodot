extends Node2D

export var amount: int
export var margin: int
export var vertical: bool

onready var first = $First

var enemy = preload("res://Scenes/EnemyBlue.tscn")

func _ready():
	var min_size = first.get_node("Sprite").get_texture().get_size().y
	for i in range(1, amount + 1):
		var offset = (min_size + margin) * i
		var current = enemy.instance()
		current.speed = first.speed
		current.rotation = first.rotation
		if vertical:
			current.position = Vector2(first.position.x, first.position.y + offset)
		else:
			current.position = Vector2(first.position.x + offset, first.position.y)
		add_child(current)
