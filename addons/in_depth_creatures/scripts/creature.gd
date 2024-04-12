extends Node
class_name  Creature

signal dead
signal flying(can_fly)
signal breathing(can_breathe)

@export var creature_name: String
@export var creature_health: float
@export var body_parts: Dictionary

var breathe = 0
var flier = 0

func setup_body():
	for i in BodyPart.Type.keys():
		body_parts[i] = []

func add_body_part(body_part:BodyPart):
	match body_part.type:
		BodyPart.Type.BREATHE:
			body_part.destroyed.connect(lost_lung)
		BodyPart.Type.FLIER:
			body_part.destroyed.connect(lost_wing)
	body_parts[body_part.type].append(body_part)

func lost_lung(lung:BodyPart):
	breathe -= 1
	if breathe < 1:
		breathing.emit()

func lost_wing(wing:BodyPart):
	flier -= 1
	if flier < 1:
		flying.emit()
