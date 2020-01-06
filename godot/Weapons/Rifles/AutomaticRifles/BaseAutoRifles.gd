extends Node2D

var Bullet = preload("res://Weapons/Rifles/RifleBullet.tscn")

var player = null

var can_shoot = true

func start(pl):
	player = weakref(pl)
	position = player.get_ref().get_node("GunPos").position

func shoot(pos, dir):
	if can_shoot:
		can_shoot = false
		$ShootDelay.start()
		
		var bullet = Bullet.instance()
		bullet.start(pos, dir)
		
		# spawn on Map for remove rotation with player
		get_parent().get_parent().get_parent().get_parent().add_child(bullet)  

func _on_ShootDelay_timeout():
	can_shoot = true
