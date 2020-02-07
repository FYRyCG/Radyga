extends Node2D

var maps = {
	"Simple" : "res://Maps/Maps/SimpleMap.tscn",
	"Build" : "res://Maps/Maps/Admin_building/Admin_building.tscn"
}

#var current_map = preload("res://Maps/Maps/SimpleMap.tscn").instance()
var current_map = preload("res://Maps/Maps/Admin_building/Admin_building.tscn").instance()  #Мапа Санька
var spawn_positions = []
var next_spawn_position = 0
#var current_map

func _ready():
	pass
	"""
	add_child(current_map)
	if current_map.has_node("SpawnPositions"):
		for sp in current_map.get_node("SpawnPositions").get_children():
			spawn_positions.append(sp)
	"""

func set_map(name):
	load_map(maps[name])

func load_map(map):
	current_map.queue_free()
	spawn_positions = []
	current_map = load(map).instance()
	add_child(current_map)
	if current_map.has_node("SpawnPositions"):
		for sp in current_map.get_node("SpawnPositions").get_children():
			spawn_positions.append(sp)


func get_next_spawn_position():
	if next_spawn_position < spawn_positions.size():
		var spawn_pos = spawn_positions[next_spawn_position]
		next_spawn_position += 1
		return spawn_pos


func get_wall_map():
	if current_map.has_node("WallMap"):
		return current_map.get_node("WallMap")
	else:
		return TileMap.new()


func spawn_player(p_id, operator_scene):
	var spawn_pos = get_next_spawn_position()
		
	var player = operator_scene.instance()

	player.set_name(str(p_id)) # Use unique ID as node name
	player.position = spawn_pos.position
	player.set_network_master(p_id) #set unique id as master

	if p_id == get_tree().get_network_unique_id():
		pass
		# If node for this peer id, set name
		#player.set_player_name(player_name)
	else:
		pass
		# Otherwise set name from peer
		#player.set_player_name(players[p_id])

	current_map.add_child(player)
