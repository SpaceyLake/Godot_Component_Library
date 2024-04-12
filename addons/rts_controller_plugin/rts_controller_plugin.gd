@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("RTS Controller", "Area2D", preload("rts_controller.gd"), preload("res://icon.svg"))
	add_custom_type("RTS Unit", "Area2D", preload("rts_unit.gd"), preload("res://icon.svg"))

func _exit_tree():
	remove_custom_type("RTS Controller")
	remove_custom_type("RTS Unit")
