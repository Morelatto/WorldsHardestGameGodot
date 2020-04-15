extends Area2D

func _on_Checkpoint_body_entered(body):
	print("Checkpoint collided with ", body.name)
	body.starting_position = $Spawner.global_position

