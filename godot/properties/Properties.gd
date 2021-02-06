extends Node

var defaultProperties = preload("res://properties/default.properties.gd").new()

func get(property : String):
	return defaultProperties.get(property)
