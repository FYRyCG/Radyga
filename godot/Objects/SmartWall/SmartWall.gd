tool
extends Node2D

class_name SmartWall

export (int) var TILE_SIZE = 8
export (int) var size_x = 1
export (int) var size_y = 1
export (bool) var random_rotate = false
export var tiles = []

const DEFAULT_TILE_SIZE = 8

var smart_tile = preload("res://Objects/SmartWall/Tiles/SmartTile.tscn")

var __prev_size_x = 0
var __prev_size_y = 0

var rng = RandomNumberGenerator.new()

func _ready():
	if Engine.editor_hint:
		rng.randomize()
		size_x = __prev_size_x
		size_y = __prev_size_y
		__prev_size_x = size_x
		__prev_size_y = size_y
		
		_draw_tiles()


func _draw_tiles():
	for t in tiles:
		if t.has_method("queue_free"):
			t.queue_free()
	tiles = []
		
	var sp = $Spawn.position
	for i in range(size_x):
		for j in range(size_y):
			var sf = smart_tile.instance()
			sf.position = sp
			if random_rotate:
				var rotate_angle = rng.randi_range(0, 3)
				sf.rotation_degrees = 90 * rotate_angle
			tiles.append(sf)
			sf.set_name("i" + str(i) + "y" + str(j))
			sf.set_size(TILE_SIZE)
			add_child(sf)
			sf.set_owner(get_tree().get_edited_scene_root())
			sp.y += TILE_SIZE
		sp.x += TILE_SIZE
		sp.y = $Spawn.position.y


func _process(delta):
	if Engine.editor_hint:
		if size_x != __prev_size_x or size_y != __prev_size_y:
			size_changes()


func size_changes():
	$Spawn.global_position.x = -((size_x * TILE_SIZE) / 2.0)
	$Spawn.global_position.y = -((size_y * TILE_SIZE) / 2.0)
	global_position.x = (TILE_SIZE / 2) * -1
	global_position.y = (TILE_SIZE / 2) * -1
	var sc = TILE_SIZE / DEFAULT_TILE_SIZE
	$WallArea/WallShape.scale = Vector2(size_x * sc + 0.5, size_y * sc + 0.5)
	$WallArea/WallShape.global_position = global_position
	__prev_size_x = size_x
	__prev_size_y = size_y
	_draw_tiles()

"""
func _on_WallArea_body_entered(body):
	if body is Charge:
		body.near_wall(true, self)

func _on_WallArea_body_exited(body):
	if body is Charge:
		body.near_wall(false)
"""