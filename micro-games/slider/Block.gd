tool
extends "res://Common/Collider.gd"

export (int) var i = 0
export (int) var j = 0

func _ready():
	position.x = (i+0.5)*42
	position.y = (j+0.5)*42
