extends KinematicBody2D

export (int) var speed = 300 setget set_speed, get_speed
export (int) var damage = 67 setget set_damage, get_damage

var remain_speed_factor = 1.0  # maybe
var stop_force = 0.6 # начальная сила зависит от оперативника, и силы броска

var velocity = Vector2()
var stop_velovity = Vector2()

var throws = false

func _ready():
	set_physics_process(false)
	set_process(false)

func start():
	set_physics_process(false)
	set_process(false)
	$ExplosionTimer.start()

func throw():
	var pl = get_parent()
	pl.remove_child(self)
	global_position = pl.get_global_position()
	global_rotation = pl.get_global_rotation()
	pl.get_parent().add_child(self)
	
	velocity = Vector2(speed, 0).rotated(rotation)
	stop_velovity = Vector2(stop_force, 0).rotated(rotation)
	set_physics_process(true)

func cancel():
	queue_free()

func explosion():
	for inc in range(11):
		call_deferred("set_damage", damage / 10.0 * inc)
		$ExplosionArea.set_deferred("scale", Vector2(0.1, 0.1) * inc)
		OS.delay_msec(10)

func _physics_process(delta):
	#print("process ")
	var collision = move_and_collide(velocity * delta * remain_speed_factor)
	if collision:
		velocity = velocity.bounce(collision.normal)
		stop_force += 0.4
		
	if remain_speed_factor != 0:	
		remain_speed_factor -= stop_force * delta
		if remain_speed_factor < 0:
			remain_speed_factor = 0


var explosion_thread = Thread.new()
func _on_ExplosionTimer_timeout():
	set_physics_process(false)
	remain_speed_factor = 0  # fix bug with throwing explosion
	
	$Sprite.hide()
	$ExplosionSprites.show()
	$ExplosionSprites.play("explosion")
	
	explosion_thread.start(self, "explosion")

func _on_ExplosionSprites_animation_finished():
	queue_free()

func _on_ExplosionArea_body_entered(body):
	if body.has_method("explosion_hit"):
		body.call("explosion_hit")

func set_speed(new_speed):
	speed = new_speed

func get_speed():
	return speed

func set_damage(new_damage):
	damage = new_damage
	
func get_damage():
	return damage

