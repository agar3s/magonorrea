extends KinematicBody2D

signal died

export(int) var x_speed = 65

func _ready():
	randomize()
	global_position.y += randi() % 220 - 200

func _physics_process(delta):
	move_and_slide(Vector2(-x_speed, 0))
	if global_position.x < 0:
		emit_signal("died")
		queue_free()
