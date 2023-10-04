@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Pool", "Node", preload("pool.gd"), preload("res://icon.svg"))

func _exit_tree():
	remove_custom_type("Pool")
