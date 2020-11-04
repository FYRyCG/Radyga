extends Node



var hit_pos
var visibleBody = []

func _on_Vision_body_entered(body):
	print(body, " Entered")
	visibleBody.append(body)


func _on_Vision_body_exited(body):
	print(body, "Exited")
	for i in range(visibleBody.size()):
		if visibleBody[i] == body:
			visibleBody.remove(i)

