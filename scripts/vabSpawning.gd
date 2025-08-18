extends Camera3D

func spawn(n):
	var tmp = load("res://partData/stock/"+str(n)+"prefab.tscn").instantiate()
	add_child(tmp)
	tmp.position.z = -7
	if(n == "engine1/"):
		DataStorage.objectsNameT.append(4)
		DataStorage.accelerationT += 0.5
		DataStorage.rocketFuelT += 10
		DataStorage.rocketFuelUsageT += 1
	elif(n == "machineGun1/"):
		DataStorage.objectsNameT.append(3)
		DataStorage.accelerationT -= 0.2
		DataStorage.ammoT += 10
	elif(n == "ammoBox/"):
		DataStorage.objectsNameT.append(2)
		DataStorage.accelerationT -= 0.1
		DataStorage.ammoT += 50
	elif(n == "fuelTank1/"):
		DataStorage.objectsNameT.append(1)
		DataStorage.accelerationT -= 0.2
		DataStorage.rocketFuelT += 50
	else:
		push_error("vabSpawning: spawn("+str(n)+"): Unknown n!")

func launch():
	if(DataStorage.accelerationT > 0):
		get_tree().change_scene_to_file("res://main.tscn")

func _unhandled_input(event: InputEvent):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
