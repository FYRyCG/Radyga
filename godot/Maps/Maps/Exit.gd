extends Area2D



func _on_Exit_body_entered(body):
	var building_position = self.get_parent()
	building_position = building_position.get_node("Eneterence").global_position
	body.global_position = building_position