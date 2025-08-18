extends Node3D

var shatteredPlanetPart = preload("res://scenes/shattered_planet_part.tscn")
var random = RandomNumberGenerator.new()

func _ready():
	var tmp
	var tmp2
	for i in range(1000):
		tmp = shatteredPlanetPart.instantiate()
		get_node("shatteredPlanet").add_child(tmp)
		
		# Shattered Planet-style random points
		tmp.position = Vector3(random.randf_range(-1,1),random.randf_range(-1,1),random.randf_range(-1,1)).normalized()*random.randf()*80
		tmp.position.y = random.randf_range(-10,10)
		
		tmp2 = random.randf_range(0.5,3)
		tmp.get_node("MeshInstance3D").scale = Vector3(tmp2,tmp2,tmp2)
		tmp.get_node("CollisionShape3D").scale = Vector3(tmp2,tmp2,tmp2)
		tmp.rotation = Vector3(random.randi_range(0,359),random.randi_range(0,359),random.randi_range(0,359))
