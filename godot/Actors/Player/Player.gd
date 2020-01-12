extends KinematicBody2D

class_name Player
func get_class(): return "Player"

export (PackedScene) var control_script = preload("res://Actors/Player/PlayerControl.tscn") setget set_control_script
export (bool) var playable = false

var cur_weapon = null
var can_shoot = true

var current_interactive_body = null

func _ready():
	add_child(control_script.instance())
	$PlayerControl.set_process(false)
	$PlayerControl.start()
	
	if playable and is_network_master():
		$PlayerElements/Light2D.enabled = true
	
	$PlayerElements/InteractiveZone.connect("body_entered", self, "_on_Interactive_body_entered")
	$PlayerElements/InteractiveZone.connect("body_exited", self, "_on_Interactive_body_exited")


func take_weapon(weapon_):
	if cur_weapon and cur_weapon.get_ref():
		drop_weapon()
	cur_weapon = weakref(weapon_)
	weapon_.take(self)
	
	# set weapon collision
	$PlayerElements/WeaponArea/CollisionShape2D.shape = weapon_.get_collision().shape
	$PlayerElements/WeaponArea/CollisionShape2D.global_position = $PlayerElements/WeaponPosition.global_position
	$PlayerElements/WeaponArea/CollisionShape2D.rotation = weapon_.get_collision().rotation

var grenade
func _physics_process(delta):
	if is_network_master():
		if Input.is_action_just_pressed("pl_grenade"):
			#grenade = weakref(preload("res://Equipments/Grenades/FragGrenade/FragGrenade.tscn").instance())
			grenade = weakref(preload("res://Equipments/Grenades/SmokeGrenade/SmokeGrenade.tscn").instance())
			grenade.get_ref().start()
			add_child(grenade.get_ref())
		if Input.is_action_just_released("pl_grenade"):
			if grenade and grenade.get_ref():
				grenade.get_ref().throw()

func drop_weapon():
	if cur_weapon and cur_weapon.get_ref():
		cur_weapon.get_ref().drop()
		cur_weapon = null

func shoot():
	if can_shoot and cur_weapon and cur_weapon.get_ref():
		cur_weapon.get_ref().shoot()

func use():
	if current_interactive_body and current_interactive_body.get_ref() \
       and current_interactive_body.get_ref().get_class() != "Player":
		if current_interactive_body.get_ref().has_node("WeaponControl"):
			current_interactive_body.get_ref().get_node("WeaponControl").use(self)

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

func start_animation(velocity):
	if (velocity.x != 0 || velocity.y != 0) and has_node("AnimationPlayer"):
		get_node("AnimationPlayer").get_node("AnimationTree").get("parameters/playback").travel("Walk")
	elif has_node("AnimationPlayer"):
		get_node("AnimationPlayer").get_node("AnimationTree").get("parameters/playback").travel("Idle")

var count_entered_body = 0
func _on_WeaponArea_body_entered(body):
	count_entered_body += 1
	can_shoot = false

func _on_WeaponArea_body_exited(body):
	count_entered_body -= 1
	if count_entered_body == 0:
		can_shoot = true
