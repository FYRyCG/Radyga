extends Node2D

#Предварительно происходит спавн двери поверх тайла двери
onready var anim = $AnimationPlayer
export var opened = false
export var destroyed = false
export var busy = false

func _ready():
	if(opened):
		open_door()
	elif(destroyed):
		destroy_door()
	else:
		close_door()

func open_door(): 
	anim.play("Open_door")
	
func close_door():
	anim.play("Close_door")

func destroy_door():
	destroyed = true
	anim.play("Destroy_door")
	
func hit(value):
	if(!opened):
		destroy_door()

func use(Interacter):
	if(busy):
		return
	if(opened):
		close_door()
	else:
		open_door()
	opened = !opened
