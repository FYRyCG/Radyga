extends Node2D

onready var nav_2d : Navigation2D
export (int) var walk_speed = 200

export (int) var run_speed = 300

var pawn = null
var pawn_speed = walk_speed
var velocity = Vector2()
var path
var patrol_point = Vector2(-5000,-5000) # -5000 ; -5000 значит, что персонаж может выбрать любой путь для патруля

func _ready():
	pawn = weakref(get_parent())  # if it nullptr then you loh
	patrol_point = MapManager.get_patrol_point(patrol_point)
	path = build_path(global_position, patrol_point.get_position())

func start():
	pass

func _physics_process(delta):
	var distance = pawn_speed * delta
	velocity.x = path.size()
	pawn.get_ref().start_animation(velocity)
	move_along_path(distance)

func build_path(point_a : Vector2, point_b : Vector2):
	return MapManager.build_path(point_a, point_b).points

func move_along_path(distance : float):
	var start_point = global_position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			pawn.get_ref().global_position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			pawn.get_ref().global_position = path[0]
			#set_physics_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	if path.size() == 0:
		# Рандомно ждёт/перекур/идёт куда-то ещё:
		patrol_point = MapManager.get_patrol_point(patrol_point.position)
		path = build_path(global_position, patrol_point.get_position())
