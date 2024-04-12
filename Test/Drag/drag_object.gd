extends Node2D

var shadow:Sprite2D = null

func _on_drag_drag(hold_position):
	shadow.global_position = hold_position


func _on_drag_drop(hold_position):
	remove_child(shadow)
	shadow.queue_free()
	shadow = null
	global_position = hold_position


func _on_drag_pick_up(hold_position):
	shadow = $Icon.duplicate()
	add_child(shadow)
	shadow.modulate = 0xFFFFFF7F
	shadow.global_position = hold_position
