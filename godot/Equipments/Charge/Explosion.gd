extends Node2D

signal explosion_done()

# Урон стенам и тд

const  explosion_start_damage = 100
var explosion_current_damage

# Урон человекам :)

const start_damage = 100
var damage

var step = Vector2(0.1, 0)
var thread = null

func _ready():
	$Area2D/CollisionShape2D.scale = Vector2(1, 1)
	position = Vector2(15, 0) # смещение вправо
	
	thread = Thread.new()
	thread.start(self, "explosion")

func explosion(res):
	for i in range(10):
		var sc = $Area2D/CollisionShape2D.scale
		var reg = $Area2D/Sprite.region_rect
		$Area2D/CollisionShape2D.scale = sc + step
		reg.size = reg.size + Vector2(1, 0)
		$Area2D/Sprite.region_rect = reg
		
		yield(get_tree().create_timer(0.01), "timeout")
	
	call_deferred("explosion_done")

func explosion_done():
	thread.wait_to_finish()
	emit_signal("explosion_done")
