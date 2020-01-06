extends KinematicBody2D

var cur_weapon = null

func _ready():
	$PlayerControl._start(self)
	
	var w = load("res://Weapons/Rifles/AutomaticRifles/Types/M4.tscn").instance()
	take_weapon(w)
	
func take_weapon(weapon_):
	cur_weapon = weakref(weapon_)
	weapon_.start(self)
	
	print("spawn weapon = ", get_path())
	add_child(weapon_)  #spawn on player or map
	
	# todo Надо будет установить позицию Muzzle в соответсвтвии с длиной оружия
	
func shoot():
	if cur_weapon.get_ref():
		cur_weapon.get_ref().shoot()