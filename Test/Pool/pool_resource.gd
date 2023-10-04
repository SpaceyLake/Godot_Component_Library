extends AudioStreamPlayer

func pool_activate(params:Array):
	stream = params[0]
	play(0)

func pool_deactivate():
	stop()

func pool_is_active():
	return playing
