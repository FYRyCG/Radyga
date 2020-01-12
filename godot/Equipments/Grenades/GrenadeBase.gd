extends Node2D

var remain_speed_factor = 1.0  # maybe
var stop_force = 0.6 # начальная сила зависит от оперативника, и силы броска

var velocity = Vector2()
var stop_velovity = Vector2()

var throws = false

func _ready():
	get_parent().set_physics_process(false)
	get_parent().set_process(false)

func start(explosion_time : int):
	$ExplosionTimer.wait_time = explosion_time
	
	get_parent().set_physics_process(false)
	get_parent().set_process(false)
	$ExplosionTimer.start()

func throw(speed):
	var pl = get_parent().get_parent()
	pl.remove_child(get_parent())
	
	get_parent().global_position = pl.get_global_position()
	get_parent().global_rotation = pl.get_global_rotation()
	pl.get_parent().add_child(get_parent())
	
	velocity = Vector2(speed, 0).rotated(get_parent().rotation)
	stop_velovity = Vector2(stop_force, 0).rotated(get_parent().rotation)
	get_parent().set_physics_process(true)

func cancel():
	get_parent().queue_free()

func _physics_process(delta):
	var collision = get_parent().move_and_collide(velocity * delta * remain_speed_factor)
	if collision:
		velocity = velocity.bounce(collision.normal)
		stop_force += 0.4
		
	if remain_speed_factor != 0:	
		remain_speed_factor -= stop_force * delta
		if remain_speed_factor < 0:
			remain_speed_factor = 0

func _on_ExplosionTimer_timeout():
	get_parent().set_physics_process(false)
	remain_speed_factor = 0  # fix bug with throwing explosion
	get_parent().call("explosion")
