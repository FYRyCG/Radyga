extends Control

onready var tex = $Minimap/MarginContainer/TextureRect

var player = null

func start(player_):
	player = weakref(player_)

func get_player():
	if player and player.get_ref():
		return player.get_ref()

"""	
func _process(delta):
	tex.texture = load("res://Actors/Interface/Sprites/screenshot.png")
"""	
	
