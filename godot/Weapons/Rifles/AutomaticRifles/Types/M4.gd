extends "res://Weapons/WeaponInterface.gd"

const MS = 1000

export (int) var rate_of_fire = 15 * MS

export (int) var damage = 29

func _ready():
	$ShootDelay.connect("timeout", $BaseAutoRifles, "_on_ShootDelay_timeout")
	$ShootDelay.wait_time = MS / rate_of_fire

