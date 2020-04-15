extends Area2D

func _on_End_body_entered(body):
	print("End collided with ", body.name)
	if check_objective_complete(body.coins):
		if owner.next_level != null:
			get_tree().change_scene_to(owner.next_level)

func check_objective_complete(coins):
	var objectives = owner.get_node("Objectives")
	return objectives == null || objectives.get_child_count() == coins


