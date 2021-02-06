extends KinematicBody2D

export (int) var speed = 300 setget set_speed, get_speed
export (int) var explosion_time = 3

func start():
	$Smoke.connect("finish", self, "_exploded")
	$GrenadeBase.start(explosion_time)

func throw():
	$GrenadeBase.throw(speed)

func explosion():
	$Smoke.start()

func _exploded():
	queue_free()

func set_speed(new_speed):
	speed = new_speed

func get_speed():
	return speed

func vision_entered():
	$Smoke.visible = true
	
func vision_exited():
	$Smoke.visible = false
