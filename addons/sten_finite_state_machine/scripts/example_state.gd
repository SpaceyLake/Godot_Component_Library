extends State
class_name ExampleState

@export var character: CharacterBody2D
@export var move_speed:float = 10.0

var move_direction:Vector2
var wander_time:float

func randomize_wander():
	move_direction= Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)

func enter(_msg := {}):
	randomize_wander()

func update(delta:float):
	if wander_time > 0:
		wander_time -= delta

func physics_update(delta:float):
	if character:
		character.velocity = move_direction * move_speed
