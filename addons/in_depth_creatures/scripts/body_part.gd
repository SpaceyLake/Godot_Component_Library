extends Node
class_name BodyPart

signal destroyed
signal dead

enum Type {
	APERTURE, 		# Marks the body part as an opening in the body.
	BREATHE, 		# Body part is used to breathe.
	CIRCULATION,	# Body part is responsible for blood circulation.
	CONNECTOR,		# Body part is used to connect other body parts together.
	DIGIT,			# Defines part as a digit.
	FLIER,			# Flags the body part as being needed for flight.
	GRASP,			# Creature can wield a picked-up weapon with the body part.
	GUTS,			# Used for guts.
	HEAD,			# Body part is head.
	HEAR,			# Body part is used to hear.
	INTERNAL,		# Marks the body part as being inside the body.
	JOINT,			# Body part is a joint.
	LUNG,			# Body part is a lung.
	LIMB,			# Body part is a limb.
	MOUTH,			# Body part is a mouth.
	NERVOUS,		# Body part is the hub of nervous function.
	SKELETON,		# Body part is part of the creature's skeleton.
	SIGHT,			# Body part is used to see with.
	SMELL,			# Body part is used to smell.
	THROAT,			# Body part breaks off and goes flying if broken, even with blunt force.
	THOUGHT,		# The central core of the body. Used with the brain.
}

@export var part_name: String
@export var part_type: Type
@export var part_value: float
@export var part_health: float
@export var parent: BodyPart
@export var children: Array

func _init(p_name:String, p_types:Type, p_health:float = 100.0, p_value:float = 0.0, p_parent: BodyPart = null, p_children: Array = []):
	part_name = p_name
	part_type = p_types
	part_value = p_value
	part_health = p_health
	parent = p_parent
	children = p_children

func hit():
	pass

