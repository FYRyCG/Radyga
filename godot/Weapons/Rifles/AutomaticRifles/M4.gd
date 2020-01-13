extends StaticBody2D

const MS = 1000.0

export (int) var rate_of_fire = 14 * MS
export (int) var damage = 29

const Cartridge = "5,56"
const Weapon_type = "secondary"
const Object_type = "weapon"
const start_ammo = 30

func _ready():
	$WeaponElements/WeaponControl.start(damage, start_ammo, "res://Weapons/Rifles/RifleBullet.tscn")
	$WeaponElements/ShootDelay.wait_time = MS / rate_of_fire
 
func shoot():
	$WeaponElements/WeaponControl.shoot()

func use(player):
	$WeaponElements/WeaponControl.use(player)

func take(player):
	$WeaponElements/WeaponControl.take(player)

func drop():
	$WeaponElements/WeaponControl.drop()
	
func get_collision():
	return $CollisionShape2D

func get_weapon_type():
	return Weapon_type

func get_object_type():
	return Object_type
