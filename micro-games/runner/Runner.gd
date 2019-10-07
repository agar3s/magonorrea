extends "res://micro-games/dimension.gd"

var wizard_on_ground = false
var first_time_on_ground = true
onready var _obstacles = $Planet/Obstacles
var traveled_distance = 0
var rotation_speed = 10
var planet_perimeter = 2600

func _ready():
	$Floor.connect("collision_detected", self, '_on_wizard_collide')
	$OuterSpace.connect("collision_detected", self, '_on_wizard_collide')
	
	$Space.play("travel")
	
	$MX_Runner.play()
	
	$BG_Planeta.play()
	
	for obstacle in $Level.get_children():
		pass # should order in X?
	
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
	update_planet_rotation(delta)
	# _obstacles.global_position.x -= delta * self.level_velocity_x
	wizard.fall(GRAVITY)
	
	if int(traveled_distance) % 10 == 0:
		emit_signal('PROGRESS', int(-100*(traveled_distance)/total_distance))

func update_planet_rotation(delta):
	$Planet.rotation -= delta*PI*2/rotation_speed
	traveled_distance = -$Planet.rotation*planet_perimeter/(2*PI)
	$Level.position.x = -traveled_distance
	if $Level.get_child_count() > 0:
		check_attach_planet()
	
	# remove passed elements
	if $Planet/Obstacles.get_child_count() > 0:
		var obstacle = $Planet/Obstacles.get_child(0)
		if obstacle.global_position.y >= 800:
			$Planet/Obstacles.remove_child(obstacle)
			obstacle.queue_free()

func check_attach_planet():
	var obstacle = $Level.get_child(0)
	if obstacle.global_position.x >= 0: return
	
	$Level.remove_child(obstacle)
	if obstacle.has_node("AnimatedSprite"):
		obstacle.get_node("AnimatedSprite").play("slap")
	obstacle.connect('collision_detected', self, '_on_wizard_collide')
	$Planet/Obstacles.add_child(obstacle)
	obstacle.global_rotation = PI/2
	obstacle.global_position = Vector2(926, 750)


func _on_wizard_collide(element_type):
	._on_wizard_collide(element_type)
	if element_type=='pine':
		self.die()
	elif element_type == 'space':
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
	rotation_speed = planet_perimeter/wizard.ground_speed_x
	total_distance = $Level/Talisman.global_position.x

func start():
	wizard.run()
