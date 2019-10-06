extends Control

signal ENTER_DIMENSION(form_name)
var wizard = load("res://Wizard/Wizard.tscn")
var naked_wizard

func _ready():
	for potion in $Potions.get_children():
		potion.connect("pressed", self, "choose_potion", [potion.name])
	$Portal.initialize($Potions.get_children())

func start():
	# poner valores por defecto
#	for index in range(starting_positions.size()):
#		$Potions.get_child(index).rect_position = starting_positions[index]

	naked_wizard = wizard.instance()
	naked_wizard.position = Vector2(680, 410)
	naked_wizard.in_nowhere = true
	add_child(naked_wizard)

	yield(get_tree().create_timer(3.0), "timeout")
	
	$Portal.setup()

func choose_potion(name):
	$Portal.close_portal()
	naked_wizard.queue_free()
	emit_signal('ENTER_DIMENSION', name.to_lower())
