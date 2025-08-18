extends Button

func _enter_tree():
	if(name == "ButtonMute"):
		if(DataStorage.muteAudio):
			text = "Unmute audio"
		else:
			text = "Mute audio"

func _pressed():
	if(name == "ButtonPlay"):
		get_tree().change_scene_to_file("res://scenes/mainScenes/vab.tscn")
	elif(name == "ButtonJoin"):
		get_tree().change_scene_to_file("res://scenes/mainScenes/main.tscn")
		DataStorage.start_client()
		DataStorage.playing = true
	elif(name == "ButtonCreate"):
		get_tree().change_scene_to_file("res://scenes/mainScenes/main.tscn")
		DataStorage.start_server()
	elif(name == "ButtonMute"):
		if(text.begins_with("Unmute")):
			DataStorage.muteAudio = false
			text = "Mute audio"
		else:
			DataStorage.muteAudio = true
			text = "Unmute audio"
