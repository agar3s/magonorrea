extends Node

# las formas del mago
var hen_form = load("res://Wizard/Hen.tscn")
var ostrich_form = load("res://Wizard/Ostrich.tscn")
var wizard_form = load("res://Wizard/Wizard.tscn")

# las dimensiones del universo
var flappy = load("res://micro-games/flappy/Flappy.tscn")
var runner = load("res://micro-games/runner/Runner.tscn")
var slider = load("res://micro-games/slider/Slider.tscn")
var dimensions = [ flappy, runner, slider ]

var current_dimension = -1

func get_form(form_name):
	match form_name.to_lower():
		'hen':
			return hen_form
		'ostrich':
			return ostrich_form
		'normal':
			return wizard_form

func get_random_dimension():
	current_dimension = randi() % len(dimensions)
	return dimensions[current_dimension]

func get_dimension(idx):
	return dimensions[idx]

func remove_current_dimension():
	dimensions.remove(current_dimension)
	current_dimension = -1

func get_available_dimensions():
	return dimensions.size()