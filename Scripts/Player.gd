extends KinematicBody2D

export var SPEED = 150

var velocity: Vector2
var starting_position: Vector2
var coins: int

signal died

func _ready():
	starting_position = global_position
	coins = 0

func _physics_process(delta):
	get_input()
	var collision = move_and_collide(velocity * delta)
	if collision:
		var final_movement = collision.normal.slide(collision.remainder)
		velocity = move_and_slide(final_movement)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	# normalize so diagonal movement isn't faster
	velocity = velocity.normalized() * SPEED

func die():
	print("Player died")
	if is_physics_processing():
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
	print("Player collided with enemy ", body.name)
	die()

func _on_CoinDetector_body_entered(body):
	print("Player picked up coin ", self.coins)
	self.coins += 1
	body.pickup()
