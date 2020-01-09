extends Camera2D

var player = null

func _ready():
	set_physics_process(false)
	set_process(false)
	make_current()

func set_player(player_):
	player = weakref(player_)
	zoom = Vector2(0.5, 0.5)
	set_physics_process(true)

func _physics_process(delta):
	if player.get_ref():
		position = player.get_ref().position
