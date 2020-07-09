extends Control

signal stage_complited

func _on_OK_pressed():
	emit_signal("stage_complited")
