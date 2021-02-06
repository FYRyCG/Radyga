extends Camera

export (int) var slide_speed = 50
export (int) var distance_slide = 100
var player = null
func _ready():
	set_physics_process(false)
	set_process(false)
	if is_network_master():
		make_current()
	
	


func set_player(player_):
	player = weakref(player_)
	#zoom = Vector3(0.5, 0.5, 0.5)
	make_current()
	
	set_physics_process(true)

func get_camera_pos(pos_num):
	if(pos_num == 0):
		return get_parent().get_node("Camera_pos1").get_transform()
	if(pos_num == 1):
		return get_parent().get_node("Camera_pos2").get_transform()
	if(pos_num == 2):
		return get_parent().get_node("Camera_pos3").get_transform()
	if(pos_num == 3):
		return get_parent().get_node("Camera_pos4").get_transform()		
		
func _physics_process(delta):
	"""
	if(Input.is_action_just_pressed("MoveCameraClockwards")):
		position += 1
		position = (position + 4) % 4
		transform = get_camera_pos(position)
	if(Input.is_action_just_pressed("MoveCameraBackwards")):
		position -= 1
		position = (position + 4) % 4
		transform = get_camera_pos(position)
	if player.get_ref():
		global_position = player.get_ref().global_position
	
	var pl_pos = player.get_ref().global_position
	var mouse_pos = get_global_mouse_position()
	var vec = pl_pos - mouse_pos
	var def_size = get_viewport().size / 5
	def_size.y = get_viewport().size.y / 6
	var offset_ = Vector2(0, 0)
	
	
	if abs(vec.x) - abs(def_size.x) > 0:
		offset_.x = min(distance_slide, max(0, abs(vec.x) - abs(def_size.x))) * -sign(vec.x)
	if abs(vec.y) - abs(def_size.y) > 0:
		offset_.y = min(distance_slide, max(0, abs(vec.y) - abs(def_size.y))) * -sign(vec.y)
	slide_camera(get_offset(), offset_)
	"""

var offset_vector = Vector2()
func slide_camera(old, new):
	var vec = (new - old) * get_process_delta_time() * slide_speed
	offset_vector += vec
	#set_offset(offset_vector)
	
func set_cull_mask(floor_id):
	var mask_status = get_cull_mask_bit(floor_id)
	set_cull_mask_bit(floor_id, !mask_status)
