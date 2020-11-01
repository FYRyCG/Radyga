extends VBoxContainer

func _physics_process(delta):
	$Label1.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))
	$Label3.text = "Memory usage: " + str(round(Performance.\
			get_monitor(Performance.MEMORY_STATIC)/1024/1024)) + " MB"
