extends StaticBody2D

const MS = 1000.0

export (int) var rate_of_fire = 7 * MS
export (int) var damage = 33
export (int) var start_capacity = 30

const Cartridge = "7,62"
const Type = "primary"
const Object_type = "weapon"
const Capacity = 30

func _ready():
	$WeaponElements/WeaponControl.start(damage, start_capacity, "res://Weapons/Rifles/RifleBullet.tscn")
	$WeaponElements/ShootDelay.wait_time = MS / rate_of_fire

func my_call(method):
	return $WeaponElements/WeaponControl.call(method)

func shoot():
	$WeaponElements/WeaponControl.shoot()

func reload(add):
	$WeaponElements/WeaponControl.reload(add)

func use(player):
	$WeaponElements/WeaponControl.use(player)

func take(player):
	$WeaponElements/WeaponControl.take(player)

func drop():
	$WeaponElements/WeaponControl.drop()

func get_collision():
	return $CollisionShape2D

func get_type():
	return Type

func get_object_type():
	return Object_type
