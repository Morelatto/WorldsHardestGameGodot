extends KinematicBody2D

export var speed = 0

var path: Node

func _ready():
	path = get_node("../")

func _physics_process(delta):
	if path != null and "PathFollow2D" in path.name:
		path.set_offset(path.get_offset() + speed * delta)
	else:
		if $RayCast2D.is_colliding():
			$RayCast2D.cast_to = $RayCast2D.cast_to.rotated(PI)
		# using raycast cast direction to decide where to go
		var dir = get_dir($RayCast2D.cast_to)
		move_and_slide(speed * dir)

func get_dir(pos):
	pos = pos.rotated(self.rotation)
	if abs(pos.x) > abs(pos.y):
		return Vector2(sign(pos.x), 0)
	else:
		return Vector2(0, sign(pos.y))
