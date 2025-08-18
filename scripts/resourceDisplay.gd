extends RichTextLabel

func _process(_delta):
	var tmp = ""
	if(DataStorage.rocketFuelT > 0):
		tmp += "Rocket Fuel: "+str(DataStorage.rocketFuelT)+"\n"
	if(DataStorage.ammoT > 0):
		tmp += "Ammo: "+str(DataStorage.ammoT)+"\n"
	if(tmp == ""):
		tmp = "None"
	text = tmp
