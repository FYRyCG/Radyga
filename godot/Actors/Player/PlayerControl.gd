extends Node2D

export (int) var walk_speed = 200

export (int) var run_speed = 300

var player_speed = walk_speed
var velocity = Vector2()
var player

const TICK_RATE = 64

var actions = {
	"moves" : [],
	"player_speed" : 0,
	"shoots" : [],
	"drops" : [],
	"uses" : []
}  # package for network

puppet var puppet_actions = {}

func _ready():
	puppet_actions = actions
	if is_network_master():
		__bg_sender()
	else:
		__bg_receiver()
	#sender_thread.start(self, "__bg_sender")
	#receiver_thread.start(self, "__bg_receiver")
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
		actions["player_speed"] = player_speed
		
		if Input.is_action_pressed("pl_shoot") and player.get_ref() and player.get_ref().cur_weapon:
			actions["shoots"].append(OS.get_system_time_msecs())
			player.get_ref().shoot()
		
		if Input.is_action_just_pressed("pl_drop") and player.get_ref() and player.get_ref().cur_weapon:
			actions["drops"].append(OS.get_system_time_msecs())
			player.get_ref().drop_weapon()
	
		if Input.is_action_just_pressed("pl_use") and player.get_ref():
			actions["uses"].append(OS.get_system_time_msecs())
			player.get_ref().use()
		
		# TODO
		#actions["swaped_weapon"] = 
		
		move()
		actions["moves"].append([global_position, get_global_mouse_position(), player_speed])
	else:
		puppet_move()

func move():
	if (velocity.x != 0 || velocity.y != 0) and player.get_ref() and player.get_ref().has_node("AnimationPlayer"):
		player.get_ref().get_node("AnimationPlayer").get_node("AnimationTree").get("parameters/playback").travel("Walk")
	elif player.get_ref() and player.get_ref().has_node("AnimationPlayer"):
		player.get_ref().get_node("AnimationPlayer").get_node("AnimationTree").get("parameters/playback").travel("Idle")
	
	velocity = velocity.normalized() * player_speed
	velocity = player.get_ref().move_and_slide(velocity)

var target = Vector2(0,0)
var mouse = get_global_mouse_position()
func puppet_move():
	player.get_ref().look_at(mouse)
	velocity =  (target - player.get_ref().global_position).normalized() * player_speed
	if (target - player.get_ref().global_position).length() > 5:
		player.get_ref().move_and_slide(velocity)

var timer = Timer.new()
func __bg_sender():
	add_child(timer)
	timer.one_shot = false
	timer.connect("timeout", self, "__send")
	timer.start(1000.0 / (TICK_RATE * 1000.0))


func __send():
	#print("send = ", actions)
	rset_unreliable("puppet_actions", actions)
	actions["moves"] = []

var moves_thread = Thread.new()
var shoots_thread = Thread.new()
var uses_thread = Thread.new()
func __bg_receiver():
	moves_thread.start(self, "__moves", "args")
	#shoots_thread.start(self, "__shoots")
	#uses_thread.start(self, "__uses")

func __moves(kek):
	while player != null and player.get_ref():
		for move in puppet_actions["moves"]:
			target = move[0]
			mouse = move[1]
			player_speed = move[2]

		OS.delay_msec(10)
		#move()

func __shoots():
	pass

func __uses():
	pass

