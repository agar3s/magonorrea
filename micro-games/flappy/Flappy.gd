extends "res://micro-games/dimension.gd"

var chickens_threshold = -210

func _ready():
	# conectar escuchadores de señales
	for fork in $Forks.get_children():
		fork.connect('collision_detected', self, '_on_wizard_collide')
	$Ceil.connect("collision_detected", self, '_on_wizard_collide')
	$Floor.connect("collision_detected", self, '_on_wizard_collide')
	$Tween.connect("tween_completed", self, "roast")

	# poner los pollos a asar
	for f in $FireContainer.get_children():
		f.play("Burn")
	for c in $ChickensContainer.get_children():
		c.play("Spin")
	roast()
	
	# poner los bordes a arder
	for fb in $Floor/FireContainer.get_children():
		fb.play("Burn")
	for fb in $Ceil/FireContainer.get_children():
		fb.play("Burn")
	
	# play musica
	$MX_Kitchen.play()
	$BG_Kitchen.play()
	
	# verificar si hay que cargar algo pa' debug
	check_debug()

func _process(delta):
	if paused: return
	$Forks.global_position.x -= delta * level_velocity_x
	wizard.fall(GRAVITY)
	if int($Forks.global_position.x) % 10 == 0:
		emit_signal('PROGRESS', int(-100*($Forks.global_position.x)/total_distance))

func wizard_action(action):
	.wizard_action(action)
	
	if !action.empty():
		make_fly()

func _on_wizard_collide(element_type):
	._on_wizard_collide(element_type)
	if element_type=='fork':
		self.die('Forked!')
	elif element_type=='ceil' || element_type=='floor':
		self.die('Roasted!')


func set_wizard_form(form):
	.set_wizard_form(form)
	wizard.idle(false)
	level_velocity_x = wizard.fly_x
	total_distance = $Forks/Talisman.position.x - wizard.position.x - wizard.collision_width

func roast(a = 0, b = 0):
	for c in $ChickensContainer.get_children():
		if c.position.y == chickens_threshold:
			c.z_index = -1
			c.self_modulate = Color(0.5, 0.5, 0.5, 1.5)
		else:
			c.z_index = 0
			c.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
		$Tween.interpolate_property(
			c,
			"position:y",
			c.position.y,
			chickens_threshold if c.position.y > chickens_threshold else 495,
			3,
			Tween.TRANS_SINE,
			Tween.EASE_IN_OUT
		)
		$Tween.start()