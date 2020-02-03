extends Control


func _process(delta):
	if Input.is_action_pressed("open_game_menu"):
		queue_free()
