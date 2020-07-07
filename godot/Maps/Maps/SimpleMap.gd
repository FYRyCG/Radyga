extends Node2D

func get_navigation():
	return $NavigationNode

func get_patrol_point(current_pos):
	var points_list = $PatrolPoints.get_children()
	var new_points = Array()
	var next_name = "null"
	var is_subspot = false
	#print("start:")
	#print(points_list)
	for i in points_list:
		
		if(current_pos != Vector2(-5000,-5000)):
			#print(i.position)
			#print("vs")
			#print(current_pos)
			if i.position == current_pos: # При нахождении нынешней точки
				next_name = i.next_point # Сохраняем имя следующей точки
				is_subspot = i.subspot
				continue
		#print(i.name)
		#print(i.subspot)
		if i.subspot == false:
			#print("added")
			#print(i)
			new_points.append(i)
	if next_name != "null":
		var next = $PatrolPoints.get_node(next_name)
		if is_subspot:
			#print("returned:")
			#print(next)
			return next
		else:
			new_points.append(next)
	randomize()
	#print("final saved:")
	#print(new_points)
	if(new_points.size() < 1):
		return current_pos
	var randomed = new_points[randi() % new_points.size()]
	#print("result:")	
	print(randomed)
	return randomed
