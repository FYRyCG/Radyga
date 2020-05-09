extends Control

func _physics_process(delta):
	if Input.is_action_just_pressed("game_esc"):
		visible = not visible
		Input.action_release("game_esc")

func _on_Cancel_pressed():
	Input.action_press("game_esc")
	
