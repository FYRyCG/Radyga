extends Node2D

var cnt = 3

func _ready():
	set_as_toplevel(true)
	$StartSmoke.emitting = true
	$LightOccluder2D.scale = Vector2(0.45, 0.45)

func _on_IncFirstOccluder_timeout():
	$LightOccluder2D.scale += Vector2(0.01, 0.01)

func _on_LifeTime_timeout():
	queue_free()

func _on_StartMiddle_timeout():
	$MiddleSmoke.emitting = true
	if has_node("IncFirstOccluder"):
		$IncFirstOccluder.queue_free()
