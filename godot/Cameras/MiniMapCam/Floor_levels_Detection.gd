extends Node

func _ready():
	pass


func _on_Floor_area_entered(area, floor_id):
	if area.get_parent().has_node("Camera"):
		print(area.name, "Entered")
		var player_cam = area.get_parent().get_node("Camera")
		player_cam.set_cull_mask(floor_id)



func _on_Floor_area_exited(area, floor_id):
	if area.get_parent().has_node("Camera"):
		print(area.name, "Exited")
		var player_cam = area.get_parent().get_node("Camera")
		player_cam.set_cull_mask(floor_id)
