extends Control

onready var viewport = $Minimap/MarginContainer/ViewportContainer/Viewport

var player = null

func _ready():
	viewport.add_child(MapManager.get_wall_map().duplicate())

	
func start(player_):
	player = weakref(player_)
	$Minimap/MarginContainer/ViewportContainer/Viewport/MiniCam.start()

func get_player():
	if player and player.get_ref():
		return player.get_ref()

"""	
func _process(delta):
	tex.texture = load("res://Actors/Interface/Sprites/screenshot.png")
"""	
	
