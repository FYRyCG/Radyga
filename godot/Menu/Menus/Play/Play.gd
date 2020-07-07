extends Control

signal start
signal map_pick



func _on_SimpleMap_pressed():
	emit_signal("start")
	#MapManager.set_map("Simple")
	gamestate.begin_game("Simple")

"""
func _on_Build_pressed():
	emit_signal("start")
	#MapManager.set_map("Build")
	gamestate.begin_game("Build")
"""


func _on_Multiplayer_pressed():
	pass # Replace with function body.


func _on_COOP_pressed():
	var select_window = load("res://Menu/Menus/Map_menu/Map_pick.tscn").instance()
	get_tree().get_root().add_child(select_window)
