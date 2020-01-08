extends Node2D

export (int) var walk_speed = 200

export (int) var run_speed = 300

var pawn = null
var prev_direction = Vector2()
var pawn_speed = walk_speed
var velocity = Vector2()

func _start(pawn_):
	pawn = weakref(pawn_)

func _physics_process(delta):
	velocity = Vector2()
	if(prev_direction.y == -1):
		velocity.y = 1
	else:
		velocity.y = -1
	prev_direction.y = velocity.y
	velocity = velocity.normalized() * pawn_speed
	velocity = pawn.get_ref().move_and_slide(velocity)