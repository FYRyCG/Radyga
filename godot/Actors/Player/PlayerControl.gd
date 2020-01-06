extends Node2D

export (int) var walk_speed = 200

export (int) var run_speed = 300

var player = null

var player_speed = walk_speed
var velocity = Vector2()

func _start(player_):
	player = weakref(player_)

func _physics_process(delta):
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
		
	if Input.is_action_pressed("pl_shoot") and player.get_ref():
		player.get_ref().shoot()
	
	velocity = velocity.normalized() * player_speed
		
	velocity = player.get_ref().move_and_slide(velocity)