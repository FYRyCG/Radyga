extends Node2D

func get_navigation():
	return $NavigationNode

func get_patrol_point(current_pos):
	var points_list = $PatrolPoints.get_children()
	var new_points = Array()
	var next_name = "null"
	var is_subspot = false
	for i in points_list:
		
		if(current_pos != Vector2(-5000,-5000)):
			if i.position == current_pos: # При нахождении нынешней точки
				next_name = i.next_point # Сохраняем имя следующей точки
				is_subspot = i.subspot
				continue
		if i.subspot == false:
			new_points.append(i)
	if next_name != "null":
		var next = $PatrolPoints.get_node(next_name)
		if is_subspot:
			return next
		else:
			new_points.append(next)
	randomize()
	if(new_points.size() < 1):
		return current_pos
	var randomed = new_points[randi() % new_points.size()]
	return randomed
