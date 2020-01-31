extends Node2D

# Я не совсем понимаю как работает физика для гранат,
# но она пока что работает как надо, 

# уменьшается со временем уменьшая скорость гранаты
var remain_speed_factor = 1.0
# если ее поменять, то граната не будет долетать до цели
var stop_force = 0.47 

var velocity = Vector2()

var throws = false
var target_position = Vector2()


func _ready():
	get_parent().set_physics_process(false)
	get_parent().set_process(false)

func start(explosion_time : int):
	$ExplosionTimer.wait_time = explosion_time
	$ExplosionTimer.start(explosion_time)
	
	get_parent().set_physics_process(false)
	get_parent().set_process(false)

func throw(speed):
	target_position = get_global_mouse_position()
	var pl = get_parent().get_parent()
	pl.remove_child(get_parent())
	
	get_parent().global_position = pl.get_global_position()
	get_parent().global_rotation = pl.get_global_rotation()
	pl.get_parent().add_child(get_parent())
	
	var leng = (target_position - get_parent().global_position).length()
	velocity = Vector2(leng, 0).rotated(get_parent().rotation)
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
	remain_speed_factor = 0  # fixed bug with throwing explosion
	get_parent().call("explosion")
