extends Camera2D

var player_pos
onready var HUD = get_parent().get_parent().get_parent().get_parent().get_parent()

func _ready():
	set_process(false)

func start():
	set_process(true)

func _process(delta):
	global_position = HUD.get_player().global_position
