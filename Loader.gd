extends Node

var hen_form = load("res://Wizard/Hen.tscn")
var ostrich_form = load("res://Wizard/Ostrich.tscn")
var wizard_form = load("res://Wizard/Wizard.tscn")

func get_form(form_name):
	match form_name.to_lower():
		'hen':
			return hen_form
		'ostrich':
			return ostrich_form
		'normal':
			return wizard_form