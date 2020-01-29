extends Control


func _ready():
	pass
	

func _on_World_load_finished():
	var Parent = self.get_parent().get_parent()
	var Players = Parent.get_node("Players")
	var Players_list = Players.get_child_count()
	print(Players_list)
