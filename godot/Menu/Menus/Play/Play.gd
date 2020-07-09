extends Control

func _on_Multiplayer_pressed():
	pass # Replace with function body.

func _on_COOP_pressed():
	var window = load("res://Menu/Menus/Play/StartCoop.tscn").instance()
	get_tree().get_root().add_child(window)
