extends StaticBody2D

func pickup():
	$Sprite.modulate.a = 0

func reset():
	$Sprite.modulate.a = 1
