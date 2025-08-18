extends CharacterBody3D

# TODO: Make objectsPos and objectsName syncronize
# TODO: Make bullets syncronize

var lifetimeTimer = 0
var startRotation = Vector3.ZERO
var speed = 5
@export var intName = 0
@export var intOwner = 0
@export var ownerObj:CharacterBody3D
@export var real = true

const partExplosion1 = preload('res://scenes/partExplosion1.tscn')
@onready var rootNode = get_tree().root.get_node("RootNode")

func iAmABullet(): pass

func _physics_process(_delta):
	var tmp
	var tmp2
	var tmp3
	
	if(real):
		for i in $RigidBody3D.get_colliding_bodies():
			if(i is CharacterBody3D and !i.has_method("iAmABullet")):
				if(i.objectsPos[i.intName].size() > 0):
					print("BOOM")
					tmp = []
					tmp2 = []
					for i2 in range(len(i.objectsPos[i.intName])):
						# Y LOCK (2.5D) ----------------------------------------------------------\/
						tmp.append(position.distance_to(Vector3(i.objectsPos[i.intName][i2][0], -3.108, i.objectsPos[i.intName][i2][1])))
						tmp2.append(i2)
					#tmp.append(position.direction_to(i.position))
					#tmp2.append("Root")
					
					tmp3 = partExplosion1.instantiate()
					i.add_child(tmp3)
					tmp3.position.y = -3.108  # Y LOCK (2.5D)
					
					#if(tmp2[tmp.find(tmp.max())] == "Root"):
					#	i.destroyed = true
					#	tmp3.position = i.position
					#else:
					if(true):
						tmp3.position.x = i.objectsPos[i.intName][tmp2[tmp.find(tmp.max())]][0]
						tmp3.position.z = i.objectsPos[i.intName][tmp2[tmp.find(tmp.max())]][1]
						i.objectsPos[i.intName].pop_at(tmp2[tmp.find(tmp.max())])
						i.objectsName[i.intName].pop_at(tmp2[tmp.find(tmp.max())])
					
					ownerObj.bullets[intOwner].pop_at(ownerObj.bullets[intOwner].find(intName))
					
					# TODO Update the stuff on the other client
					
					# Updating all of them works for some reason lmao (who needs optimization)
					for i3 in i.players:  # Target's players
						if(i3[0] == str(i.intName)):  # If target
							i3[1] = 10   # Reset object refresh timer
						if(i3[0] == str(intOwner)):  # If owner
							i3[1] = 10   # Reset object refresh timer
					for i3 in ownerObj.players:  # Owner's players
						if(i3[0] == str(i.intName)):  # If target
							i3[1] = 10   # Reset object refresh timer
						if(i3[0] == str(intOwner)):  # If owner
							i3[1] = 10   # Reset object refresh timer
							
					self.queue_free()
				else:
					print("nothing left bruh")
				
			
		lifetimeTimer += 1
		if(lifetimeTimer > 500):
			ownerObj.bullets[intOwner].pop_at(ownerObj.bullets[intOwner].find(intName))
			self.queue_free()
		
		position.y = -3.108  # Y LOCK (2.5D)

		for i in ownerObj.bullets[intOwner]:
			if(i[0] == intName):
				i[1] = global_position

		velocity.x -= (sin(startRotation.y) * speed)
		velocity.z -= (cos(startRotation.y) * speed)
		move_and_slide()
