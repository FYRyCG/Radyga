extends KinematicBody2D

func _ready():
	position = Vector2(20, 20)
	$PlayerControl._start(self)