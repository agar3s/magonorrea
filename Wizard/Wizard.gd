extends KinematicBody2D

# definir las señasles
signal action_done

# este valor dependerá de la cosa en la que se haya transformado el mago
export(int) var fly_x = 125
export(int) var fly_y = 720
var mov = Vector2()

const FALL_X = 35
const GRAVITY = 980

func _physics_process(delta):
	mov.y += GRAVITY * delta
	# mov.x += FALL_X * delta
	mov = move_and_slide(mov)
	
	if is_on_wall() or is_on_floor() or is_on_ceiling():
		get_tree().paused = true
	
	if Input.is_action_just_pressed("ui_action"):
		emit_signal("action_done")

func fly():
	mov.y = -fly_y
	# mov.x = fly_x