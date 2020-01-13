extends Area2D


func _on_Eneterence_body_entered(body):
	var canal_position = self.get_parent()
	canal_position = canal_position.get_node("Exit").global_position
	print(canal_position)
	#.get_node("Exit").global_position
	body.global_position = canal_position
