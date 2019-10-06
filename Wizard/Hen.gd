extends "res://Wizard/Wizard.gd"

func fly():
	.fly()
	$Sprite/AnimationPlayer.play("Explode")
