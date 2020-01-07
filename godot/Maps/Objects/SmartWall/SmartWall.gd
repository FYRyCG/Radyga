tool
extends Node2D

const TILE_SIZE = 8

export (int) var size_x = 1
export (int) var size_y = 1
export (bool) var random_rotate = true

export var tiles = []

var smart_tile = preload("res://Maps/Objects/SmartWall/Tiles/SmartTile.tscn")

var __prev_size_x = 1
var __prev_size_y = 1

var rng = RandomNumberGenerator.new()

func _ready():
	print(tiles)
	if Engine.editor_hint:
		rng.randomize()
		size_x = __prev_size_x
		size_y = __prev_size_y
		__prev_size_x = size_x
		__prev_size_y = size_y
		
		_draw_tiles()


func _draw_tiles():
	for t in tiles:
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
			add_child(sf)
			sf.set_owner(get_tree().get_edited_scene_root())
			sp.y += 8
		sp.x += 8
		sp.y = $Spawn.position.y


func _process(delta):
	if Engine.editor_hint:
		if size_x != __prev_size_x or size_y != __prev_size_y:
			size_changes()


func size_changes():
	var dx = size_x - __prev_size_x
	var dy = size_y - __prev_size_y
	$Spawn.position.x += -dx * 4
	$Spawn.position.y += -dy * 4
	__prev_size_x = size_x
	__prev_size_y = size_y
	_draw_tiles()
