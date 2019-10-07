extends Node2D

signal DIE
signal WIN
signal PROGRESS
signal TIMER(duration)

const GRAVITY = 980
var level_velocity_x = 0

export (bool) var debug_can_die = true
export (Vector2) var wizard_starting_pos = Vector2(260, 90)
export (String, "", "Hen", "Ostrich", "Penguin") var debug_wizard_form = ""

var paused = true
var total_distance = 0
var wizard

func make_fly():
	if paused: return
	wizard.fly()

func wizard_action(action):
	if action == 'action':
		self.make_fly()

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
	wizard.connect("action_done", self, "wizard_action")

func check_debug():
	# verificar si hay que cargar algo pa' debug
	var debug_form = Loader.get_form(debug_wizard_form)
	if debug_form != null:
		set_wizard_form(debug_form)
		paused = false
		start()