extends RichTextLabel

func _process(_delta):
	if(DataStorage.accelerationT <= 0):
		text = "Your current acceleration value is: Not enough thrust!\nWill not be able to launch!"
	else:
		text = "Your current acceleration value is: "+str(round(DataStorage.accelerationT * 100) / 100)
