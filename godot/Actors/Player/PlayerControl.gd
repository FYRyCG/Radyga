extends Node2D

export (int) var walk_speed = 200

export (int) var run_speed = 300

var player_speed = walk_speed
var velocity = Vector2()
var player

const TICK_RATE = 64

puppet var puppet_pos = Vector2()
puppet var puppet_velocity = Vector2()
puppet var puppet_rotation = 0

func _ready():
	print(global_rotation)
	player = weakref(get_parent().get_parent())  # if it nullptr then you loh

func _physics_process(delta):
	if is_network_master():
		player.get_ref().look_at(get_global_mouse_position())
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
		
		rset("puppet_velocity", velocity)
		rset("puppet_rotation", global_rotation)
		rset("puppet_pos", global_position)
	else:
		player.get_ref().global_position = puppet_pos
		player.get_ref().global_rotation = puppet_rotation
		velocity = puppet_velocity
		
	move()
	if is_network_master():
		pass

func move():
	"""
	if (velocity.x != 0 || velocity.y != 0) and player.get_ref() and player.get_ref().has_node("AnimationPlayer"):
		player.get_ref().get_node("AnimationPlayer").get_node("AnimationTree").get("parameters/playback").travel("Walk")
	elif player.get_ref() and player.get_ref().has_node("AnimationPlayer"):
		player.get_ref().get_node("AnimationPlayer").get_node("AnimationTree").get("parameters/playback").travel("Idle")
	"""
	velocity = velocity.normalized() * player_speed
	velocity = player.get_ref().move_and_slide(velocity)

