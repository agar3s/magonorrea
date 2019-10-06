extends Control

signal ENTER_DIMENSION

func _ready():
	pass

func start():
	print(3)
	yield(get_tree().create_timer(0.6), "timeout")
	print(2)
	yield(get_tree().create_timer(0.6), "timeout")
	print(1)
	yield(get_tree().create_timer(0.6), "timeout")
	print(0)
	emit_signal('ENTER_DIMENSION')

func open_portal():
	pass

func close_portal():
	pass