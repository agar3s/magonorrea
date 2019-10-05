extends Node2D

export(PackedScene) var fork

func _ready():
	create_fork()
	
	# conectar escuchadores de señales
	$Wizard.connect("action_done", self, "make_fly")

func create_fork():
	var new_fork = fork.instance()
	new_fork.global_position = Vector2(1024, 600)
	new_fork.connect("died", self, "create_fork")
	add_child(new_fork)

func make_fly():
	$Wizard.fly()