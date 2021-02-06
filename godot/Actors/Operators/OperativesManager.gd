extends Node

var operatives_list = {
	0 : "res://Actors/Operators/Recruit/Recruit.tscn",
	1 : "res://Actors/Operators/Hermes/Hermes.tscn"
}

var operatives_scene_list = {
	"Recruit" : "res://Actors/Operators/Recruit/Recruit.tscn",
	"Hermes" : "res://Actors/Operators/Hermes/Hermes.tscn"
}

func _ready():
	for op in operatives_list:
		print(operatives_list[op]) #load(operatives_list[op]).instance()

func get_operatives():
	return operatives_list

func get_operative_by_name(name):
	return operatives_scene_list[name]
