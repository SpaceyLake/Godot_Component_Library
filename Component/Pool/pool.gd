extends Node
class_name Pool

var type
var is_native:bool
var instant_pool:Array
var long_term_pool:Array
var free_pool:Array
var number_of_resources = 0

func _ready():
	number_of_resources = 0
	instant_pool = []
	long_term_pool = []
	free_pool = []
	
	if type is PackedScene:
		is_native = false
	else:
		is_native = true

func return_resource(applicant:Node = null, resource_id:int = -1) -> bool:
	if applicant == null:
		if resource_id < 0:
			return false
		for i in instant_pool.size():
			if instant_pool[i].get_instance_id() != resource_id:
				continue
			if is_running(instant_pool[i]):
				deactivate(instant_pool[i])
			free_pool.push_back(instant_pool.pop_at(i))
			return true
		return false
	
	if resource_id < 0:
		var resource_indexes = []
		for i in long_term_pool.size():
			if long_term_pool[i][0] == applicant:
				resource_indexes.push_front(i)
		for i in resource_indexes:
			if is_running(long_term_pool[i][1]):
				deactivate(long_term_pool[i][1])
			free_pool.push_back(long_term_pool.pop_at(i)[1])
		return true
	
	for i in long_term_pool.size():
		if long_term_pool[i][1].get_instance_id() != resource_id:
			continue
		if long_term_pool[i][0] != applicant:
			return false
		if is_running(long_term_pool[i][1]):
			deactivate(long_term_pool[i][1])
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
		resource = type.instantiate() if not is_native else type.new()
		number_of_resources += 1
		add_child(resource)
	
	activate(resource, params)
	
	if applicant == null:
		instant_pool.push_back(resource)
		return -1
	else:
		long_term_pool.push_back([applicant, resource])
		return resource.get_instance_id()

func activate(_activating_resource:Node, _params:Array) -> void:
	pass

func deactivate(_deactivating_resource:Node) -> void:
	pass

func is_running(_running_resource:Node) -> bool:
	return false

func free_used_resources() -> void:
	var resource_indexes:Array = []
	for i in instant_pool.size():
		if not is_running(instant_pool[i]):
			resource_indexes.push_front(i)
	for i in resource_indexes:
		free_pool.append(instant_pool.pop_at(i))
