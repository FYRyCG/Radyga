extends Node2D

var __player
var __equipment

func start():
	set_physics_process(false)
	set_process(false)
	__equipment = weakref(get_parent())

func take(player):
	__player = weakref(player)
	set_process(true)

func _process(delta):
	if __player.get_ref():
		var eq_pos = __player.get_ref().get_equipment_position()
		var pos = eq_pos.call("get_global_position")
		var dir = eq_pos.call("get_global_rotation")
		__equipment.get_ref().set_global_position(pos)
		__equipment.get_ref().set_global_rotation(dir)

func drop():
	__player = null
	set_process(false)