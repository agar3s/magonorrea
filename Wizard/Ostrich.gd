extends "res://Wizard/Wizard.gd"

func _ready():
	$Sprite.connect("animation_finished", self, "_on_animation_finished")

func fly():
	.fly()
	$Sprite.play("Fly")
	
func jump():
	.jump()
	$Sprite.play("Jump")

func run():
	$Sprite.play("Run")

func die():
	$Sprite.play("Die")
	.die()

func _on_animation_finished():
	if $Sprite.animation == "Jump":
		$Sprite.play("Fly")

func idle(on_ground = true):
	if on_ground:
		$Sprite.play("Idle")
	else:
		$Sprite.play("Fly")