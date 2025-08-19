extends Node

var objectsPos = {}
var objectsName = {}
var currentSpeed = {}

var acceleration = {}
var rocketFuelUsage = {}
var rocketFuel = {}
var ammo = {}
var rocketFuelC = {}
var ammoC = {}

var playing = false
var muteAudio = false

# Vars to use in VAB (temporary)
var objectsPosT = []
var objectsNameT = []
var accelerationT = 0
var rocketFuelUsageT = 0
var rocketFuelT = 0
var ammoT = 0
var rocketFuelCT = 0
var ammoCT = 0

var IP_ADDRESS: String = str(IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1))
const PORT: int = 42069
var peer: ENetMultiplayerPeer
var ownerIntName = 0

func start_server():
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer

func start_client(ip):
	if(len(ip) == 0):
		ip = IP_ADDRESS
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, PORT)
	multiplayer.multiplayer_peer = peer
