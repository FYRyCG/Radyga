extends KinematicBody2D

var speed = 1000
var velocity = Vector2()

func start(position_, rotation_):
	rotation = rotation_
	position = position_
	velocity = Vector2(speed, 0).rotated(rotation)
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_Lifetime_timeout():
	queue_free()
