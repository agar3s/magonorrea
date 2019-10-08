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
	$MX_Credits.play()
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/wizard_again.show()
	yield(get_tree().create_timer(1.8), "timeout")
	$Container/thanks.show()
	
func start_countdown(message):
	if message == 'slide':
		$Container/tutorial_arrows.show()
	else:
		$Container/tutorial_click.show()
	$SFX_Countdown.play()
	$Container/Message.text = '3'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/Message.text = '2'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/Message.text = '1'
	yield(get_tree().create_timer(0.6), "timeout")
	$Container/tutorial_arrows.hide()
	$Container/tutorial_click.hide()
	$Container/Message.text = message
	if message == 'fly':
		$SFX_Fly.play()
	if message == 'run':
		$SFX_Run.play()
	if message == 'slide':
		$SFX_Slide.play()
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