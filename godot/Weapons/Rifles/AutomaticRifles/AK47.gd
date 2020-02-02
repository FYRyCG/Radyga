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
	if($WeaponElements/WeaponControl.get_ammo() > 0):
		
		if(!has_node("CircleLight")):
			var bulletLight = preload("res://Objects/Lights/CircleLight.tscn").instance()
			bulletLight._color = Color.orange
			bulletLight._timer = 0.3
			#add_child(bulletLight) #Light is crap
		start_animation("Shoot")
			
func reload(add):
	$WeaponElements/WeaponControl.reload(add)
	start_animation("Reload")

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

func start_animation(animation):
	get_node("AnimationPlayer").play(animation)
