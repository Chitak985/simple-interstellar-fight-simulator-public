extends AudioStreamPlayer

func _process(_delta):
	if(!DataStorage.muteAudio and !playing):
		self.play()
