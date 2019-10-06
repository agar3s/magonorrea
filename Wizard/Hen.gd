extends "res://Wizard/Wizard.gd"

func _ready():
	$Sprite.play("Fly")
	$Sprite.connect("animation_finished", self, "_on_animation_finished")

func fly():
	.fly()
	$Sprite.play("Explode")
	$SFX_Jump.playsound()
	$VO_Jump.playsound()

func die():
	$Sprite.play("Die")
	if dead == false:
		$Die.playsound()
	.die()

func _on_animation_finished():
	if $Sprite.animation == "Explode":
		$Sprite.play("Fly")