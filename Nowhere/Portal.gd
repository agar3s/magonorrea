extends Node2D

signal potions_spited

var potions

func _ready():
	$LightRef.hide()

func initialize(potions_ref):
	potions = potions_ref

func setup(spawn_point):
	self.global_position = spawn_point.global_position
	self.rotation_degrees = spawn_point.rotation_degrees

	# poner las posiones en su lugar de origen
	var shuffled_array = shuffle_childs($OriginPoints.get_children())
	for idx in range(potions.size()):
		var p = potions[idx]
		p.rect_global_position = shuffled_array[idx].global_position - (Vector2.ONE * 64)
	self.open_portal()

func open_portal():
	$AnimationPlayer.play("OpenPortal", -1, 2.0)
	yield($AnimationPlayer, "animation_finished")
	self.spit_potions()

func spit_potions():
	var pots = shuffle_childs(potions)
	var targets = shuffle_childs($TargetPoints.get_children())
	for index in range(pots.size()):
		$AnimationPlayer.play("SpitPotions")
		var p = pots[index]

		p.get_node("Float").start_floating()
		$Tween.interpolate_property(
			p,
			"rect_global_position",
			p.rect_global_position,
			targets[index].global_position - (Vector2.ONE * 64),
			0.8,
			Tween.TRANS_ELASTIC,
			Tween.EASE_OUT
		)
		$Tween.start()
		yield($Tween, "tween_completed")
	emit_signal("potions_spited")

func close_portal():
	$AnimationPlayer.play_backwards("OpenPortal")
	yield($AnimationPlayer, "animation_finished")

func shuffle_childs(source):
	var copy = source.duplicate()
	copy.shuffle()
	return copy