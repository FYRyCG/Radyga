extends KinematicBody2D

export (GDScript) var control_script = preload("res://Actors/Player/PlayerControl.gd") setget set_control_script

var cur_weapon = null

var current_interactive_body = null

func _ready():
	#var player_control = preload("res://Actors/Player/PlayerControl.tscn")
	$PlayerElements/ControleNode.set_script(control_script)
	$PlayerElements/InteractiveZone.connect("body_entered", self, "_on_Interactive_body_entered")
	$PlayerElements/InteractiveZone.connect("body_exited", self, "_on_Interactive_body_exited")


func take_weapon(weapon_):
	if cur_weapon and cur_weapon.get_ref():
		drop_weapon()
	cur_weapon = weakref(weapon_)
	weapon_.take(self)
	
	# set weapon collision
	$WeaponCollision.shape = weapon_.get_collision().shape
	$WeaponCollision.global_position = $PlayerElements/WeaponPosition.global_position
	$WeaponCollision.rotation = weapon_.get_collision().rotation
	

func drop_weapon():
	if cur_weapon and cur_weapon.get_ref():
		cur_weapon.get_ref().drop()
		cur_weapon = null

func shoot():
	if cur_weapon.get_ref():
		cur_weapon.get_ref().shoot()

func use():
	print(self)
	if current_interactive_body and current_interactive_body.get_ref() and current_interactive_body.get_ref() != self:
		if current_interactive_body.get_ref().has_method("use"):
			print("use = ", current_interactive_body.get_ref().get_path())
			current_interactive_body.get_ref().use(self)

func _on_Interactive_body_entered(body):
	current_interactive_body = weakref(body)

func _on_Interactive_body_exited(body):
	if current_interactive_body and body == current_interactive_body.get_ref():
		current_interactive_body = null

func get_weapon_position():
	return $PlayerElements/WeaponPosition
	
func set_control_script(script : GDScript):
	control_script = script
	$PlayerElements/ControleNode.set_script(control_script)

