extends Node2D

export var amount: int
export var margin: int
export var vertical: bool

var enemy = preload("res://Scenes/EnemyBlue.tscn")

func _ready():
	var min_size = $First/Sprite.texture.get_size().y
	for i in range(1, amount + 1):
		var offset = (min_size + margin) * i
		var current = enemy.instance()
		current.speed = $First.speed
		current.rotation = $First.rotation
		if vertical:
			current.position = Vector2($First.position.x, $First.position.y + offset)
		else:
			current.position = Vector2($First.position.x + offset, $First.position.y)
		add_child(current)
