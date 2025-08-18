extends DirectionalLight3D

var tmp = 0;
func _physics_process(_delta):
	tmp += 0.01
	#global_rotation = Vector3(PI * 0.01 + tmp, 0, 0)
