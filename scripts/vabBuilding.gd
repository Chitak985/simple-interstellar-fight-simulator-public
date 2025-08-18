extends StaticBody3D

var isPlaced = false

func iAmAPart(): pass

func _unhandled_input(event: InputEvent):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and !isPlaced:
			isPlaced = true
			DataStorage.objectsPosT.append([position.x,position.y])
	#if event is InputEventKey and event.pressed:
	#	if event.keycode == KEY_1:
			
	
	if(not isPlaced):
		position.x = round((get_viewport().get_mouse_position().x - (get_viewport().get_visible_rect().size.x / 2)) * 0.015)
		position.y = round((get_viewport().get_mouse_position().y - (get_viewport().get_visible_rect().size.y / 2)) * -0.015)
		
