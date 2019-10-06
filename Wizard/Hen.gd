extends "res://Wizard/Wizard.gd"

func _ready():
	$Sprite.play("Fly")
	$Sprite.connect("animation_finished", self, "_on_animation_finished")

func fly():
	.fly()
	$Sprite.play("Explode")

func die():
	$Sprite.play("Die")
	.die()

func _on_animation_finished():
	if $Sprite.animation == "Explode":
		$Sprite.play("Fly")