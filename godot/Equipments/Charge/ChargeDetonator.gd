extends StaticBody2D

signal explosion

const TYPE = "gadget"
const OBJECT_TYPE = "gadget"

func _ready():
	set_as_toplevel(true)
	$EquipmentControl.start()

func _physics_process(delta):
	if visible:
		if Input.is_action_just_pressed("pl_shoot"):
			emit_signal("explosion")

func take(player):
	$EquipmentControl.take(player)

func drop():
	$EquipmentControl.drop()

func get_type():
	return TYPE

func get_object_type():
	return OBJECT_TYPE
