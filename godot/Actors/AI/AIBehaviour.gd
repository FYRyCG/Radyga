extends Node2D

export (int) var walk_speed = 200

export (int) var run_speed = 300

var pawn = null
var pawn_speed = walk_speed
var velocity = Vector2()

func _start(pawn_):
	pawn = weakref(pawn_)

func _physics_process(delta):
	velocity = Vector2()
	velocity = velocity.normalized() * pawn_speed
	velocity = pawn.get_ref().move_and_slide(velocity)