extends Control

var mouse_in_menu = false

signal menu_visible(enable)

func _on_LobbyMenuBtn_pressed():
	emit_signal("menu_visible", true)

func set_player_icon(icon):
	$Panel/HBoxContainer/Me.texture = icon
