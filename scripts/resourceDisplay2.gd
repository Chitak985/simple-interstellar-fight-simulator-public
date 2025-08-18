extends RichTextLabel

func _process(_delta):
	if(multiplayer.is_server()): return
	if(DataStorage.ownerIntName == 0): return
	
	var tmp = ""
	if(DataStorage.rocketFuel[DataStorage.ownerIntName] > 0):
		tmp += "Rocket Fuel: "+str(DataStorage.rocketFuelC[DataStorage.ownerIntName])+"/"+str(DataStorage.rocketFuel[DataStorage.ownerIntName])+"\n"
	if(DataStorage.ammo[DataStorage.ownerIntName] > 0):
		tmp += "Ammo: "+str(DataStorage.ammoC[DataStorage.ownerIntName])+"/"+str(DataStorage.ammo[DataStorage.ownerIntName])+"\n"
	if(tmp == ""):
		tmp = "None"
	text = tmp
