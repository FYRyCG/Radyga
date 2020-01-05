extends Node2D

func _ready():
	$SimpleMap/Camera.set_player($SimpleMap/Player)

