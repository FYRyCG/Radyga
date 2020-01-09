extends Node2D

var player = preload("res://Actors/Operators/Recruit/Recruit.tscn")
#var player = preload("res://Actors/Operators/MemeRecruitForExample.tscn")

var players = {
	1 : "name"
}

func _ready():
	pass
	"""
	for pl in players:
		var p = player.instance()
		var sp = $MapManager.get_next_spawn_position()
		p.position = sp.global_position
		$Players.add_child(p)
		
		if pl == 1:
			$Camera.set_player(p)
	"""