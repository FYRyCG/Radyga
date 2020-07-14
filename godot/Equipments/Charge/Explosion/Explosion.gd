extends Node2D

signal explosion_done()

# Урон стенам и тд
const  max_explosion_damage = 150

# Урон человекам :)
const max_damage = 100

const explosion_distance = 40

var damage_step = 8
var step = Vector2(0.1, 0)
var thread = null

func _ready():
	$Area2D/CollisionShape2D.scale = Vector2(1, 1)
	position = Vector2(15, 0) # смещение вправо
	
	explosion()

func explosion():
	$Area2D/CollisionShape2D.scale = Vector2(2, 1)
	$Area2D/Sprite.region_rect = Rect2(0, 0, 20, 10)
	

func _on_Timer_timeout():
	emit_signal("explosion_done")


func _on_Area2D_body_entered(body):
	var dist = global_position.distance_to(body.global_position)
	var body_damage = max_explosion_damage * (1 - min(dist / 100, 1))
	print("dist = ", dist, "dam = ", body_damage)
	if body.has_method("explosion"):
		body.explosion(body_damage)
