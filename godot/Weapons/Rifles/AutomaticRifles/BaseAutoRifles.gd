extends Node2D

var Bullet = preload("res://Weapons/Rifles/RifleBullet.tscn")

var player = null

var can_shoot = true

func start(pl):
	player = weakref(pl)


func shoot(pos, dir):
	if can_shoot:
		can_shoot = false
		$ShootDelay.start()
		
		var bullet = Bullet.instance()
		bullet.start(pos, dir)
		get_parent().get_parent().add_child(bullet)  # spawn on Map for remove rotation with player

func _on_ShootDelay_timeout():
	can_shoot = true
