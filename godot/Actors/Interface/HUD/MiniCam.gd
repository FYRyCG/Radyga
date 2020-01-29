extends Camera2D

var player_pos
onready var HUD = get_parent().get_parent().get_parent().get_parent().get_parent()

func _ready():
	yield(get_tree(), "idle_frame")
	player_pos = HUD.get_player().global_position

func _process(delta):
	global_position = HUD.get_player().global_position