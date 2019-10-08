extends Node2D

func start_floating(side = ""):
	# determinar sobre qué propiedad se hará la rotación
	var is_control = get_parent().is_in_group("controls")
	var start_angle = get_parent().rect_rotation if is_control else get_parent().rotation_degrees
	var end_angle = start_angle + (360 if randi() % 21 < 10 else -360)
	if side == "acw":
		end_angle = start_angle + 360
	elif side == "cw":
		end_angle = start_angle - 360

	# definir valores aleatorios para dirección y duración del giro
	randomize()
	$Tween.interpolate_property(
		get_parent(),
		"rect_rotation" if is_control else "rotation_degrees",
		start_angle,
		end_angle,
		randi() % 5 + 5,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	$Tween.start()

func stop_floating():
	$Tween.stop(get_parent())