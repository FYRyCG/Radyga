extends Control

var lobby = preload("res://World/Lobby.tscn")
onready var icon = load("res://icon.png")


func _ready():
	$Level_panel.visible = false
	$Main/Profile_icon/TextureRect.texture = icon
	$Profile/Icon/TextureRect.texture = icon
	
func _on_Button_pressed():
	print("Nothing to see here")



func _on_Start_pressed():
	$Level_panel.show()
	"""
	get_tree().get_root().add_child(lobby.instance())
	self.queue_free()
	"""

func _on_Simple_Button_pressed():
	MapManager.load_map("res://Maps/Maps/SimpleMap.tscn")
	$Level_panel.hide()
	get_tree().get_root().add_child(lobby.instance())
	self.queue_free()


func _on_Admin_Button_pressed():
	MapManager.load_map("res://Maps/Maps/Admin_building/Admin_building.tscn")
	$Level_panel.hide()
	get_tree().get_root().add_child(lobby.instance())
	self.queue_free()


func _on_Button1_pressed(op_name):
	print(op_name)
	


func _on_Operators_pressed():
	$Operators.show()


func _on_Operators_Exit_pressed():
	$Operators.hide()


func _on_Icon_change_pressed():
	$Profile/VBoxContainer/PopupMenu.show()


func _on_Profilel_pressed():
	$Profile.show()


func _on_PopupMenu_id_pressed(id):
	icon = load("res://World/Main_menu/Icons/icon"+str(id)+".png")
	$Profile/VBoxContainer/PopupMenu.hide()
	$Main/Profile_icon/TextureRect.texture = icon
	$Profile/Icon/TextureRect.texture = icon


func _on_Profile_Exit_pressed():
	$Profile.hide()
