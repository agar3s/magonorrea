extends "res://micro-games/dimension.gd"

var wizard_on_ground = false

func _ready():
	for obstacle in $Obstacles.get_children():
		obstacle.connect('collision_detected', self, '_on_wizard_collide')
	$Floor.connect("collision_detected", self, '_on_wizard_collide')
	
	# verificar si hay que cargar algo pa' debug
	check_debug()

func make_fly():
	if paused: return
	if wizard_on_ground:
		wizard_on_ground = false
		self.level_velocity_x = wizard.fly_x

		wizard.jump()
	else:
		wizard.fly()

func _process(delta):
	if paused: return
	$Obstacles.global_position.x -= delta * self.level_velocity_x
	wizard.fall(GRAVITY)
	
	if int($Obstacles.global_position.x) % 10 == 0:
		emit_signal('PROGRESS', int(-100*($Obstacles.global_position.x)/total_distance))

func _on_wizard_collide(element_type):
	._on_wizard_collide(element_type)
	if element_type=='pine':
		self.die()
	elif element_type=='floor':
		wizard_on_ground = true
		self.level_velocity_x = wizard.ground_speed_x

func set_wizard_form(form):
	.set_wizard_form(form)
	level_velocity_x = wizard.ground_speed_x
	total_distance = $Obstacles/Talisman.position.x - $Obstacles.position.x - wizard.collision_width