extends Camera

onready var Scene = get_parent().get_parent().get_parent()
#onready var HUD = 

func _ready():
	print(Scene)

func _physics_process(delta):
	#Scene = get_parent().get_parent().get_parent()
	#print(Scene)
	#var player = 
	pass
