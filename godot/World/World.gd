extends Node2D

var player = preload("res://Actors/Player/Player.tscn")

#var map = preload("res://Maps/SimpleMap.tscn").instance()
var map = preload("res://Maps/Admin_buildong.tscn").instance()

var players = {
	1 : "name"
}

var spawn_positions = []
var next_spawn_position = 0

func _ready():
	$Map.add_child(map)
	
	if map.has_node("SpawnPositions"):
		for sp in map.get_node("SpawnPositions").get_children():
			spawn_positions.append(sp)
		
	for pl in players:
		var p = player.instance()
		var sp = get_next_spawn_position()
		p.position = sp.global_position
		$Players.add_child(p)
		
		if pl == 1:
			$Camera.set_player(p)

func get_next_spawn_position():
	if next_spawn_position < spawn_positions.size():
		var spawn_pos = spawn_positions[next_spawn_position]
		next_spawn_position += 1
		return spawn_pos