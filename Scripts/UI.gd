extends Control

onready var deathCounter = $Panel/HBoxContainer/DeathsInfo

func _ready():
	update_death_counter()

func _on_Player_died():
	GameState.deaths += 1
	print("Player died ", GameState.deaths, " times")
	update_death_counter()

func update_death_counter():
	deathCounter.text = str("DEATHS: ", GameState.deaths)
