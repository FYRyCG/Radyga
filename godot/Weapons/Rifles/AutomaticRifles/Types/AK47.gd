extends "res://Weapons/Weapon.gd"

const MS = 1000.0

export (int) var rate_of_fire = 8 * MS

export (int) var damage = 33

func _ready():
	$WeaponElements/ShootDelay.wait_time = MS / rate_of_fire
