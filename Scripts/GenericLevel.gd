extends Node2D

export var next_level: PackedScene

func reset():
	print("Reseting level")
	$Player.reset()
	for coin in $Objectives.get_children():
		coin.reset()
