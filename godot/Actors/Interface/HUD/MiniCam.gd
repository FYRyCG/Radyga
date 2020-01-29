extends Camera2D

var Player
var Player_pos
onready var HUD = get_parent().get_parent().get_parent().get_parent().get_parent()


func _ready():
	yield(get_tree(), "idle_frame")
	Player = HUD.get_player()
	Player_pos = Player.position
	

func _process(delta):
	Player_pos = Player.position
	self.position = Player_pos
	var viewp = get_viewport()
	var img = get_viewport().get_texture().get_data()
	img.flip_y()