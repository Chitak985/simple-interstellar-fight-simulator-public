extends CharacterBody3D

const fuelTank = preload("res://partData/stock/fuelTank1/prefab.tscn")
const ammoBox = preload("res://partData/stock/ammoBox/prefab.tscn")
const machineGun = preload("res://partData/stock/machineGun1/prefab.tscn")
const engine1 = preload("res://partData/stock/engine1/prefab.tscn")

const bullet1 = preload("res://scenes/bullet1Prefab.tscn")
const camera3d = preload("res://scenes/camera_3d.tscn")

var speed = 0

#var target_velocity = Vector3.ZERO
var actionPressed = 0
var rotationY = 0
var rotationX = 0
var rotationZ = 0
var lock = false

@export var objectsName = {}
@export var objectsPos = {}
@export var intName = 0
@export var bullets = {}
@export var players = []
@export var destroyed = false

@onready var rootNode = get_tree().root.get_node("RootNode")

func _enter_tree():
	position.z -= 150
	intName = name.to_int()
	set_multiplayer_authority(intName)
	if not is_multiplayer_authority(): return
	print(intName)
	bullets[intName] = []
	players.append([str(intName),10])
	DataStorage.ownerIntName = intName
	DataStorage.acceleration[intName] = DataStorage.accelerationT
	DataStorage.rocketFuelUsage[intName] = DataStorage.rocketFuelUsageT
	DataStorage.rocketFuel[intName] = DataStorage.rocketFuelT
	DataStorage.ammo[intName] = DataStorage.ammoT
	DataStorage.rocketFuelC[intName] = DataStorage.rocketFuelCT
	DataStorage.ammoC[intName] = DataStorage.ammoCT
	DataStorage.objectsName[intName] = DataStorage.objectsNameT
	DataStorage.objectsNameT = []
	DataStorage.objectsPos[intName] = DataStorage.objectsPosT
	DataStorage.objectsPosT = []
	DataStorage.currentSpeed[intName] = Vector3.ZERO
	objectsName = DataStorage.objectsName
	objectsPos = DataStorage.objectsPos

func _ready():
	if not is_multiplayer_authority(): return
	var tmp3 = camera3d.instantiate()
	find_child("Node3D").add_child(tmp3)
	tmp3.position.y = 1.5
	tmp3.position.z = 5
	
	speed = DataStorage.acceleration[intName]
	DataStorage.rocketFuelC[intName] = DataStorage.rocketFuel[intName]
	DataStorage.ammoC[intName] = DataStorage.ammo[intName]
	for i in range(DataStorage.objectsName[intName].size()):
		if(DataStorage.objectsName[intName][i] == 1):
			var tmp = fuelTank.instantiate()
			add_child(tmp)
		
			tmp.isPlaced = true
			tmp.position.x = DataStorage.objectsPos[intName][i][0]
			tmp.position.z = -DataStorage.objectsPos[intName][i][1]
			
			var tmp2 = tmp.get_child(0)
			tmp2.reparent(self)
			tmp2.position.x = DataStorage.objectsPos[intName][i][0]
			tmp2.position.z = -DataStorage.objectsPos[intName][i][1]
			

		if(DataStorage.objectsName[intName][i] == 2):
			var tmp = ammoBox.instantiate()
			add_child(tmp)
			
			tmp.isPlaced = true
			tmp.position.x = DataStorage.objectsPos[intName][i][0]
			tmp.position.z = -DataStorage.objectsPos[intName][i][1]
			
			var tmp2 = tmp.get_child(0)
			tmp2.reparent(self)
			tmp2.position.x = DataStorage.objectsPos[intName][i][0]
			tmp2.position.z = -DataStorage.objectsPos[intName][i][1]
			
			
		if(DataStorage.objectsName[intName][i] == 3):
			var tmp = machineGun.instantiate()
			add_child(tmp)
			tmp.isPlaced = true
			tmp.position.x = DataStorage.objectsPos[intName][i][0]
			tmp.position.z = -DataStorage.objectsPos[intName][i][1]
			tmp.rotation.x = -1.57
			
			var tmp2 = tmp.get_child(0)
			tmp2.reparent(self)
			tmp2.position.x = DataStorage.objectsPos[intName][i][0]
			tmp2.position.z = -DataStorage.objectsPos[intName][i][1]
			
			tmp2 = tmp.get_child(1).get_child(0)
			tmp2.reparent(self)
			tmp2.position.x = DataStorage.objectsPos[intName][i][0]
			tmp2.position.z = -DataStorage.objectsPos[intName][i][1]
			tmp2.name = "|machineGun|1"
			
			
		if(DataStorage.objectsName[intName][i] == 4):
			var tmp = engine1.instantiate()
			self.add_child(tmp)
			tmp.isPlaced = true
			tmp.position.x = DataStorage.objectsPos[intName][i][0]
			tmp.position.z = -DataStorage.objectsPos[intName][i][1]
			tmp.rotation.x = -1.57
			
			var tmp2 = tmp.get_child(0)
			tmp2.reparent(self)
			tmp2.position.x = DataStorage.objectsPos[intName][i][0]
			tmp2.position.z = -DataStorage.objectsPos[intName][i][1]
			
			tmp2 = tmp.get_child(1).get_child(0)
			tmp2.reparent(self)
			tmp2.position.x = DataStorage.objectsPos[intName][i][0]
			tmp2.position.z = -DataStorage.objectsPos[intName][i][1]
			
			
func _unhandled_input(event):
	if not is_multiplayer_authority(): return
	
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
		
		if event.pressed and event.keycode == KEY_R:
			for i in players:
				i[1] = 10
		
		if event.pressed and event.keycode == KEY_SPACE and DataStorage.ammoC[intName] > 0:
			# !FIX: This doesn't position bullets properly
			for i in range(get_children().size()):
				if(get_children()[i].name.get_slice("|",1) == "machineGun"):
					DataStorage.ammoC[intName] -= 1
					var tmp = bullet1.instantiate()
					rootNode.add_child(tmp)
					tmp.startRotation = get_children()[i].global_rotation
					tmp.global_position = get_children()[i].global_position
					tmp.global_position.x -= sin(get_children()[i].global_rotation.y) * 5
					tmp.global_position.z -= cos(get_children()[i].global_rotation.y) * 5
					#tmp.position.x += get_children()[i].position.x
					#tmp.position.z += get_children()[i].position.z
					tmp.velocity = velocity
					tmp.intName = tmp.name.to_int()
					tmp.intOwner = intName
					tmp.ownerObj = self
					tmp.real = true
					bullets[intName].append([tmp.intName,tmp.global_position,false])
				
		#if event.pressed and event.keycode == KEY_D:
		#	rotationY -= 1
		#if event.pressed and event.keycode == KEY_A:
		#	rotationY += 1
		#if event.pressed and event.keycode == KEY_W:
		#	rotationX -= 1
		#if event.pressed and event.keycode == KEY_S:
		#	rotationX += 1
		#if event.pressed and event.keycode == KEY_E:
		#	rotationZ -= 1
		#if event.pressed and event.keycode == KEY_Q:
		#	rotationZ += 1
		
		#if event.pressed and event.keycode == KEY_P:  # AIRPARK
		#	if(lock):
		#		lock = false
		#	else:
		#		lock = true

func _physics_process(_delta):
	var tmp
	var tmp2
	
	#if(destroyed):   Doesn't work, destroys the ship who is the destroyer somehow
	#	multiplayer.multiplayer_peer.close()
	#	get_tree().change_scene_to_file("res://mainMenu.tscn")
	#	return

	for i2 in players:  # Build another player
		if(i2[1] > 0 and DataStorage.playing):              # [1] is the counter
			i2[1] -= 1
		if(i2[1] == 0):
			i2[1] = -1
			var playerToBuild = get_node("/root/RootNode/"+i2[0])  # [0] is the intName of that player
			for i in playerToBuild.get_children():  # Delete all previous parts
				if(i.has_method("iAmAPart")):
					i.queue_free()
			print(str(playerToBuild.objectsName)+" built as "+i2[0])
			#  The exact same code as in buildShip part in _ready with self replaced with playerToBuild
			for i in range(playerToBuild.objectsName[intName].size()):
				if(playerToBuild.objectsName[intName][i] == 1):
					tmp = fuelTank.instantiate()
					playerToBuild.add_child(tmp)
				
					tmp.isPlaced = true
					tmp.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp.position.z = -playerToBuild.objectsPos[intName][i][1]
					
					tmp2 = tmp.get_child(0)
					tmp2.reparent(playerToBuild)
					tmp2.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp2.position.z = -playerToBuild.objectsPos[intName][i][1]
					

				if(playerToBuild.objectsName[intName][i] == 2):
					tmp = ammoBox.instantiate()
					playerToBuild.add_child(tmp)
					
					tmp.isPlaced = true
					tmp.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp.position.z = -playerToBuild.objectsPos[intName][i][1]
					
					tmp2 = tmp.get_child(0)
					tmp2.reparent(playerToBuild)
					tmp2.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp2.position.z = -playerToBuild.objectsPos[intName][i][1]
					
					
				if(playerToBuild.objectsName[intName][i] == 3):
					tmp = machineGun.instantiate()
					playerToBuild.add_child(tmp)
					tmp.isPlaced = true
					tmp.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp.position.z = -playerToBuild.objectsPos[intName][i][1]
					tmp.rotation.x = -1.57
					
					tmp2 = tmp.get_child(0)
					tmp2.reparent(playerToBuild)
					tmp2.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp2.position.z = -playerToBuild.objectsPos[intName][i][1]
					
					tmp2 = tmp.get_child(1).get_child(0)
					tmp2.reparent(playerToBuild)
					tmp2.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp2.position.z = -playerToBuild.objectsPos[intName][i][1]
					tmp2.name = "|machineGun|1"
					
					
				if(playerToBuild.objectsName[intName][i] == 4):
					tmp = engine1.instantiate()
					playerToBuild.add_child(tmp)
					tmp.isPlaced = true
					tmp.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp.position.z = -playerToBuild.objectsPos[intName][i][1]
					tmp.rotation.x = -1.57
					
					tmp2 = tmp.get_child(0)
					tmp2.reparent(playerToBuild)
					tmp2.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp2.position.z = -playerToBuild.objectsPos[intName][i][1]
					
					tmp2 = tmp.get_child(1).get_child(0)
					tmp2.reparent(playerToBuild)
					tmp2.position.x = playerToBuild.objectsPos[intName][i][0]
					tmp2.position.z = -playerToBuild.objectsPos[intName][i][1]
		
	if not is_multiplayer_authority():
		if not multiplayer.is_server():
			return
			
	position.y = -3.108  # Y LOCK (2.5D)
	
	var direction = Vector3.ZERO

	if(Input.is_action_pressed("ui_right")):
		rotationY -= 1;
	if(Input.is_action_pressed("ui_left")):
		rotationY += 1;
	#if Input.is_action_pressed("ui_down"):
	#	direction.z += 1
	if Input.is_action_pressed("ui_up"):
		if(DataStorage.rocketFuelC[intName] > 0):
			direction.z -= 1
			DataStorage.rocketFuelC[intName] = (round(DataStorage.rocketFuelC[intName]*100)/100) - (0.1*DataStorage.rocketFuelUsage[intName])
	
	global_rotation = Vector3(PI * 0.01 * rotationX, PI * 0.01 * rotationY, 0)
	
	#if direction != Vector3.ZERO:
	#	direction = direction.normalized()
	
	velocity.x += (sin(global_rotation.y) * (direction.z * speed))
	velocity.z += (cos(global_rotation.y) * (direction.z * speed))
	
	if(lock):
		velocity = Vector3.ZERO

	#print(position)
	DataStorage.currentSpeed[intName] = velocity
	#velocity = target_velocity
	move_and_slide()
