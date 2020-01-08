extends Node2D

export (int) var walk_speed = 200

export (int) var run_speed = 300

var player = null

var player_speed = walk_speed
var velocity = Vector2()

func _start(player_):
	player = weakref(player_)

func _physics_process(delta):
	# Плавный поворот player'a + отключение лишнего движения при поворотах
	var angle_dif_by_mouse = player.get_ref().get_angle_to(get_global_mouse_position())
	var rt = 5.0 # rotation_threshold
	if(angle_dif_by_mouse != 0):
		var new_rotation = player.get_ref().rotation_degrees + angle_dif_by_mouse*10.0
		var collision = player.get_ref().test_move( Transform2D (new_rotation, player.get_ref().position),
		 Vector2(rt * 1.0,0.0)) || player.get_ref().test_move( Transform2D (new_rotation, player.get_ref().position),
		 Vector2(rt * 1.0,rt * 1.0)) || player.get_ref().test_move( Transform2D (new_rotation, player.get_ref().position),
		 Vector2(-1.0 * rt,0.0)) || player.get_ref().test_move( Transform2D (new_rotation, player.get_ref().position),
		 Vector2(-1.0 * rt,1.0 * rt)) || player.get_ref().test_move( Transform2D (new_rotation, player.get_ref().position),
		 Vector2(0.0,1.0 * rt)) || player.get_ref().test_move( Transform2D (new_rotation, player.get_ref().position),
		 Vector2(0.0,-1.0 * rt)) || player.get_ref().test_move( Transform2D (new_rotation, player.get_ref().position),
		 Vector2(-1.0 * rt,-1.0 * rt)) || player.get_ref().test_move( Transform2D (new_rotation, player.get_ref().position),
		 Vector2(1.0 * rt,-1.0 * rt))
		print(collision)
		if(!collision):
			player.get_ref().rotation_degrees = new_rotation
	# Старый вариант:
	#player.get_ref().look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if Input.is_action_just_pressed("pl_run"):
		player_speed = run_speed
	if Input.is_action_just_released("pl_run"):
		player_speed = walk_speed
		
	if Input.is_action_pressed("pl_shoot") and player.get_ref() and player.get_ref().cur_weapon:
		player.get_ref().shoot()
	
	if Input.is_action_just_pressed("pl_drop") and player.get_ref() and player.get_ref().cur_weapon:
		player.get_ref().drop_weapon()
	
	if Input.is_action_just_pressed("pl_use") and player.get_ref():
		player.get_ref().use()
		
	velocity = velocity.normalized() * player_speed
	velocity = player.get_ref().move_and_slide(velocity)