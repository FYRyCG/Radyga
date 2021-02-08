extends Camera

var player: WeakRef = null

func _ready():
	set_physics_process(false)
	set_process(false)
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	translation = Properties.get("player.camera.translation")
	rotation_degrees = Properties.get("player.camera.rotation")
	
	if is_network_master():
		make_current()

func set_player(player_):
	player = weakref(player_)
	#zoom = Vector3(0.5, 0.5, 0.5)
	make_current()
	
	set_physics_process(true)

func set_cull_mask(floor_id):
	var mask_status = get_cull_mask_bit(floor_id)
	set_cull_mask_bit(floor_id, !mask_status)
