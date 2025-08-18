extends Button

@onready var rootNode = get_tree().root.get_node("mainNode")

func _pressed():
	rootNode.pressed(name)
