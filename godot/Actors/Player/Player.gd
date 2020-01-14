extends KinematicBody2D

class_name Player
func get_class(): return "Player"

export var equipments = {
	"primary" : preload("res://Weapons/Rifles/AutomaticRifles/AK47.tscn"),
	"secondary" : preload("res://Weapons/Rifles/AutomaticRifles/M4.tscn"),
	"melee" : null
}

export var ammunitions = {
	"7,62" : 90,
	"5,56" : 30
}

export (PackedScene) var control_script = preload("res://Actors/Player/PlayerControl.tscn") setget set_control_script
export (bool) var playable = false

# Проверяет возможность стрелять (если игроку мешает стрелять стена, то он не стреляет)
var can_shoot = true

# Текущий предмет в зоне досягаемости,
# при нажатие "pl_use" будет вызван метод "use" у current_interactive_body
var current_interactive_body = null

func _ready():
	# Устанавливает скрипт - правило управление player'ом
	add_child(control_script.instance())
	$PlayerControl.set_process(false)
	$PlayerControl.start()
	# Нода отвечающая за весь инвентарь плеера
	add_child(preload("res://Actors/Player/PlayerEquipment.tscn").instance())
	$PlayerEquipment.start(equipments, ammunitions)

	# Проверка, будет ли player управляться игроком
	if playable and is_network_master():
		$PlayerElements/Light2D.enabled = true
	
	$PlayerElements/InteractiveZone.connect("body_entered", self, "_on_Interactive_body_entered")
	$PlayerElements/InteractiveZone.connect("body_exited", self, "_on_Interactive_body_exited")

# Берет объект в инвентарь
func take_object(obj):
	$PlayerEquipment.take_object(obj)

# Выбрасывает объект из инвентаря
func drop_object(obj):
	$PlayerEquipment.drop_object(obj)

func set_object_shape(obj):
	$PlayerElements/WeaponArea/CollisionShape2D.shape = obj.get_collision().shape
	$PlayerElements/WeaponArea/CollisionShape2D.global_position = $PlayerElements/WeaponPosition.global_position
	$PlayerElements/WeaponArea/CollisionShape2D.rotation = obj.get_collision().rotation

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
				
		if Input.is_action_just_pressed("pl_primary_weapon"):
			$PlayerEquipment.switch_weapon("primary")
		if Input.is_action_just_pressed("pl_secondary_weapon"):
			$PlayerEquipment.switch_weapon("secondary")
		if Input.is_action_just_pressed("pl_reload"):
			$PlayerEquipment.reload()
			pass

# Вызывается, когда игрок нажимет "pl_shoot"
func shoot():
	var hand = $PlayerEquipment.get_hand()
	if can_shoot and hand:
		if hand.has_method("shoot"):
			hand.shoot()

# Вызывается, когда игрок нажимает "pl_use"
func use():
	if current_interactive_body and current_interactive_body.get_ref() \
       and current_interactive_body.get_ref().get_class() != "Player":
		current_interactive_body.get_ref().use(self)

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

# Проверка стена, с которыми можно будет взаимодействовать
var walls = {}
func _on_SetArea_body_entered(body):
	if body is SmartTile:
		walls[body] = "0"

func _on_SetArea_body_exited(body):
	if body is SmartTile:
		walls.erase(body)

func get_walls():
	return walls

