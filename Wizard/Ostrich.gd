extends "res://Wizard/Wizard.gd"

func _ready():
	$Sprite.connect("animation_finished", self, "_on_animation_finished")

func fly():
	.fly()
	$Sprite.play("Fly")
	$Ostrich_Fly.play()
	$Ostrich_DoubleJump.playsound()
	
func jump():
	.jump()
	$Sprite.play("Jump")
	$Ostrich_Jump.playsound()
	$Ostrich_VO_Jump.playsound()
	$Ostrich_Walk.stop()

func run():
	$Sprite.play("Run")
	$Ostrich_Walk.play()
	$Ostrich_Fly.stop()

func die():
	$Sprite.play("Die")
	$Ostrich_Die.play()
	$Ostrich_Fly.stop()
	$Ostrich_Walk.stop()
	.die()

func _on_animation_finished():
	if $Sprite.animation == "Jump":
		$Sprite.play("Fly")

func idle(on_ground = true):
	
	if on_ground:
		$Ostrich_Stop.play()
		$Sprite.play("Idle")
		$Ostrich_Fly.stop()
		$Ostrich_Walk.stop()
	else:
		$Sprite.play("Fly")
		$Ostrich_Fly.play()
