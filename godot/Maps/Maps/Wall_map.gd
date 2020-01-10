extends TileMap

"""
var man
var cell
var current_room
signal room_changed(current_room)
signal room_exited(current_room)
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
"""
