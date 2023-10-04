@tool
extends Node
class_name Pool

@export var reference_resource:Node

var instant_pool:Array
var long_term_pool:Array
var free_pool:Array
var number_of_resources = 0

func _ready():
	reference_resource.pool_deactivate()
	number_of_resources = 0
	instant_pool = []
	long_term_pool = []
	free_pool = []

func _get_configuration_warnings():
	var warnings:Array = []
	if not reference_resource:
		warnings.append("The pool is missing a reference node with the functions pool_is_active(), pool_activate(args:Array) and pool_deactivate(), please add it from the Inspector")
	else:
		if not reference_resource.has_method("pool_is_active"):
			warnings.append("The reference node needs a pool_is_active() function to let the pool determine when to return resources.")
			
		if not reference_resource.has_method("pool_activate"):
			warnings.append("The reference node needs a pool_activate(args:Array) function to let the pool know how to activate a requested resource.")
			
		if not reference_resource.has_method("pool_deactivate"):
			warnings.append("The reference node needs a pool_deactivate() function to let the pool know how to deactivate a returned resource.")
	return PackedStringArray(warnings)

func return_resource(applicant:Node = null, resource_id:int = -1) -> bool:
	if applicant == null:
		if resource_id < 0:
			return false
		for i in instant_pool.size():
			if instant_pool[i].get_instance_id() != resource_id:
				continue
			if instant_pool[i].pool_is_active():
				instant_pool[i].pool_deactivate()
			free_pool.push_back(instant_pool.pop_at(i))
			return true
		return false
	
	if resource_id < 0:
		var resource_indexes = []
		for i in long_term_pool.size():
			if long_term_pool[i][0] == applicant:
				resource_indexes.push_front(i)
		for i in resource_indexes:
			if long_term_pool[i][1].pool_is_active():
				long_term_pool[i][1].pool_deactivate()
			free_pool.push_back(long_term_pool.pop_at(i)[1])
		return true
	
	for i in long_term_pool.size():
		if long_term_pool[i][1].get_instance_id() != resource_id:
			continue
		if long_term_pool[i][0] != applicant:
			return false
		if long_term_pool[i][1].pool_is_active():
			long_term_pool[i][1].pool_deactivate()
		free_pool.push_back(long_term_pool.pop_at(i)[1])
		return true
	return false

func request_resource(applicant:Node = null, params:Array = []) -> int:
	var resource = null
	
	if free_pool.size() > 0:
		resource = free_pool.pop_front()
	else:
		free_used_resources()
		if free_pool.size() > 0:
			resource = free_pool.pop_front()
	
	if resource == null:
		resource = reference_resource.duplicate()
		number_of_resources += 1
		add_child(resource)
	
	resource.pool_activate(params)
	
	if applicant == null:
		instant_pool.push_back(resource)
		return -1
	else:
		long_term_pool.push_back([applicant, resource])
		return resource.get_instance_id()

func free_used_resources() -> void:
	var resource_indexes:Array = []
	for i in instant_pool.size():
		if not instant_pool[i].pool_is_active():
			resource_indexes.push_front(i)
	for i in resource_indexes:
		free_pool.append(instant_pool.pop_at(i))
