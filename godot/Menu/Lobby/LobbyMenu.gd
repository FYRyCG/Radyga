extends Control

var mouse_in_menu = false

signal menu_visible(enable)

signal change_icon_pressed()
signal connect(ip)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if not mouse_in_menu:
				emit_signal("menu_visible", false)

func _on_VBoxContainer_mouse_entered():
	mouse_in_menu = true

func _on_VBoxContainer_mouse_exited():
	mouse_in_menu = false

func _on_Button_pressed():
	emit_signal("change_icon_pressed")

func _on_Connect_pressed():
	hide()
	get_parent().get_node("ConnectDialog").show()
	get_parent().get_node("ConnectDialog").set_global_position(rect_global_position)
