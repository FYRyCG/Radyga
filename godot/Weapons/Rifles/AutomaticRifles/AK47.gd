extends StaticBody2D

const MS = 1000.0

export (int) var rate_of_fire = 9 * MS
export (int) var damage = 33

const Cartridge = "7,62"
const Weapon_type = "primary"
const Object_type = "weapon"

var ammo_left = 30

func _ready():
	add_child(preload("res://Weapons/WeaponControl.tscn").instance())
	$WeaponControl.start()
	$WeaponElements/ShootDelay.wait_time = MS / rate_of_fire

func get_weapon_type():
	return Weapon_type

func get_object_type():
	return Object_type
