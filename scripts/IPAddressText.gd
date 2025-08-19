extends RichTextLabel

func _ready():
	text = "Your current IP Address is "+str(DataStorage.IP_ADDRESS)
