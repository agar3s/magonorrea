extends "res://micro-games/dimension.gd"

var sliding = false

func _ready():
	$Wizard.connect("action_done", self, "wizard_action")
	for block in $Blocks.get_children():
		block.connect('collision_detected', self, '_on_wizard_collide')

# 56 i = 0
# 36 j = 0

func wizard_action(action):
	print('action =', action)
	if sliding or action=='action': return
	
	if action == 'left':
		$Wizard.mov.x = -480
	if action == 'right':
		$Wizard.mov.x = 480
	if action == 'up':
		$Wizard.mov.y = -480
	if action == 'down':
		$Wizard.mov.y = 480
	print('mov', $Wizard.mov)
	sliding = true

func _on_wizard_collide(element_type):
	._on_wizard_collide(element_type)

	if element_type=='block':
		sliding = false
		$Wizard.global_position.x = int(1+($Wizard.global_position.x-32)/48)*48+32-24
		$Wizard.global_position.y = int(1+($Wizard.global_position.y-12)/48)*48+12-24
