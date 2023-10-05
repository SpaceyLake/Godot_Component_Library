extends Node
class_name BodyPart

signal hurt
signal destroyed

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
@export var parent: BodyPart
@export var children: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
