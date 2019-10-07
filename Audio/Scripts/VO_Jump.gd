extends "res://Audio/Scripts/RandomTool.gd"

export (int) var weight=60

func playsound():
	randomize()
	var randomNumber = randi()%100
	if randomNumber <= weight:
		.playsound()
	
