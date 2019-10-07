extends "res://Wizard/Wizard.gd"

func _ready():
	$Sprite.play("Fly")
	$Sprite.connect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished():
	if $Sprite.animation == "Explode":
		$Sprite.play("Fly")

func fly():
	.fly()
	$Sprite.play("Explode")
	$SFX_Jump.playsound()
	$VO_Jump.playsound()

func run():
	$Sprite.play("Run")

func die():
	$Sprite.play("Die")
	if dead == false:
		$Die.playsound()
	.die()

func idle(on_ground = true):
	$Sprite.play("Fly")