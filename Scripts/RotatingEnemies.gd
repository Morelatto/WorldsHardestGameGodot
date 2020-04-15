extends Node2D

export var height: int
export var margin: int

export var rotation_speed = PI * .75

onready var pivot = $Center/Pivot

var enemy = preload("res://Scenes/EnemyBlue.tscn")

func _ready():
	var min_size = $Center/Sprite.texture.get_size().y
	for i in range(1, height + 1):
		var offset = (min_size + margin) * i
		var up = enemy.instance()
		var down = enemy.instance()
		var left = enemy.instance()
		var right = enemy.instance()

		up.position = Vector2($Center.position.x - offset, $Center.position.y)
		down.position = Vector2($Center.position.x + offset, $Center.position.y)
		left.position = Vector2($Center.position.x, $Center.position.y - offset)
		right.position = Vector2($Center.position.x, $Center.position.y + offset)

		pivot.add_child(up)
		pivot.add_child(down)
		pivot.add_child(left)
		pivot.add_child(right)

func _process(delta):
	pivot.rotation += rotation_speed * delta
