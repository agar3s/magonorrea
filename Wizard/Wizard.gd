extends KinematicBody2D

# definir las señasles
signal action_done

# estos valores cambiarán dependiendo de la cosa en la que se haya
# transformado el mago --------------------------------------------------------┐
# warning-ignore:unused_class_variable
# tamanio de colision para el mago
var collision_width = 32
# velocidad en X, que tan rápido se mueve.
export (int) var fly_x = 450
# entre más pequeño es más jodido hacerlo subir
export (int) var fly_y = 550
# entre más alto planea más (si es negativo no planea y hace que sea más difícil volar)
export (int) var wind_resistance = 200
# entre más grande es más difícil hacerla subir
export (int) var max_vel_y = 400
# velocidad de salto
export (int) var jump_speed_y = -300
# que tan rapido corre
export (int) var ground_speed_x = 350
# └----------------------------------------------------------------------------┘

var mov = Vector2()
var dead = false

const FALL_X = 35

# warning-ignore:unused_argument
func _physics_process(delta):
	if dead: return
	self.mov.x = 0
	self.mov = move_and_slide(self.mov)

	if Input.is_action_just_released("ui_action"):
		emit_signal("action_done")


func fly():
	self.mov.y = max(self.mov.y - self.fly_y, -self.max_vel_y)


func fall(gravity):
	if self.dead: return

	self.mov.y = min(
		(gravity - self.wind_resistance) * get_physics_process_delta_time() + self.mov.y,
		self.max_vel_y
	)
	$Sprite.rotation_degrees = -10 + 20*self.mov.y/self.max_vel_y


func die():
	self.dead = true
	$Sprite.rotation_degrees = -180

func win():
	self.dead = true


func jump():
	mov.y = jump_speed_y