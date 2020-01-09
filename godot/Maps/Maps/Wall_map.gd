extends TileMap


var man
var cell
var current_room
signal room_changed(current_room)
signal room_exited(current_room)
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
	print(x, " ", y)
	cell = get_cell(x+1, y)
	if cell == -1:
		cell = get_cell(x, y+1)
		if cell == -1:
			cell = get_cell(x-1, y)
			if cell == -1:
				cell = get_cell(x, y-1)
	var ar = get_used_cells()
	print("Cell_id ", cell)

func _on_Area2D_body_entered(body):
	man = body
	current_room = $Room_1
	print(man.name, "Entered ", current_room.name)
	
	emit_signal("room_changed", current_room)
	
func _on_Area2D_body_exited(body):
	print(man.name, "Exited ", $Room_1.name)
	emit_signal("room_exited", $Room_1)

func _on_Room_2_body_entered(body):
	man = body
	current_room = $Room_2
	print(man.name, "Entered ", current_room.name)
	emit_signal("room_changed", current_room)


func _on_Room_2_body_exited(body):
	print(man.name, "Exited ", $Room_2.name)
	emit_signal("room_exited", $Room_2)
