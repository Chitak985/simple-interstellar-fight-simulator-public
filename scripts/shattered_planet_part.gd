extends RigidBody3D

func _physics_process(_delta):
	for i in get_colliding_bodies():
		look_at(self.position)
		rotate_y(180)
		if(i is RigidBody3D):
			apply_impulse(rotation*i.linear_velocity*100)
		elif(i is CharacterBody3D):
			apply_impulse(rotation*i.velocity*100)
