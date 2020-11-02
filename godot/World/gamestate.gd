extends Node

# Default game port
const DEFAULT_PORT = 10567

# Max number of players
const MAX_PEERS = 5

# Name for my player
var player_name = "The Warrior"
var player_icon = "res://Resources/Icons/icon1.png"

# Names for remote players 
var players = {}
var operatives_selected = {}

# Signals to let lobby GUI know what's going on
signal player_list_changed()
signal connection_failed()
signal connection_succeeded()
signal game_ended()
signal game_error(what)

# Callback from SceneTree
func _player_connected(id):
	# Registration of a client beings here, tell the connected player that we are here
	print("pl icon = ", player_icon)
	rpc_id(id, "register_player", player_name, player_icon)

# Callback from SceneTree
func _player_disconnected(id):
	print("dis = ", id)
	if has_node("/root/world"): # Game is in progress
		if get_tree().is_network_server():
			emit_signal("game_error", "Player " + players[id] + " disconnected")
			end_game()
	unregister_player(id)
	

# Callback from SceneTree, only for clients (not server)
func _connected_ok():
	# We just connected to a server
	emit_signal("connection_succeeded")

# Callback from SceneTree, only for clients (not server)
func _server_disconnected():
	emit_signal("game_error", "Server disconnected")
	end_game()

# Callback from SceneTree, only for clients (not server)
func _connected_fail():
	get_tree().set_network_peer(null) # Remove peer
	emit_signal("connection_failed")

# Lobby management functions
remote func register_player(new_player_name, player_icon):
	var id = get_tree().get_rpc_sender_id()
	print("Connected id = ", id)
	players[id] = {
			"name" : new_player_name,
			"icon" : player_icon,
		}
	emit_signal("player_list_changed")

func unregister_player(id):
	players.erase(id)
	emit_signal("player_list_changed")

remote func pre_start_game(spawn_points, map):
	# Change scene
	var world = load("res://World/World.tscn").instance()
	get_tree().get_root().add_child(world)

	get_tree().get_root().get_node("MainMenu").hide()

	MapManager.load_selected_map()
	#get_tree().get_root().get_node("lobby").hide()
	
	for p_id in spawn_points:
		var operative = null
		if operatives_selected.has(p_id):
			operative = OperativesManager.get_operative_by_name(operatives_selected[p_id])
		else:
			operative = "res://Actors/Operators/Recruit/Recruit.tscn"
			
		MapManager.spawn_player(p_id, operative)

	if not get_tree().is_network_server():
		# Tell server we are ready to start
		rpc_id(1, "ready_to_start", get_tree().get_network_unique_id())
	elif players.size() == 0:
		post_start_game()

remote func post_start_game():
	get_tree().set_pause(false) # Unpause and unleash the game!

var players_ready = []

remote func ready_to_start(id):
	assert(get_tree().is_network_server())

	if not id in players_ready:
		players_ready.append(id)

	if players_ready.size() == players.size():
		for p in players:
			rpc_id(p, "post_start_game")
		post_start_game()

func host_game(new_player_name):
	player_name = new_player_name
	var host = NetworkedMultiplayerENet.new()
	host.create_server(DEFAULT_PORT, MAX_PEERS)
	get_tree().set_network_peer(host)

func join_game(ip, new_player_name, icon):
	# Так как перед подключение он был уже хостом
	print("joining")
	get_tree().set_network_peer(null) # End networking
	
	print("join to ", ip)
	
	player_name = new_player_name
	player_icon = icon
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)

func disconnect_game():
	players.clear()
	emit_signal("player_list_changed")
	get_tree().set_network_peer(null) # End networking

func get_player_list():
	return players.values()

func get_player_name():
	return player_name

func get_player_icon():
	return player_icon
	
func change_icon(icon):
	player_icon = icon

remotesync func operative_selected(p_id, name):
	operatives_selected[p_id] = name
	
func begin_game():
	assert(get_tree().is_network_server())

	var map = MapManager.get_map_name()

	# Create a dictionary with peer id and respective spawn points, could be improved by randomizing
	var spawn_points = {}
	spawn_points[1] = 0 # Server in spawn point 0
	var spawn_point_idx = 1
	for p in players:
		spawn_points[p] = spawn_point_idx
		spawn_point_idx += 1
	# Call to pre-start game with the spawn points
	for p in players:
		#map - та карта на которой начинается игра
		rpc_id(p, "pre_start_game", spawn_points, map)

	pre_start_game(spawn_points, map)

func end_game():
	if has_node("/root/World"): # Game is in progress
		# End it
		get_node("/root/World").queue_free()
		
	disconnect_game()
	emit_signal("game_ended")

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
