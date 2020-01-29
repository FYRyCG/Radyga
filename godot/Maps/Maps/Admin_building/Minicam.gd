extends Camera2D

onready var Players= $"/root/World/Players"
var Player
var Player_pos
onready var HUD = $"/root/World/CanvasLayer/Hud/Minimap/MarginContainer/TextureRect"

func _ready():
	yield(get_tree(), "idle_frame")
	print(Players.name)
	Players = Players.get_children()
	for elem in Players:
		if elem.name == "1":
			Player = elem
	Player_pos = Player.position

func _process(delta):
	Player_pos = Player.position
	print(self.position) 
	self.position = Player_pos
	var viewp = get_viewport()
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	HUD.texture = img
	
	#yield(get_tree(), "idle_frame")
	#yield(get_tree(), "idle_frame")
	#img.save_png("res://Actors/Interface/Sprites/screenshot.png")