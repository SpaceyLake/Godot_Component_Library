extends Node
class_name DialogueController

var states:Dictionary
var keys:Dictionary
var texts:Dictionary

func get_key(word:String, state:String = ""):
	if state != "":
		return keys[word]
	else:
		return keys[state][word]

func get_text(key:String):
	return texts[key]
