extends Node2D

# micro games
var flappy = load("res://micro-games/flappy/Flappy.tscn")
var runner = load("res://micro-games/runner/Runner.tscn")

var current_minigame
# CONTROLLER
var hen_form = load("res://Wizard/Hen.tscn")

func _ready():
	current_minigame = runner.instance()
	current_minigame.connect("WIN", self, "_on_win")
	current_minigame.connect("DIE", self, "_on_die")
	current_minigame.connect("PROGRESS", $HUD, "update_progress")
	$CurrentMicroGame.add_child(current_minigame)
	
	$HUD.connect('COUNTDOWN_OVER', self, 'start_minigame')
	start_countdown()

func start_countdown():
	$HUD.start_countdown('fly')
	
func start_minigame():
	current_minigame.set_wizard_form(hen_form)
	current_minigame.paused = false

func _on_win():
	$HUD.show_win()

func _on_die():
	$HUD.show_die()

