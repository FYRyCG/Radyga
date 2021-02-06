extends KinematicBody

var speed = 210
var velocity = Vector3()

func start(start_global_transform):
	global_transform = start_global_transform
	print("rotation = ", rotation)
	velocity = Vector3(speed, 0, 0).rotated(Vector3(0, 1, 0), rotation.y)
	
func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit(20)
		queue_free()

func _on_Lifetime_timeout():
	queue_free()
	
