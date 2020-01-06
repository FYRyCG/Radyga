extends Node2D

var current_map = preload("res://Maps/Maps/SimpleMap.tscn").instance()
#var current_map = preload("res://Maps/Maps/SimpleMap.tscn").instance()  #Мапа Санька

var spawn_positions = []
var next_spawn_position = 0

func _ready():
	add_child(current_map)
	if current_map.has_node("SpawnPositions"):
		for sp in current_map.get_node("SpawnPositions").get_children():
			spawn_positions.append(sp)
			
func get_next_spawn_position():
	if next_spawn_position < spawn_positions.size():
		var spawn_pos = spawn_positions[next_spawn_position]
		next_spawn_position += 1
		return spawn_pos