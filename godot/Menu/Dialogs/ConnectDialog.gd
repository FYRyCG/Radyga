extends Control

var output = ""

# signal for MainMenu
signal connect(toIp)

func _on_Cancel_pressed():
	hide()

func _on_Ok_pressed():
	hide()
	emit_signal("connect", $Panel/VBoxContainer/LineEdit.text)

func get_text():
	return output
