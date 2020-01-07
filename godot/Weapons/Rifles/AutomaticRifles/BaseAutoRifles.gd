extends Node2D

var Bullet = preload("res://Weapons/Rifles/RifleBullet.tscn")

var player = null

var can_shoot = true

func _ready():
	set_physics_process(false)
	set_process(false)

func take(pl):
	player = weakref(pl)
	set_physics_process(true)
	set_process(true)

func drop():
	player = null
	set_physics_process(false)
	set_process(false)

func _process(delta):
	if player and player.get_ref():
		get_parent().position = player.get_ref().get_node("GunPos").global_position
		get_parent().rotation = player.get_ref().get_node("GunPos").global_rotation

func shoot(pos, dir):
	print("can = ", can_shoot)
	if can_shoot:
		can_shoot = false
		print(get_parent().get_node("ShootDelay"))
		get_parent().get_node("ShootDelay").start()
		
		var bullet = Bullet.instance()
		bullet.start(pos, dir)
		
		# spawn on Map for remove rotation with player
		get_parent().get_parent().get_parent().get_parent().add_child(bullet)  

func _on_ShootDelay_timeout():
	can_shoot = true
	
func use(player, body):
	print("take base")
	player.take_weapon(body)  # send weapon
