extends "res://micro-games/dimension.gd"

var wizard_on_ground = false
var first_time_on_ground = true
onready var _obstacles = $Planet/Obstacles

func _ready():
	for obstacle in _obstacles.get_children():
		if obstacle.has_node("AnimatedSprite"):
			obstacle.get_node("AnimatedSprite").play("slap")
		obstacle.connect('collision_detected', self, '_on_wizard_collide')
	$Floor.connect("collision_detected", self, '_on_wizard_collide')
	
	$Space.play("travel")
	
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
	# _obstacles.global_position.x -= delta * self.level_velocity_x
	wizard.fall(GRAVITY)
	
	if int(_obstacles.global_position.x) % 10 == 0:
		emit_signal('PROGRESS', int(-100*(_obstacles.global_position.x)/total_distance))

func _on_wizard_collide(element_type):
	._on_wizard_collide(element_type)
	if element_type=='pine':
		self.die()
	elif element_type=='floor':
		wizard_on_ground = true
		if first_time_on_ground:
			first_time_on_ground = false
			wizard.idle()
		else:
			wizard.run()
		self.level_velocity_x = wizard.ground_speed_x

func set_wizard_form(form):
	.set_wizard_form(form)
	wizard.idle()
	level_velocity_x = wizard.ground_speed_x
	total_distance = _obstacles.get_node("Talisman").position.x - _obstacles.position.x - wizard.collision_width

func start():
	wizard.run()
	$AnimationPlayer.play("Rotate", -1, 3.0)