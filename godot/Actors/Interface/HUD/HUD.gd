extends Control

onready var tex = $Minimap/MarginContainer/TextureRect
onready var viewport = $Minimap/MarginContainer/ViewportContainer/Viewport
var player = null

func _ready():
	var map = $"/root/MapManager".get_wall_map()
	#var Map = map_manager.get_wall_map()
	viewport.world_2D = map
	
func start(player_):
	player = weakref(player_)

func get_player():
	if player and player.get_ref():
		return player.get_ref()

"""	
func _process(delta):
	tex.texture = load("res://Actors/Interface/Sprites/screenshot.png")
"""	
	
