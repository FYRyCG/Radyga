extends Node

func get(propertyName : String):
	return properties[propertyName]

var properties = {
	"player.camera.translation" : Vector3(-12, 25, 10),
	"player.camera.rotation"    : Vector3(-55, -45, 0),
}
