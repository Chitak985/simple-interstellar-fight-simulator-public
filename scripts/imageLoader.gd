extends Node3D

var vabButton = preload("res://scenes/buttons/VABBuildingButton.tscn")
var partsIDs = {}

func pressed(buttonN):
	var camera = get_node("WorldEnvironment/Camera3D")
	buttonN = str(buttonN)
	if(buttonN.begins_with("Button")):
		camera.spawn(partsIDs[int(buttonN[6])])
	elif(buttonN == "ButtonLaunch"):
		camera.launch()
	else:
		push_error("imageLoader: pressed("+str(buttonN)+"): Unknown buttonN!")

func _ready():
	var parts = ResourceLoader.list_directory("res://partData/stock")
	var dataDict;
	var nextButtonY = 0
	
	for i in range(parts.size()):
		partsIDs[i] = parts[i]
		var tmp = vabButton.instantiate()
		add_child(tmp)
		tmp.position.y = nextButtonY
		tmp.name = "Button"+str(i)
		nextButtonY += 77
	
		dataDict = JSON.parse_string(FileAccess.get_file_as_string("res://partData/stock/"+str(parts[i])+"data.json"))
		get_node("Button"+str(i)+"/Image").texture = load("res://partData/stock/"+str(parts[i])+"image.png")
		get_node("Button"+str(i)).text = dataDict["name"]
