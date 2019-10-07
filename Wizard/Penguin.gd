extends "res://Wizard/Wizard.gd"

func _ready():
	$Sprite.connect("animation_finished", self, "_on_animation_finished")

func fly():
	.fly()
	$Sprite.play("Fly")
	# $Penguin_Fly.play()
	# $Penguin_DoubleJump.playsound()
	
func jump():
	.jump()
	$Sprite.play("Fly")
	# $Penguin_Jump.playsound()
	# $Penguin_VO_Jump.playsound()
	# $Penguin_Walk.stop()

func run():
	$Sprite.play("Run")
	# $Penguin_Walk.play()
	# $Penguin_Fly.stop()

func die():
	$Sprite.play("Die")
	# $Penguin_Die.play()
	# $Penguin_Fly.stop()
	# $Penguin_Walk.stop()
	.die()

func _on_animation_finished():
	if $Sprite.animation == "Jump":
		$Sprite.play("Fly")
	elif $Sprite.animation == "Slide":
		$Sprite.rotation_degrees = 0
		$Sprite.play("Idle")

func idle(on_ground = true):
	if on_ground:
		$Sprite.play("Idle")
		$Sprite.rotation_degrees = 0
		# $Penguin_Fly.stop()
		# $Penguin_Walk.stop()
	else:
		$Sprite.play("Fly")

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
	yield(get_tree().create_timer(0.3), "timeout")