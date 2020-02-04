extends Control

var lobby = preload("res://World/Lobby.tscn")

func _ready():
	$Level_panel.visible = false


func _on_Button_pressed():
	print("Nothing to see here")



func _on_Select_level_pressed():
	pass



func _on_Start_pressed():
	$Level_panel.visible = true
	"""
	get_tree().get_root().add_child(lobby.instance())
	self.queue_free()
	"""

func _on_Simple_Button_pressed():
	MapManager.load_map("res://Maps/Maps/SimpleMap.tscn")
	$Level_panel.visible = false
	get_tree().get_root().add_child(lobby.instance())
	self.queue_free()


func _on_Admin_Button_pressed():
	MapManager.load_map("res://Maps/Maps/Admin_building/Admin_building.tscn")
	$Level_panel.visible = false
	get_tree().get_root().add_child(lobby.instance())
	self.queue_free()


func _on_Button1_pressed(op_name):
	print(op_name)


func _on_Operators_pressed():
	$Operators.show()
