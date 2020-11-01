extends Spatial

#Предварительно происходит спавн двери поверх тайла двери
onready var anim
export var opened = false
export var destroyed = false
export var busy = false

func _ready():
	anim = get_parent().get_node("AnimationPlayerDoor")
	if(opened):
		open_door()
	elif(destroyed):
		destroy_door()

func open_door(): 
	anim.play("Open")
	
func close_door():
	anim.play_backwards("Open")

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
