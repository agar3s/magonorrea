extends Node2D

const GRAVITY = 980
onready var level_velocity_x = $Wizard.fly_x

func _ready():
	# conectar escuchadores de señales
	$Wizard.connect("action_done", self, "make_fly")

func _process(delta):
	$Forks.global_position.x -= delta * level_velocity_x
	$Wizard.fall(GRAVITY)

func make_fly():
	$Wizard.fly()