extends CanvasLayer

signal COUNTDOWN_OVER

func _ready():
	self.clean()

func show_win():
	$Container/Message.text = 'Fragment recovered!!'

func show_die(reason):
	$Container/Message.text = reason.capitalize()

func show_end():
	$Container/Message.text = 'Your talisman is back'

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
	$Container/Progress.text = str(abs(progress)) + '%'
	$Container/Progress.text.capitalize()

func clean():
	$Container/Message.text = ''
	$Container/Progress.text = ''
	$Container/Time.text = ''

func update_timer(value):
	$Container/Time.set_text("%ds" % value)