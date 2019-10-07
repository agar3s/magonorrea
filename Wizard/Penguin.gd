extends "res://Wizard/Wizard.gd"

func _ready():
	$Sprite.connect("animation_finished", self, "_on_animation_finished")

func fly():
	.fly()
	$Sprite.play("Fly")
	$SFX_Pen_Fly.play()
	$SFX_Pen_Jump.playsound()
	$Vo_Pen_Jump.playsound()
	
func jump():
	.jump()
	$Sprite.play("Fly")
	$SFX_Pen_Jump.playsound()
	$Vo_Pen_Jump.playsound()
	$SFX_Pen_Walk.stop()

func run():
	$Sprite.play("Run")
	$SFX_Pen_Walk.play()
	$SFX_Pen_Fly.stop()

func die():
	$Sprite.play("Die")
	$SFX_Pen_Die.play()
	$SFX_Pen_Fly.stop()
	$SFX_Pen_Walk.stop()
	.die()

func _on_animation_finished():
	if $Sprite.animation == "Jump":
		$Sprite.play("Fly")
	elif $Sprite.animation == "Slide":
		$Sprite.rotation_degrees = 0
		$Sprite.play("Idle")

func idle(on_ground = true):
	if on_ground:
		$SFX_Pen_Stop.play()
		$Sprite.play("Idle")
		$Sprite.rotation_degrees = 0
		$SFX_Pen_Fly.stop()
		$SFX_Pen_Walk.stop()
	else:
		$Sprite.play("Fly")
		$SFX_Pen_Fly.play()

func slide(direction = ""):
	$Sprite.flip_h = false
	if direction == 'left':
		$Sprite.flip_h = true
	elif direction == 'right':
		$Sprite.rotation_degrees = 0
	elif direction == 'up':
		$Sprite.rotation_degrees = -90
	elif direction == 'down':
		$Sprite.rotation_degrees = 90
	$Sprite.play("Slide")
	$SFX_Pen_Slide.play()
	$Vo_Pen_Slide.playsound()
	yield(get_tree().create_timer(0.3), "timeout")