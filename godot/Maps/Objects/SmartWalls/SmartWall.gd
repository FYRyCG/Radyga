tool
extends Node2D

const TILE_SIZE = 8

export (int) var size_x
export (int) var size_y

var smart_tile = preload("res://Maps/Objects/SmartWalls/Tiles/SmartTile.tscn")

var __prev_size_x
var __prev_size_y

var tiles = []

func _draw_tiles():
	for t in tiles:
		t.queue_free()
	tiles = []
		
	var sp = $Spawn.position
	for i in range(size_x):
		for j in range(size_y):
			var sf = smart_tile.instance()
			sf.position = sp
			tiles.append(sf)
			add_child(sf)
			
			sp.y += 8
			
		sp.x += 8
		sp.y = $Spawn.position.y


func _ready():
	size_x = 1
	size_y = 1
	
	if Engine.editor_hint:
		__prev_size_x = size_x
		__prev_size_y = size_y
		
		_draw_tiles()


func _process(delta):
	if Engine.editor_hint:
		if size_x != __prev_size_x or size_y != __prev_size_y:
			size_changes()


func size_changes():
	var dx = size_x - __prev_size_x
	var dy = size_y - __prev_size_y
	
	print("dx = ", dx, " dy = ", dy)
	
	$Spawn.position.x += -dx * 4
	$Spawn.position.y += -dy * 4
	
	__prev_size_x = size_x
	__prev_size_y = size_y
	
	_draw_tiles()
	