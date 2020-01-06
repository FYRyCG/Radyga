extends KinematicBody2D

var cur_weapon = null

func _ready():
	$PlayerControl._start(self)
	
	var w = load("res://Weapons/Rifles/AutomaticRifles/BaseAutoRifles.tscn").instance()
	take_weapon(w)
	
func take_weapon(weapon_):
	cur_weapon = weakref(weapon_)
	weapon_.start(self)
	add_child(weapon_)
	
func shoot():
	if cur_weapon.get_ref():
		cur_weapon.get_ref().shoot($Muzzle.global_position, rotation)