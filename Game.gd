extends Node2D

# CONTROLLER

func _ready():
	$CurrentMicroGame/Flappy.connect("WIN", self, "_on_win")
	$CurrentMicroGame/Flappy.connect("DIE", self, "_on_die")
	$HUD.connect('COUNTDOWN_OVER', self, 'start_minigame')
	$CurrentMicroGame/Flappy.connect('PROGRESS', $HUD, 'update_progress')
	start_countdown()

func start_countdown():
	$HUD.start_countdown('fly')
	
func start_minigame():
	$CurrentMicroGame/Flappy.paused = false

func _on_win():
	$HUD.show_win()

func _on_die():
	$HUD.show_die()

