extends Node
class_name WaveFunctionCollapseTile

@export var tile:Vector2i
@export var possible:Array
@export var pos:Vector3i
@export var done:bool = false

func _init(POSITION:Vector3i, POSSIBLE:Array):
	pos = POSITION
	possible = POSSIBLE
