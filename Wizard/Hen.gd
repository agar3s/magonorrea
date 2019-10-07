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
	$Fly.play()
	$Walk.stop()
	$VO_Jump.playsound()

func run():
	$Fly.stop()
	$Walk.play()
	$Sprite.play("Run")

func jump():
	$SFX_Hop.playsound()
	$Walk.stop()
	$Fly.stop()
	$VO_Jump.playsound()
	.jump()

func die():
	$Sprite.play("Die")
	$Walk.stop()
	$Fly.stop()
	if dead == false:
		$Die.playsound()
	.die()

func idle(on_ground = true):
	$Walk.stop()
	$Fly.stop()
	$Stop.play()
	$Sprite.play("Fly")