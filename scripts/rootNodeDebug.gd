extends Node3D

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_P:
			print(get_tree_string_pretty())
