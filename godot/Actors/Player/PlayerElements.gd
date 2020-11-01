extends Node

func _on_VisionArea_body_entered(body):
	if body.has_method("vision_entered"):
		body.call("vision_entered")


func _on_VisionArea_body_exited(body):
	if body.has_method("vision_exited"):
		body.call("vision_exited")
