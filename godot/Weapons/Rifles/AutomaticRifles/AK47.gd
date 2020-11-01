extends StaticBody

const MS = 1000.0

export (int) var rate_of_fire = 7 * MS
export (int) var damage = 33
export (int) var ammo = 30

const Cartridge = "7,62"
const Type = "primary"
const Object_type = "weapon"
const Capacity = 30

signal shoot(ammo)

func _ready():
	$WeaponElements/WeaponControl.start(damage, ammo, "res://Weapons/Rifles/RifleBullet.tscn")
	$WeaponElements/ShootDelay.wait_time = MS / rate_of_fire

func wc_call(method):
	return $WeaponElements/WeaponControl.call(method)

func get_ammo():
	return $WeaponElements/WeaponControl.get_ammo()

func shoot():
	if(get_ammo() > 0):
		$WeaponElements/WeaponControl.shoot()
		start_animation("Shoot")
		ammo = get_ammo()
		emit_signal("shoot", ammo)

func reload(add):
	$WeaponElements/WeaponControl.reload(add)
	ammo = get_ammo()
	start_animation("Reload")

func use(player):
	$WeaponElements/WeaponControl.use(player)

func take(player):
	$WeaponElements/WeaponControl.take(player)

func drop():
	$WeaponElements/WeaponControl.drop()

func get_collision():
	return $CollisionShape

func get_type():
	return Type

func get_object_type():
	return Object_type

func start_animation(animation):
	pass
