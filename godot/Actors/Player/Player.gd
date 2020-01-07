extends KinematicBody2D

var operator_chosen = 1
var operator

func _ready():
	match(operator_chosen):
		1: operator = preload("res://Actors/Operators/Recruit/Recruit.tscn")
	add_child(operator.instance())