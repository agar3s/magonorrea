extends Node2D

signal DIE
signal WIN
signal PROGRESS

const GRAVITY = 980
onready var level_velocity_x = $Wizard.ground_speed_x

export (bool) var debug_can_die = true

var paused = false
var total_distance = 0
var wizard_on_ground = false

func _ready():
	$Wizard.connect("action_done", self, "make_fly")
	for obstacle in $Obstacles.get_children():
		obstacle.connect('collision_detected', self, '_on_wizard_collide')
	$Floor.connect("collision_detected", self, '_on_wizard_collide')
	total_distance = $Obstacles/Talisman.position.x - $Obstacles.position.x - $Wizard.collision_width

func make_fly():
	if paused: return
	if wizard_on_ground:
		wizard_on_ground = false
		self.level_velocity_x = $Wizard.fly_x

		$Wizard.jump()
	else:
		$Wizard.fly()

func _process(delta):
	if paused: return
	$Obstacles.global_position.x -= delta * self.level_velocity_x
	$Wizard.fall(GRAVITY)
	
	if int($Obstacles.global_position.x) % 10 == 0:
		emit_signal('PROGRESS', int(-100*($Obstacles.global_position.x)/total_distance))

func _on_wizard_collide(element_type):
	if element_type=='pine':
		self.die()
	elif element_type=='floor':
		wizard_on_ground = true
		self.level_velocity_x = $Wizard.ground_speed_x
	elif element_type=='talisman':
		self.win()

func start():
	pass

func die():
	if !debug_can_die: return
	get_tree().paused = true
	$Wizard.die()
	emit_signal("DIE")

func win():
	get_tree().paused = true
	emit_signal("WIN")
