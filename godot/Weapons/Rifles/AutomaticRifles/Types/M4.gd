extends "res://Weapons/Weapon.gd"

const MS = 1000

export (int) var rate_of_fire = 15 * MS

export (int) var damage = 29

func _ready():
	$ShootDelay.wait_time = MS / rate_of_fire

