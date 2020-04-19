extends Node2D

export var height: int
export var margin: int
export var center_visible = true
export var rotation_speed = PI * .75

onready var center_enemy = $Center
onready var pivot = $Center/Pivot
onready var center_sprite = $Center/Sprite

var enemy = preload("res://Scenes/EnemyBlue.tscn")

func _ready():
	var min_size = center_sprite.texture.get_size().y
	for i in range(1, height + 1):
		var offset = (min_size + margin) * i
		var up = enemy.instance()
		var down = enemy.instance()
		var left = enemy.instance()
		var right = enemy.instance()

		up.position = Vector2(center_enemy.position.x - offset, center_enemy.position.y)
		down.position = Vector2(center_enemy.position.x + offset, center_enemy.position.y)
		left.position = Vector2(center_enemy.position.x, center_enemy.position.y - offset)
		right.position = Vector2(center_enemy.position.x, center_enemy.position.y + offset)

		pivot.add_child(up)
		pivot.add_child(down)
		pivot.add_child(left)
		pivot.add_child(right)

	if !center_visible:
		center_enemy.set_collision_layer_bit(2, false)
		center_sprite.modulate.a = 0

func _process(delta):
	pivot.rotation += rotation_speed * delta
