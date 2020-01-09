extends Node2D

var current_map = false
var room
var Room_list = ["Room_1", "Room_2"]

func _ready():
	for elem in Room_list:
		var R = get_node("Wall_map/"+elem+"/Cover_vis")
		#print(R)
		R.visible = true


func _on_Wall_map_room_changed(current_room):
	print("gaga")
	room.Cover_vis.visible = true
	room = current_room
	room.Cover_vis.visible = false
