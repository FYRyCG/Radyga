extends Area


func use(Interacter):
	get_owner().get_node("DoorObject").use(Interacter)
