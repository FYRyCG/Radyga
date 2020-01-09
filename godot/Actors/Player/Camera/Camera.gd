extends Camera2D

var player = null

func _ready():
	make_current()

func set_player(player_):
	print(player_)
	player = weakref(player_)
	zoom = Vector2(0.5, 0.5)

func _physics_process(delta):
	if player.get_ref():
		position = player.get_ref().position
