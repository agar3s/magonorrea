extends CanvasLayer

signal COUNTDOWN_OVER

func _ready():
	self.clean()

func show_win():
	$Container/Message.text = 'WIN!!'

func show_die():
	$Container/Message.text = 'DIE!!'

func start_countdown(message):
	$Container/Message.text = '3'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/Message.text = '2'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/Message.text = '1'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/Message.text = message
	yield(get_tree().create_timer(0.3), "timeout")
	$Container/Message.text = ''
	emit_signal('COUNTDOWN_OVER')

func update_progress(progress):
	$Container/Progress.text = str(progress)

func clean():
	$Container/Message.text = ''
	$Container/Progress.text = ''