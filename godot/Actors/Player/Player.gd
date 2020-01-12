extends KinematicBody2D

class_name Player
func get_class(): return "Player"

export var equipments = {
	"primary_weapon" : preload("res://Weapons/Rifles/AutomaticRifles/AK47.tscn"),
	"secondary_weapon" : preload("res://Weapons/Rifles/AutomaticRifles/M4.tscn"),
	"melee_weapon" : null,
	"grenades" : {
		"frag" : 1,
		"smoke" : 1
	}
}

export var ammunitions = {
	"7,62" : 90,
	"5,56" : 30
}

export (PackedScene) var control_script = preload("res://Actors/Player/PlayerControl.tscn") setget set_control_script
export (bool) var playable = false

# Текущий предмет в руках
var hands = null
# Проверяет возможность стрелять (если игроку мешает стрелять стена, то он не стреляет)
var can_shoot = true

# Текущий предмет в зоне досягаемости,
# при нажатие "pl_use" будет вызван метод "use" у current_interactive_body
var current_interactive_body = null

func _ready():
	if equipments.primary_weapon == null:
		print("null")
	# Устанавливает скрипт - правило управление player'ом
	add_child(control_script.instance())
	$PlayerControl.set_process(false)
	$PlayerControl.start()

	# Создает экземпляры всего снаряжения
	_init_equipment()
	
	# Проверка, будет ли player управляться игроком
	if playable and is_network_master():
		$PlayerElements/Light2D.enabled = true
	
	$PlayerElements/InteractiveZone.connect("body_entered", self, "_on_Interactive_body_entered")
	$PlayerElements/InteractiveZone.connect("body_exited", self, "_on_Interactive_body_exited")

# Создает экземпляры всего снаряжения
func _init_equipment():
	_instance_equipment("primary_weapon")
	_instance_equipment("secondary_weapon")
	_instance_equipment("melee_weapon")
	set_to_hand(equipments.primary_weapon)

func _instance_equipment(type):
	# parent == "map/Player"
	if equipments[type]:
		var instance = equipments[type].instance()
		get_parent().add_child(instance)
		equipments[type] = weakref(instance)

# Кладет obj в руки
func set_to_hand(obj):
	hands = weakref(equipments.primary_weapon)

func take_object(obj):
	if obj and obj.get_object_type() == "weapon":
		var weapon = obj.get_parent()
		var weapon_type = obj.get_weapon_type()
		equipments[weapon_type] = weakref(weapon)
		obj.take(self)
		
		# set weapon collision
		$PlayerElements/WeaponArea/CollisionShape2D.shape = obj.get_collision().shape
		$PlayerElements/WeaponArea/CollisionShape2D.global_position = $PlayerElements/WeaponPosition.global_position
		$PlayerElements/WeaponArea/CollisionShape2D.rotation = obj.get_collision().rotation

# Вызывается, когда игрок нажимает "pl_drop"
func drop_object(obj):
	if obj and obj.has_method("drop"):
		obj.call("drop")
		obj = null

var grenade
func _physics_process(delta):
	if is_network_master():
		if Input.is_action_just_pressed("pl_throw_grenade"):
			#grenade = weakref(preload("res://Equipments/Grenades/FragGrenade/FragGrenade.tscn").instance())
			grenade = weakref(preload("res://Equipments/Grenades/SmokeGrenade/SmokeGrenade.tscn").instance())
			grenade.get_ref().start()
			add_child(grenade.get_ref())
		if Input.is_action_just_released("pl_throw_grenade"):
			if grenade and grenade.get_ref():
				grenade.get_ref().throw()

# Вызывается, когда игрок нажимет "pl_shoot"
func shoot():
	if can_shoot and hands.get_ref():
		if hands.get_ref().has_method("shoot"):
			hands.get_ref().shoot()

# Вызывается, когда игрок нажимает "pl_use"
func use():
	if current_interactive_body and current_interactive_body.get_ref() \
       and current_interactive_body.get_ref().get_class() != "Player":
		if current_interactive_body.get_ref().has_node("WeaponControl"):
			current_interactive_body.get_ref().get_node("WeaponControl").use(self)

# Проверка, какой предмет находится в зоне досягаемости до player
func _on_Interactive_body_entered(body):
	current_interactive_body = weakref(body)

func _on_Interactive_body_exited(body):
	if current_interactive_body and body == current_interactive_body.get_ref():
		current_interactive_body = null

# Возвращает позицию, где должно находится оружие
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

# Проверка, мешает ли что-то стрелять
var count_entered_body = 0
func _on_WeaponArea_body_entered(body):
	count_entered_body += 1
	can_shoot = false

func _on_WeaponArea_body_exited(body):
	count_entered_body -= 1
	if count_entered_body == 0:
		can_shoot = true
