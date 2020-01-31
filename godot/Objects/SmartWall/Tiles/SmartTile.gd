tool
extends StaticBody2D

class_name SmartTile

export (Texture) var intact_texture = load("res://Objects/SmartWall/Tiles/TileSprites/wall_tile_gray8.png")

const default_size = 8.0

func _ready():
	set_size(get_parent().TILE_SIZE)
	if intact_texture != null:
		$IntactSprite.texture = intact_texture

func _process(delta):
	if Engine.editor_hint:
		if intact_texture != null:
			$IntactSprite.texture = intact_texture

func set_size(new_size):
	var sc = new_size / default_size
	$IntactSprite.scale = Vector2(sc, sc)
	$BrokenSprite.scale = Vector2(sc, sc)
	$CollisionShape2D.scale = Vector2(sc, sc)

func hit(damage):
	queue_free()
	
