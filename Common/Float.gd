extends Node2D

func start_floating():
	# determinar sobre qué propiedad se hará la rotación
	var rotation_prop = "rect_rotation"  \
		if get_parent().is_in_group("controls") \
		else "rotation_degrees"

	# definir valores aleatorios para dirección y duración del giro
	randomize()
	$Tween.interpolate_property(
		get_parent(),
		rotation_prop,
		0,
		360 if randi() % 21 < 10 else -360,
		randi() % 5 + 5,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	$Tween.start()
