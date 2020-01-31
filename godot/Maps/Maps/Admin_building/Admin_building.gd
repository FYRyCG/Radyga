extends Node2D
"""
var current_map = false
onready var room = $Wall_map/Room_2
var Room_list = ["Room_1", "Room_2"]

func _ready():
	for elem in Room_list:
		var R = get_node("Wall_map/"+elem+"/Cover_vis")
		#print(R)


func _on_Wall_map_room_changed(current_room):
	var node = current_room.find_node("Cover_vis")
	node.visible = false
	print("trig?")
	#room.find_node("Cover_vis").visible = true
	#room = current_room

func _on_Wall_map_room_exited(current_room):
	var node = current_room.find_node("Cover_vis")
	node.visible = true
"""
