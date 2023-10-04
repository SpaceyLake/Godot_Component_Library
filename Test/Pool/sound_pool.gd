extends Pool
class_name SoundPool

func _ready():
	super()
	type = AudioStreamPlayer

func activate(activating_resource:Node, params:Array) -> void:
	activating_resource.stream = params[0]
	activating_resource.play(0)

func deactivate(deactivating_resource:Node) -> void:
	deactivating_resource.stop()

func is_running(running_resource:Node) -> bool:
	return running_resource.playing
