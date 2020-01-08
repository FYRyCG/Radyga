tool
extends StaticBody2D

export (Texture) var intact_texture = load("res://Maps/Objects/SmartWall/Tiles/TileSprites/wall_tile_gray8.png")


func _ready():
	if intact_texture != null:
		$IntactSprite.texture = intact_texture

func _process(delta):
	if Engine.editor_hint:
		if intact_texture != null:
			$IntactSprite.texture = intact_texture

func hit():
	queue_free()
	