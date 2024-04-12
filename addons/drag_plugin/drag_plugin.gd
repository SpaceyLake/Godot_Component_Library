@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Drag", "Area2D", preload("drag.gd"), preload("res://icon.svg"))

func _exit_tree():
	remove_custom_type("Drag")
