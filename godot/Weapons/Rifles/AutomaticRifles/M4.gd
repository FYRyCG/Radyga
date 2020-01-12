extends StaticBody2D

const MS = 1000.0

export (int) var rate_of_fire = 11 * MS
export (int) var damage = 29

const Cartridge = "5,56"

var ammo_left = 30

func _ready():
	add_child(preload("res://Weapons/WeaponControl.tscn").instance())
	$WeaponControl.start()
	$WeaponElements/ShootDelay.wait_time = MS / rate_of_fire
