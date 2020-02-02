extends Control

var lobby = preload("res://World/Lobby.tscn")

func _ready():
	$Level_panel.visible = false


func _on_Button_pressed():
	print("Nothing to see here")



func _on_Select_level_pressed():
	$Level_panel.visible = true



func _on_Start_pressed():
	get_tree().get_root().add_child(lobby.instance())
	self.queue_free()


func _on_Simple_Button_pressed():
	MapManager.load_map("res://Maps/Maps/SimpleMap.tscn")
	$Level_panel.visible = false


func _on_Admin_Button_pressed():
	MapManager.load_map("res://Maps/Maps/Admin_building/Admin_building.tscn")
	$Level_panel.visible = false

