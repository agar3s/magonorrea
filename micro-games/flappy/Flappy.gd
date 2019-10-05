extends Node2D

signal DIE
signal WIN
signal PROGRESS

const GRAVITY = 980
onready var level_velocity_x = $Wizard.fly_x

export (bool) var debug_can_die = true
var paused = true
var total_distance = 0
func _ready():
	# conectar escuchadores de señales
	$Wizard.connect("action_done", self, "make_fly")
	for fork in $Forks.get_children():
		fork.connect('collision_detected', self, '_on_wizard_collide')
	$Ceil.connect("collision_detected", self, '_on_wizard_collide')
	$Floor.connect("collision_detected", self, '_on_wizard_collide')
	total_distance = $Forks/Talisman.position.x - $Wizard.position.x - $Wizard.collision_width

func _process(delta):
	if paused: return
	$Forks.global_position.x -= delta * level_velocity_x
	$Wizard.fall(GRAVITY)
	if int($Forks.global_position.x) % 10 == 0:
		emit_signal('PROGRESS', int(-100*($Forks.global_position.x)/total_distance))

func make_fly():
	if paused: return
	$Wizard.fly()

func _on_wizard_collide(element_type):
	if element_type=='fork' || element_type=='ceil' || element_type=='floor':
		self.die()
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


