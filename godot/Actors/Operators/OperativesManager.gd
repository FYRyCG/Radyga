extends Node

var operatives_list = {
	0 : "res://Actors/Operators/Recruit/Recruit.tscn",
	1 : "res://Actors/Operators/Hermes/Hermes.tscn"
}

func _ready():
	for op in operatives_list:
		operatives_list[op] = load(operatives_list[op]).instance()

func get_operatives():
	return operatives_list
