extends Node

var maps = {

	"MapLobby" : "res://MapManager/Maps/Lobby/MapLobby.tscn"
}

var map_name = ""

#var current_map = preload("res://Maps/Maps/SimpleMap.tscn").instance()
var current_map = weakref(\
	preload("res://MapManager/Maps/Lobby/MapLobby.tscn").instance())  #Мапа Санька
	
var spawn_positions = []
var next_spawn_position = 0

func _ready():
	pass

func set_map(name):
	map_name = name

func get_map_name():
	return map_name

func load_selected_map():
	load_map(maps[map_name])

func load_map(map):
	print("!!!")
	print(map)
	if current_map.get_ref():
		current_map.get_ref().queue_free()
		
	spawn_positions = []
	next_spawn_position = 0
	
	current_map = weakref(load(map).instance())
	get_tree().get_root().get_node("World/Map").add_child(current_map.get_ref())
	if current_map().has_node("SpawnPositions"):
		for sp in current_map().get_node("SpawnPositions").get_children():
			spawn_positions.append(sp)


func get_next_spawn_position():
	if next_spawn_position < spawn_positions.size():
		var spawn_pos = spawn_positions[next_spawn_position]
		next_spawn_position += 1
		return spawn_pos


func get_wall_map():
	if current_map().has_node("WallMap"):
		return current_map().get_node("WallMap")
	else:
		return TileMap.new()


func spawn_player(p_id, operative_scene):
	var spawn_pos = get_next_spawn_position()
	print("spawn = ", operative_scene)
	var player = load(operative_scene).instance()

	player.set_name(str(p_id)) # Use unique ID as node name
	#player.position = spawn_pos.position (2D engine)
	player.translation = spawn_pos.translation
	
	
	player.set_network_master(p_id) #set unique id as master

	if p_id == get_tree().get_network_unique_id():
		pass
		# If node for this peer id, set name
		#player.set_player_name(player_name)
	else:
		pass
		# Otherwise set name from peer
		#player.set_player_name(players[p_id])

	current_map().add_child(player)

func current_map():
	return current_map.get_ref()
	
func build_path(point_a, point_b) -> Line2D:
	var navigation = current_map.get_ref().get_navigation()
	var line_2d = Line2D.new()
	line_2d.points = navigation.get_simple_path(point_a, point_b)
	return line_2d
	
func get_patrol_point(current_index):
	return current_map.get_ref().get_patrol_point(current_index)
