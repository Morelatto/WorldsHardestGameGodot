extends KinematicBody2D

export var SPEED = 150
export var ACCELERATION = 2000

var motion: Vector2
var starting_position: Vector2
var coins: int

signal died

func _ready():
	motion = Vector2.ZERO
	starting_position = global_position
	coins = 0

func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	axis.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	# normalize so diagonal movement isn't faster
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(SPEED)

func die():
	print("Player died")
	set_physics_process(false)
	$AnimationPlayer.play("death")
	emit_signal("died")

func reset():
	print("Reseting player")
	global_position = starting_position
	$Sprite.modulate.a = 1
	self.coins = 0
	set_physics_process(true)

func _on_AnimationPlayer_animation_finished(anim_name):
	owner.reset()

func _on_EnemyDetector_body_entered(body):
	if is_physics_processing():
		print("Player collided with enemy ", body.name)
		die()

func _on_CoinDetector_body_entered(body):
	# TODO better way of checking if coin was picked up
	if body.get_node("Sprite").get_modulate().a != 0:
		print("Player picked up coin ", self.coins)
		self.coins += 1
		body.pickup()
