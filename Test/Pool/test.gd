extends Node2D

@export var sound_pool:SoundPool

var music:AudioStream = load("res://Resources/Music/song.wav")
var sound:AudioStream = load("res://Resources/Sound/explosion_big.wav")

var allocated_resource = []

func _input(event:InputEvent):
	if event is InputEventKey and event.pressed and event.keycode == KEY_K and not event.echo:
		sound_pool.request_resource(null, [sound])
	if event is InputEventKey and event.pressed and event.keycode == KEY_G and not event.echo:
		allocated_resource.push_back(sound_pool.request_resource(self, [music]))
	if event is InputEventKey and event.pressed and event.keycode == KEY_H and not event.echo:
		sound_pool.return_resource(self, allocated_resource.pop_front())
