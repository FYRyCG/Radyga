extends Control

var stages = {
	0 : "res://Menu/Menus/StartGame/MapSelector/Map_pick.tscn",
	1 : "res://Menu/Menus/StartGame/OpsSelector/Selector.tscn"
}

var stage = 0
var cur_stage =  null

func _ready():
	stage = 0
	load_stage(stage)

func next_stage():
	cur_stage.queue_free()
	stage += 1
	
	if stage < stages.size():
		load_stage(stage)
	else:
		gamestate.begin_game()

func load_stage(stage):
	cur_stage = load(stages[stage]).instance()
	cur_stage.connect("stage_complited", self, "next_stage")
	$Panel/Stage.add_child(cur_stage)
