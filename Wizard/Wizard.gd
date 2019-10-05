extends KinematicBody2D

# definir las señasles
signal action_done

# estos valores cambiarán dependiendo de la cosa en la que se haya
# transformado el mago --------------------------------------------------------┐
var fly_x = 600
# entre más pequeño es más jodido hacerlo subir
var fly_y = 550
# entre más alto planea más (si es negativo no planea y hace que sea más difícil volar)
var wind_resistance = 200
# entre más grande es más difícil hacerla subir
var max_vel_y = 400
# └----------------------------------------------------------------------------┘

var mov = Vector2()

const FALL_X = 35

func _physics_process(delta):
	mov = move_and_slide(mov)

	if Input.is_action_just_released("ui_action"):
		emit_signal("action_done")

func fly():
	mov.y = max(mov.y - fly_y, -max_vel_y)

func fall(gravity):
	mov.y = min((gravity - wind_resistance) * get_physics_process_delta_time() + mov.y, max_vel_y)