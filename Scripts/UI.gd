extends Control

var deaths: int

func _ready():
	deaths = 0

func _on_Player_died():
	deaths += 1
	# FIXME death counter resets randomly
	print("Player died ", deaths, " times")
	$Panel/DeathsInfo.text = str("DEATHS: ", deaths)
