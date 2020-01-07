extends "res://Weapons/Weapon.gd"

const MS = 1000

export (int) var rate_of_fire = 10 * MS

export (int) var damage = 33

func _ready():
	$ShootDelay.wait_time = MS / rate_of_fire
