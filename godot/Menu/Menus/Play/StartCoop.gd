extends Control

var defaulttMap = "MapLobby"
var defaultOperativ = "Recruit"

func _ready():
	MapManager.set_map(defaulttMap)
	
	gamestate.rpc("operative_selected",
					 get_tree().get_network_unique_id(),
					 defaultOperativ)

	queue_free()
	gamestate.begin_game()
