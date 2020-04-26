extends Control

signal start

func _on_SimpleMap_pressed():
	emit_signal("start")
	#MapManager.set_map("Simple")
	gamestate.begin_game("Simple")


func _on_Build_pressed():
	emit_signal("start")
	#MapManager.set_map("Build")
	gamestate.begin_game("Build")
