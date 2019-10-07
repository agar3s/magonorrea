extends CanvasLayer

signal COUNTDOWN_OVER

func _ready():
	self.clean()

func show_win():
	$SFX_Win.play()
	$Container/Message.text = 'Fragment recovered!!'

func show_die(reason):
	$SFX_Die.play()
	$Container/Message.text = reason.capitalize()

func show_end():
	$Container/Message.text = 'Your talisman is back'

func start_countdown(message):
	$SFX_Countdown.play()
	$Container/Message.text = '3'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/Message.text = '2'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/Message.text = '1'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/Message.text = message
	yield(get_tree().create_timer(0.3), "timeout")
	$Container/Message.text = ''
	if message == 'fly':
		$SFX_Fly.play()
	if message == 'run':
		$SFX_Run.play()
	if message == 'slide':
		$SFX_Slide.play()
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