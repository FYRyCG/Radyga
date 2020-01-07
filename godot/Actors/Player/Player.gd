extends KinematicBody2D

var cur_weapon = null

func _ready():
	$PlayerControl._start(self)
	
	var w = load("res://Weapons/Rifles/AutomaticRifles/Types/M4.tscn").instance()
	take_weapon(w)
	
func take_weapon(weapon_):
	cur_weapon = weakref(weapon_)
	weapon_.start(self)
	
	add_child(weapon_)  #spawn on player or map
	
	# set weapon collision shape
	var weapon_collision = weapon_.get_collision()
	$WeaponCollision.shape = weapon_collision.shape
	$WeaponCollision.position = weapon_.position
	

func shoot():
	if cur_weapon.get_ref():
		cur_weapon.get_ref().shoot()