extends TileMap

var close = 0
var man
var cell


func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	"""
	print("Is close ", close) 
	if close == 1:
		var pos = man.position
		cell = get_cellv(pos)
		print("Cell_id? ", cell)
	"""

func _on_Area2D_body_entered(body):
	man = body
	print(body.position)
	print("Entered")
	var pos = man.position
	var x = int(pos.x/64)
	var y = int(pos.y/64)
	print(x, " ", y)
	cell = get_cell(x, y)
	var ar = get_used_cells()
	print("Cell_id? ", cell)
	print("Cells: ", ar)
	close = 1

func _on_Area2D_body_exited(body):
	close = 0
	print("Exited")
