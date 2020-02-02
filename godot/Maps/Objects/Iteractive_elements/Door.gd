extends Node2D

#Предварительно происходит спавн двери поверх тайла двери
onready var anim = $AnimationPlayer

func open_door(): 
	anim.play("Open_door")
