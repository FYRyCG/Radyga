extends KinematicBody2D

export (int) var speed = 300 setget set_speed, get_speed
export (int) var damage = 67
export (int) var explosion_time = 2

func start():
	$GrenadeBase.start(explosion_time)

func throw():
	$GrenadeBase.throw(speed)

var explosion_thread = Thread.new()
func explosion():
	explosion_thread.start(self, "_bg_explosion", null)

func _bg_explosion(args):
	$Sprite.call("hide")
	$ExplosionSprites.call("show")
	$ExplosionSprites.call("play", "explosion")
	
	for inc in range(11):
		call_deferred("set_damage", damage / 10.0 * inc)
		$ExplosionArea.set_deferred("scale", Vector2(0.1, 0.1) * inc)
		OS.delay_msec(15)
	call_deferred("_exploded")

func _exploded():
	explosion_thread.wait_to_finish()
	queue_free()

func _on_ExplosionArea_body_entered(body):
	if body.has_method("explosion_hit"):
		body.call("explosion_hit")

func set_speed(new_speed):
	speed = new_speed

func get_speed():
	return speed

