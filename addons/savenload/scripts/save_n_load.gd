extends Node
class_name SaveNLoad

const NO_FILE = -1
const UNEXPECTED_DATA = -2

@export var path:String = "user://data.dat"

func load_data():
	var content
	var file = FileAccess.open(path, FileAccess.READ)
	if file != null:
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		file.close()
		if error == OK:
			if json.data == TYPE_DICTIONARY:
				return json.data
			else:
				return UNEXPECTED_DATA
		else:
			return error
	return NO_FILE

func save_data(save: Dictionary):
	var content = str(save)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(content)
	file.close()
