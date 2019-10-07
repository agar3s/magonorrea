extends "res://micro-games/dimension.gd"

export(int) var duration = 30

var sliding = false
var colliding_offset_y = 0
var cell_size = 42

onready var padding_x = $Blocks.position.x
onready var padding_y = $Blocks.position.y

func _ready():
	for block in $Blocks.get_children():
		block.connect('collision_detected', self, '_on_wizard_collide')
	$Top.connect('collision_detected', self, '_on_wizard_collide')
	$Left.connect('collision_detected', self, '_on_wizard_collide')
	$Bottom.connect('collision_detected', self, '_on_wizard_collide')
	$Right.connect('collision_detected', self, '_on_wizard_collide')
	check_debug()

# 56 i = 0
# 36 j = 0

func wizard_action(action):
	if sliding or action=='action': return
	
	yield(wizard.slide(action), "completed")
	if action == 'left':
		wizard.mov.x = -480
	if action == 'right':
		wizard.mov.x = 480
	if action == 'up':
		wizard.mov.y = -480
	if action == 'down':
		wizard.mov.y = 480

	sliding = true

func fix_position():
	wizard.global_position.x = int(1+(wizard.global_position.x-padding_x)/cell_size)*cell_size+padding_x-cell_size/2
	wizard.global_position.y = int(1+(wizard.global_position.y-padding_y)/cell_size)*cell_size+padding_y-cell_size/2 - colliding_offset_y
	wizard.idle()


func _on_wizard_collide(element_type):
	._on_wizard_collide(element_type)

	if element_type=='block':
		sliding = false
		fix_position()
	elif element_type == 'border':
		self.die('Out of the ring!')

func set_wizard_form(form):
	.set_wizard_form(form)
	wizard.set_scale(Vector2(0.6, 0.6))
	wizard.get_node('CollisionShape2D').position.y += colliding_offset_y
	wizard.idle()
	fix_position()

func start():
	emit_signal("TIMER", duration)