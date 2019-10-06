extends Control

signal ENTER_DIMENSION(form_name)
var wizard = load("res://Wizard/Wizard.tscn")
var naked_wizard
var starting_positions = []

func _ready():
	for potion in $Potions.get_children():
		potion.connect("pressed", self, "choose_potion", [potion.name])
		starting_positions.append(potion.rect_position)

func start():
	# poner valores por defecto
	for index in range(starting_positions.size()):
		$Potions.get_child(index).rect_position = starting_positions[index]

	naked_wizard = wizard.instance()
	naked_wizard.position = Vector2(680, 410)
	naked_wizard.in_nowhere = true
	add_child(naked_wizard)
	yield(get_tree().create_timer(3.0), "timeout")
	open_portal()

func open_portal():
	$AnimationPlayer.play("OpenPortal", -1, 2.0)
	yield($AnimationPlayer, "animation_finished")
	self.spit_potions()

func close_portal():
	pass
	
func spit_potions():
	for index in range($Potions.get_children().size()):
		$AnimationPlayer.play("SpitPotions")
		var p = $Potions.get_child(index)
		$Tween.interpolate_property(
			p,
			"rect_position",
			p.rect_position,
			$Points.get_child(index).position,
			0.8,
			Tween.TRANS_ELASTIC,
			Tween.EASE_OUT
		)
		$Tween.start()
		yield($Tween, "tween_completed")

func choose_potion(name):
	$AnimationPlayer.play_backwards("OpenPortal")
	naked_wizard.queue_free()
	emit_signal('ENTER_DIMENSION', name.to_lower())
