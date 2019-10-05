extends Node2D

signal DIE
signal WIN

const GRAVITY = 980
onready var level_velocity_x = $Wizard.fly_x

func _ready():
	# conectar escuchadores de señales
	$Wizard.connect("action_done", self, "make_fly")
	for fork in $Forks.get_children():
		fork.connect('collision_detected', self, '_on_wizard_collide')

func _process(delta):
	$Forks.global_position.x -= delta * level_velocity_x
	$Wizard.fall(GRAVITY)

func make_fly():
	$Wizard.fly()

func _on_wizard_collide(element_type):
	get_tree().paused = true
	if element_type=='fork':
		self.die()
	elif element_type=='talisman':
		self.win()

func start():
	pass

func die():
	emit_signal("DIE")

func win():
	emit_signal("WIN")


