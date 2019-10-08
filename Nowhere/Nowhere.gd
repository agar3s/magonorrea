extends Control

signal ENTER_DIMENSION(form_name)

enum SpawnPointId {A, B, C,  D,  E,  F,  G, RND = -1}
export (SpawnPointId) var debug_spawn_point = SpawnPointId.RND

var wizard = load("res://Wizard/Wizard.tscn")
var naked_wizard
var starting_positions = []
var form_choosed = false
var first_time_here = true
var wizard_rotation = 0
var wizard_floating = null
var found_pieces = 0
var win_piece = false
var trigger_words = false

func _ready():
	$Asterisk.hide()
	$TalismanContainer.hide()
	
	for potion in $Potions.get_children():
		potion.connect("pressed", self, "choose_potion", [potion.name])
		starting_positions.append(potion.rect_global_position)
	$Portal.connect("potions_spited", self, "start_countdown")
	$Portal.initialize($Potions.get_children())
	
	$BG_Nowhere.play()

func start():
	$BG_Nowhere.play()
	
	if first_time_here:
		first_time_here = false
		trigger_words = true
		$Asterisk.show()
		$Asterisk.connect("wizard_pooped", self, "_on_wizard_pooped")
		return

	# poner valores por defecto
	set_defaults()

	self.put_wizard()
	if trigger_words:
		yield(get_tree().create_timer(7.0), "timeout")

	yield(get_tree().create_timer(3.0), "timeout")
	
	var spawn_point
	if debug_spawn_point < 0:
		randomize()
		var random_point_idx = randi() % $SpawnPoints.get_children().size()
		spawn_point = $SpawnPoints.get_child(random_point_idx)
	else:
		spawn_point = $SpawnPoints.get_child(debug_spawn_point)

	$Portal.setup(spawn_point)

func choose_potion(name = "normal"):
	if form_choosed: return
	if name != "normal":
		$Potion_Pick.play()

	form_choosed = true
	yield($Portal.close_portal(), "completed")
	naked_wizard.queue_free()
	emit_signal('ENTER_DIMENSION', name.to_lower())
	$BG_Nowhere.stop()

func start_countdown():
	yield(get_tree().create_timer(3), "timeout")
	choose_potion()

func _on_wizard_pooped():
	wizard_rotation = $Asterisk/FakeWizard.rotation_degrees
	wizard_floating = "cw"
	$Asterisk.queue_free()
	self.start()

func end():
	$BG_Nowhere.play()

	set_defaults()
	put_wizard()

func put_wizard():
	naked_wizard = wizard.instance()
	naked_wizard.position = Vector2(512, 300)
	naked_wizard.rotation_degrees = wizard_rotation
	naked_wizard.in_nowhere = true
	add_child(naked_wizard)
	naked_wizard.z_index = 0
	

	$TalismanContainer.show()
	if trigger_words:
		$TalismanContainer/Float.start_floating()
		$TalismanContainer/Talisman/Float.start_floating()
	
	if win_piece:
		naked_wizard.rotation_degrees = 0
		if found_pieces<3:
			naked_wizard.get_node('Sprite').play('Happy')
		else:
			naked_wizard.get_node('Sprite').play('Dance_1')
			yield(naked_wizard.get_node('Sprite'), 'animation_finished')
			naked_wizard.get_node('Sprite').play('Dance_2')
		win_piece = false
	else:
		naked_wizard.get_node("Float").start_floating(wizard_floating)
		
	if trigger_words:
		for words in $Words.get_children():
			$Tween.interpolate_property(words, "self_modulate:a", 0.0, 1.0, 0.4, Tween.TRANS_SINE,Tween.EASE_IN)
			$Tween.interpolate_property(words, "position", words.position, Vector2(randi()%512+256,randi()%400+100), 4, Tween.TRANS_LINEAR,Tween.EASE_IN)
			$Tween.interpolate_property(words, "self_modulate:a", 1.0, 0.0, 0.4, Tween.TRANS_SINE,Tween.EASE_IN, 3.5)
			$Tween.start()
			yield(get_tree().create_timer(3.5), "timeout")
		
		trigger_words = false
		

func set_defaults():
	form_choosed = false
	for idx in range(starting_positions.size()):
		$Potions.get_child(idx).rect_global_position = starting_positions[idx]

func heal_talisman():
	win_piece = true
	found_pieces += 1
	if found_pieces <= 3:
		$TalismanContainer/Talisman.set_frame(found_pieces)

