extends Control

# micro games
var flappy = load("res://micro-games/flappy/Flappy.tscn")
var runner = load("res://micro-games/runner/Runner.tscn")

var dimensions = [flappy, runner]

var current_minigame
# CONTROLLER
var hen_form = load("res://Wizard/Hen.tscn")
var ostrich_form = load("res://Wizard/Ostrich.tscn")
var forms = [hen_form, ostrich_form]

func _ready():
	randomize()
	$Nowhere.connect("ENTER_DIMENSION", self, 'load_minigame')
	$HUD.connect('COUNTDOWN_OVER', self, 'start_minigame')
	load_portal()

func load_portal():
	if current_minigame: current_minigame.queue_free()
	$Nowhere.show()
	$Nowhere.start()

func load_minigame():
	$Nowhere.hide()
	var next = randi()%len(dimensions)
	current_minigame = dimensions[next].instance()
	current_minigame.connect("WIN", self, "_on_win")
	current_minigame.connect("DIE", self, "_on_die")
	current_minigame.connect("PROGRESS", $HUD, "update_progress")
	$CurrentMicroGame.add_child(current_minigame)
		
	start_countdown()

func start_countdown():
	var next = randi()%len(forms)

	current_minigame.set_wizard_form(forms[next])
	$HUD.start_countdown('fly')
	
func start_minigame():
	current_minigame.paused = false

func disconnect_minigame():
	current_minigame.disconnect("WIN", self, "_on_win")
	current_minigame.disconnect("DIE", self, "_on_die")

func _on_win():
	disconnect_minigame()
	$HUD.show_win()
	yield(get_tree().create_timer(3), "timeout")
	load_portal()

func _on_die():
	disconnect_minigame()
	$HUD.show_die()
	yield(get_tree().create_timer(3), "timeout")
	load_portal()

