extends "res://Common/Collider.gd"

var velocity_y = 20
var movement_threshold = 80
var down = true

export (bool) var debug_movable = true

func _ready():
	self.type = 'talisman'
	if debug_movable:
		move()
		$Tween.connect("tween_completed", self, "move")

func move(a=0, b=0):
	print(position.y)
	$Tween.interpolate_property(
		self,
		"position:y",
		position.y,
		(movement_threshold if down else -movement_threshold) + 300,
		1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
	down = !down
