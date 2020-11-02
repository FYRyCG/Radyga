extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cells
# Called when the node enters the scene tree for the first time.
func _ready():
	cells = $Box_to_destroy_fract.get_children()
	print(cells)

func _physics_process(delta):
	if Input.is_action_just_pressed("Boom"):
		print("Boom")
		for cell in cells:
			cell.mode = 0
	$Box_to_destroy.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
