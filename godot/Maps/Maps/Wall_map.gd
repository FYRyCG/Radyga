extends TileMap


var man
var cell
var current_room
signal room_changed(current_room)

func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = man.position
	var x
	var y
	if pos.x < 0:
		x = int(pos.x/64) - 1
	else:
		x = int(pos.x/64)
	if pos.y < 0:
		y = int(pos.y/64) - 1
	else:
		y = int(pos.y/64)
	#print(x, " ", y)
	cell = get_cell(x+1, y)
	if cell == -1:
		cell = get_cell(x, y+1)
		if cell == -1:
			cell = get_cell(x-1, y)
			if cell == -1:
				cell = get_cell(x, y-1)
	var ar = get_used_cells()
	#print("Cell_id ", cell)

func _on_Area2D_body_entered(body):
	if(body.name == "Recruit"): # Временное решение
		print("Entered")
		man = body
	
func _on_Area2D_body_exited(body):
		print("Exited")
	
func _on_Room_1_area_entered(area):
	print("Ent")
	current_room = area
	emit_signal("room_changed")
