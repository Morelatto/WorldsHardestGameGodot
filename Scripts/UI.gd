extends Control

onready var deathCounter = $Panel/HBoxContainer/DeathsInfo

var deaths: int

func _ready():
	deaths = 0

func _on_Player_died():
	deaths += 1
	# FIXME death counter resets randomly
	print("Player died ", deaths, " times")
	deathCounter.text = str("DEATHS: ", deaths)
