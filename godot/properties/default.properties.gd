extends Node

func get(propertyName : String):
	return properties[propertyName]

var properties = {
	"player.camera.translation" : Vector3(0, 25, 15),
	"player.camera.rotation"    : Vector3(-55, 0, 0),
	
	"camera.sensetivity" 		: 0.002,
}
