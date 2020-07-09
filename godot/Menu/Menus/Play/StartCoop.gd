extends Control

var stages = {
	0 : preload("res://Menu/Menus/StartGame/MapSelector/Map_pick.tscn").instance(),
	1 : preload("res://Menu/Menus/StartGame/OpsSelector/Selector.tscn").instance()
}

var stage = 0
var cur_stage =  null

func _ready():
	stage = 0
	
	for st in stages:
		stages[st].connect("stage_complited", self, "next_stage")
	
	stages[1].connect("ops_selected", self, "select_ops")
	
	load_stage(stage)

func next_stage():
	cur_stage.queue_free()
	stage += 1
	
	if stage < stages.size():
		load_stage(stage)
	else:
		gamestate.begin_game()

func load_stage(stage):
	cur_stage = stages[stage]
	$Panel/Stage.add_child(cur_stage)

func select_ops(operative_name):
	pass
