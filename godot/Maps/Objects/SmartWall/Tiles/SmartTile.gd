tool
extends StaticBody2D

export (Texture) var intact_texture = null

func _ready():
	if intact_texture != null:
		$IntactSprite.texture = intact_texture

func _process(delta):
	if Engine.editor_hint:
		$IntactSprite.texture = intact_texture
		

