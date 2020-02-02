extends Node2D
export var _color = Color.white
export var _timer = -1.0
func _ready():
	$Light2D.color = _color
	if(_timer > 0):
		$Timer.start(_timer)


func _on_Timer_timeout():
	queue_free()

func get_time_left():
	return $Timer.time_left
