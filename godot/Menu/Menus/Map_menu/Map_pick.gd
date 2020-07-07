extends Control

signal play
var picked_maps = []
var curent_map
	
	
func _on_CheckButton_toggled(button_pressed, map_name):
	print(map_name)	
	print(button_pressed)
	if (button_pressed == true):
		picked_maps.append(map_name)
	else:
		picked_maps.erase(map_name)
	print(picked_maps)


func _on_Play_pressed():
	randomize()
	curent_map = picked_maps[randi()%picked_maps.size()]
	print(curent_map)
	#emit_signal("start")
	gamestate.begin_game(curent_map)
	queue_free()
