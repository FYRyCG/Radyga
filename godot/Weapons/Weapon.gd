extends Node2D

var Bullet = preload("res://Weapons/Rifles/RifleBullet.tscn")

var player = null

var can_shoot = true

func _ready():
	$WeaponElements/ShootDelay.connect("timeout", self, "_on_ShootDelay_timeout")	
	set_physics_process(false)
	set_process(false)

func take(player_):
	player = weakref(player_)
	#set_physics_process(true)
	set_process(true)

remotesync func set_pl(pl_path):
	player = weakref(get_tree().get_root().get_node(pl_path))

func drop():
	player = null
	#set_physics_process(false)
	set_process(false)

func _process(delta):
	if player and player.get_ref():
		position = player.get_ref().get_weapon_position().global_position
		rotation = player.get_ref().get_weapon_position().global_rotation

func shoot():
	if can_shoot:
		can_shoot = false
		get_node("WeaponElements/ShootDelay").start()
		rpc("sync_shoot", $WeaponElements/Muzzle.global_position, global_rotation)

remotesync func sync_shoot(shoot_position, shoot_rotation):
	$WeaponElements.shoot()  # draw sprite
	var bullet = Bullet.instance()
	bullet.start(shoot_position, shoot_rotation)
	get_parent().get_parent().get_parent().add_child(bullet)

func _on_ShootDelay_timeout():
	can_shoot = true
	
func use(player):
	rpc("sync_use", player.get_path())

remotesync func sync_use(player_path):
	get_tree().get_root().get_node(player_path).take_weapon(self)
	
func get_collision():
	return $CollisionShape2D
	
	
