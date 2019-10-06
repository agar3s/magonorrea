extends Node2D

var potions

func _ready():
	$LightRef.hide()

func initialize(potions_ref):
	potions = potions_ref

func setup():
	# poner las posiones en su lugar de origen
	for idx in range(potions.size()):
		var p = potions[idx]
		p.rect_global_position = $OriginPoints.get_child(idx).global_position
	self.open_portal()

func open_portal():
	$AnimationPlayer.play("OpenPortal", -1, 2.0)
	yield($AnimationPlayer, "animation_finished")
	self.spit_potions()

func spit_potions():
	for index in range(potions.size()):
		$AnimationPlayer.play("SpitPotions")
		var p = potions[index]
		$Tween.interpolate_property(
			p,
			"rect_global_position",
			p.rect_global_position,
			$TargetPoints.get_child(index).global_position,
			0.8,
			Tween.TRANS_ELASTIC,
			Tween.EASE_OUT
		)
		$Tween.start()
		yield($Tween, "tween_completed")

func close_portal():
	$AnimationPlayer.play_backwards("OpenPortal")