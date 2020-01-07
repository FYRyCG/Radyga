extends Node2D

func _ready():
	pass

func take(arg):
	$BaseAutoRifles.take(arg)

func drop():
	$BaseAutoRifles.drop()

func shoot():
	$BaseAutoRifles.shoot($Muzzle.global_position, global_rotation)
	
func get_collision():
	return $CollisionShape2D

func use(player):
	$BaseAutoRifles.use(player, self)