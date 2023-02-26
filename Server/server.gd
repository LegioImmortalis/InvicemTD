extends Node

const Client = preload("res://dummyclient.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

func _unhandled_input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _ready():	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)

func add_player(peer_id):
	var client = Client.instantiate()
	client.name = str(peer_id)
	add_child(client)
	if client.is_multiplayer_authority():
		pass

func remove_player(peer_id):
	var client = get_node_or_null(str(peer_id))
	if client:
		client.queue_free()

func _on_multiplayer_spawner_spawned(node):
	if node.is_multiplayer_authority():
		pass
