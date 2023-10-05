extends Node
class_name  Creature

signal dead

@export var creature_name: String
@export var creature_health: float
@export var body_parts: Array


func add_body_part(body_part:BodyPart):
	body_parts.append(body_part)

