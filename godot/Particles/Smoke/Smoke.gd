extends Node2D

var cnt = 3

signal finish

func start():
	set_as_toplevel(true)
	$StartSmoke.position = get_parent().global_position
	$MiddleSmoke.position = get_parent().global_position
	
	$LifeTime.start()
	$StartMiddle.start()
	$IncFirstOccluder.start()
	
	$StartSmoke.emitting = true
	
	$LightOccluder2D.show()
	$LightOccluder2D.scale = Vector2(0.45, 0.45)

func _on_IncFirstOccluder_timeout():
	$LightOccluder2D.scale += Vector2(0.01, 0.01)

func _on_LifeTime_timeout():
	emit_signal("finish")
	queue_free()

func _on_StartMiddle_timeout():
	$MiddleSmoke.emitting = true
	if has_node("IncFirstOccluder"):
		$IncFirstOccluder.queue_free()

