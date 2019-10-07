extends Sprite

signal wizard_pooped

var _poop_step = 0
var _going_back = false
var poposeado = false
func _ready():
	$TextureButton.connect("pressed", self, "_on_interacted")
	self.set_frame(0)

func _on_interacted():
	if poposeado: return
	_poop_step += 1
	$SFX_Asterisco.playsound()
	if _poop_step >= 3:
		$SFX_Asterisco.playsound()
		$TextureButton.disconnect("pressed", self, "_on_interacted")
		
	if _going_back:
		_going_back = false
		$AnimationPlayer.stop(false)
		$AnimationPlayer.play("Poop%d" % (_poop_step-1), 1)
		yield($AnimationPlayer, "animation_finished")
	

	$AnimationPlayer.play("Poop%d" % _poop_step)
	yield($AnimationPlayer, "animation_finished")
	
	if _poop_step < 3:
		_going_back = true
		$AnimationPlayer.play("Poop%d" % _poop_step, -1, -0.2, true)
	elif not poposeado:
		poposeado = true
		$TextureButton.queue_free()
		emit_signal("wizard_pooped")