extends Node

func _ready():
	$ShootSprite.transform = $Muzzle.transform

func shoot():
	$ShootSprite.show()
	$ShootSprite/Lifetime.start()

func _on_Lifetime_timeout():
	$ShootSprite.hide()
	
func get_shoot_transform():
	return $Muzzle.transform
