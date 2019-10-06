extends Node2D

signal DIE
signal WIN
signal PROGRESS

const GRAVITY = 980
var level_velocity_x = 0

export (bool) var debug_can_die = true
export (Vector2) var wizard_starting_pos = Vector2(260, 90)

var paused = true
var total_distance = 0
var wizard

func make_fly():
	if paused: return
	wizard.fly()

func _on_wizard_collide(element_type):
	if element_type=='talisman':
		self.win()

func start():
	pass

func die():
	if !debug_can_die: return
	paused = true
	wizard.die()
	emit_signal("DIE")

func win():
	paused = true
	wizard.win()
	emit_signal("WIN")

func set_wizard_form(form):
	wizard = form.instance()
	wizard.set_name("Wizard")
	wizard.set_position(wizard_starting_pos)
	add_child(wizard)
	wizard.connect("action_done", self, "make_fly")
