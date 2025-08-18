extends Camera3D

@onready var rootNode = get_tree().root.get_node("RootNode")

func _process(_delta):
	look_at(rootNode.get_node("shatteredPlanet").position)
	translate_object_local(Vector3(-0.5,0,0))
