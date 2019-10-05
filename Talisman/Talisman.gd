extends Node2D

var velocity_y = 20
var movement_threshold = 100
var down = true

func _ready():
	$Area2D.connect("body_entered", self, "_on_collision_detected")
	move()
	$Tween.connect("tween_all_completed", self, "move")

func _on_collision_detected(body):
	get_tree().paused = true

func move():
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