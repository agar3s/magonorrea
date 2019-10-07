# GAME MASTER SUPER CONTROLLER
extends Control

export (bool) var debug_skip_poop = false
enum Dimensions { FLAPPY, RUNNER, SLIDER, RND = -1 }
export (Dimensions) var debug_dimension = Dimensions.RND

var current_minigame
var _using_timer = false

func _ready():
	randomize()

	# conectar escuchadores de señales
	$Nowhere.connect("ENTER_DIMENSION", self, 'load_minigame')
	$HUD.connect('COUNTDOWN_OVER', self, 'start_minigame')
	$Tween.connect("tween_completed", self, '_on_tween_completed')
	
	if debug_skip_poop:
		$Nowhere.first_time_here = false

	load_portal()

func load_portal():
	$HUD.clean()
	
	if current_minigame: current_minigame.queue_free()
	$Nowhere.show()
	
	if Loader.get_available_dimensions() > 0:
		$Nowhere.start()
	else:
		$Nowhere.end()
		$HUD.show_end()

func load_minigame(form):
	$Nowhere.hide()
	_using_timer = false
	
	if debug_dimension < 0:
		current_minigame = Loader.get_random_dimension().instance()
	else:
		current_minigame = Loader.get_dimension(debug_dimension).instance()

	current_minigame.debug_wizard_form = ""
	current_minigame.connect("WIN", self, "_on_win")
	current_minigame.connect("DIE", self, "_on_die")
	current_minigame.connect("PROGRESS", $HUD, "update_progress")
	current_minigame.connect("TIMER", self, "start_timer")
	$CurrentMicroGame.add_child(current_minigame)
	
	start_countdown(form)

func start_countdown(form):
	current_minigame.set_wizard_form(Loader.get_form(form))
	$HUD.start_countdown(current_minigame.verb)
	
func start_minigame():
	current_minigame.paused = false
	current_minigame.start()

func disconnect_minigame():
	current_minigame.disconnect("WIN", self, "_on_win")
	current_minigame.disconnect("DIE", self, "_on_die")
	current_minigame.disconnect("PROGRESS", $HUD, "update_progress")
	current_minigame.disconnect("TIMER", self, "start_timer")

func _on_win():
	$Tween.stop(self)
	Loader.remove_current_dimension()
	disconnect_minigame()
	$HUD.show_win()
	yield(get_tree().create_timer(3), "timeout")
	load_portal()

func _on_die(reason):
	$Tween.stop(self)
	disconnect_minigame()
	$HUD.show_die(reason)
	yield(get_tree().create_timer(3), "timeout")
	load_portal()

func start_timer(duration = 10):
	_using_timer = true
	$HUD.update_timer(duration)
	$Tween.interpolate_method(
		self,
		"update_timer",
		duration,
		0,
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN,
		1
	)
	$Tween.start()

func update_timer(val):
	if int(val) == 0:
		current_minigame.die("TIME'S UP!")
	$HUD.update_timer(val)

func _on_tween_completed(_obj, _key):
	_using_timer = false