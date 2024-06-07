@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type("DialogueController", "Node", preload("scripts/controller.gd"), preload("res://icon.svg"))
	add_custom_type("DialogueBox", "RichTextLabel", preload("scripts/text_box.gd"), preload("res://icon.svg"))
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("DialogueController")
	remove_custom_type("DialogueBox")
	pass
