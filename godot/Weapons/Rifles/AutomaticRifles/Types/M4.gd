extends Node2D

func _ready():
	position = $BaseAutoRifles.position

func start(arg):
	$BaseAutoRifles.start(arg)
	
func shoot():
	$BaseAutoRifles.shoot($Muzzle.global_position, global_rotation)
	
func get_collision():
	return $CollisionShape2D
	