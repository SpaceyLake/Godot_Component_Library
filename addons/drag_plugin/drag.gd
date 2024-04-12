extends Area2D
class_name Drag

signal pick_up(hold_position:Vector2)
signal drag(hold_position:Vector2)
signal drop(hold_position:Vector2)

@export var exclusive_hold:bool = true
@export var select_priority = 0

static var nr_reported_drags = 0
static var nr_drags = 0
static var holder = null
var mouse_on:bool = false
var mouse_hold:bool = false
var mouse_offset:Vector2 = Vector2.ZERO
var previous_global_position:Vector2 = Vector2.ZERO
var mouse_just_pressed = false
var mouse_pressed = false
var mouse_just_released = false

func _ready():
	nr_drags += 1

func _mouse_enter():
	mouse_on = true

func _mouse_exit():
	mouse_on = false

func get_hold():
	previous_global_position = global_position
	mouse_offset = get_viewport().get_mouse_position() - global_position
	global_position = get_viewport().get_mouse_position() - mouse_offset
	mouse_hold = true
	pick_up.emit(global_position)

func drop_hold():
	if exclusive_hold:
		holder = null
	mouse_hold = false
	var drop_position = global_position
	global_position = previous_global_position
	drop.emit(drop_position)

func _input(event):
	if event is InputEventMouseMotion and mouse_hold:
			global_position = event.position - mouse_offset
			drag.emit(global_position)
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and not event.is_echo():
		if exclusive_hold:
			if mouse_on:
				if holder == null or holder[1] <= select_priority:
					holder = [self, select_priority]
			nr_reported_drags += 1
			if nr_reported_drags == nr_drags:
				nr_reported_drags = 0
				if holder != null:
					holder[0].get_hold()
		elif mouse_on:
			get_hold()
	if event is InputEventMouseButton and not event.is_pressed() and mouse_hold and event.button_index == MOUSE_BUTTON_LEFT and not event.is_echo():
		drop_hold()

func _on_mouse_entered():
	mouse_on = true

func _on_mouse_exited():
	mouse_on = false
