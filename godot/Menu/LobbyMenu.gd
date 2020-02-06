extends Control

var mouse_in_menu = false

signal menu_visible(enable)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if not mouse_in_menu:
				emit_signal("menu_visible", false)

func _on_VBoxContainer_mouse_entered():
	mouse_in_menu = true

func _on_VBoxContainer_mouse_exited():
	mouse_in_menu = false
