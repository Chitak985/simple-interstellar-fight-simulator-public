extends Button

func _pressed():
	# Reset DataStorage here
	DataStorage.objectsPos = []
	DataStorage.objectsName = []
	DataStorage.currentSpeed = Vector3.ZERO
	DataStorage.acceleration = 0
	DataStorage.rocketFuelUsage = 0
	DataStorage.rocketFuel = 0
	DataStorage.ammo = 0
	DataStorage.rocketFuelC = 0
	DataStorage.ammoC = 0
	
	get_tree().change_scene_to_file("res://scenes/mainScenes/vab.tscn")
