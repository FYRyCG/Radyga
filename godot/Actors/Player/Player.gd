extends KinematicBody

class_name Player
func get_class(): return "Player"

var _pause = false
var blend_speed = -1
var new_equipped = equipment.RIFLE
var _is_dead = false

var rayOrigin = Vector3()
var rayTarget = Vector3()

onready var camera = $PlayerElements/CameraAnchor/Camera

onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") *\
						ProjectSettings.get_setting("physics/3d/default_gravity_vector")

export var innerDependencies = {
	"weaponPos" : "Model/BoyModel/Armature/Skeleton/WeaponAttachment/WeaponPosition"
}

export var equipments = {
	"primary" : preload("res://Actors/Equipments/Weapons/Rifles/AutomaticRifles/AK47.tscn"),
	"secondary" : preload("res://Actors/Equipments/Weapons/Rifles/AutomaticRifles/M4.tscn"),
	"melee" : null,
	"gadget" : preload("res://Actors/Equipments/Charge/Charge.tscn")
}

export var ammunitions = {
	"7,62" : 90,
	"5,56" : 30
}

export var MAX_HP = 100
export var MAX_STAMINA = 100

export (Script) var control_script = preload("res://bin/PlayerControl.gdns") setget set_control_script
# Управляется игроком или компом
export (bool) var playable = false

export (PackedScene) var skill = preload("res://Actors/Operators/Recruit/Skill/RecruitSkill.tscn")

export (Script) var operative_information = null
# Проверяет возможность стрелять (если игроку мешает стрелять стена, то он не стреляет)
var can_shoot = true

enum equipment {FREE, SHOTGUN, PISTOL, RIFLE};

# Текущий предмет в зоне досягаемости,
# при нажатие "pl_use" будет вызван метод "use" у current_interactive_body
var current_interactive_body = null

func _ready():
	# Устанавливает скрипт - правило управление player'ом
	var PlayerControl = preload("res://Actors/Player/PlayerControl.tscn").instance()
	PlayerControl.set_script(control_script)
	add_child(PlayerControl)
	$PlayerControl.start()
	$PlayerControl.set_network_master(get_network_master())
	
	add_child(preload("res://Actors/Player/Elements/Stats.tscn").instance())
	$Stats.start(MAX_HP, MAX_STAMINA)

	# Нода отвечающая за весь инвентарь плеера
	add_child(preload("res://Actors/Player/Elements/Equipment.tscn").instance())
	$Equipment.start(equipments, ammunitions)
	$Equipment.set_network_master(get_network_master())

	# Переименуем ноду скила, чтобы можно было обращатся к ней
	var skill_node = skill.instance()
	skill_node.set_name("Skill")
	add_child(skill_node)
	
	# Проверка, будет ли player управляться игроком
	if playable and is_network_master():
		# Запускаев все жизненно важные органы
		
		#$PlayerElements/Light.light_negative = true
		
		$Stats.connect("health_changed", self, "change_hp")
		$PlayerElements/HUDLayer/HUD.start(self, MAX_HP)
		
		#Настраиваем камеру
		camera.set_player(self)
		
		
	# удалить все ноды, которые не нужны для NPC
	if not playable or not is_network_master():
		$PlayerElements/HUDLayer.queue_free()
		camera.queue_free()
	
	$PlayerElements/InteractiveZone.connect("body_entered", self, "_on_Interactive_body_entered")
	$PlayerElements/InteractiveZone.connect("body_exited", self, "_on_Interactive_body_exited")
	$PlayerElements/InteractiveZone.connect("area_entered", self, "_on_InteractiveZone_area_entered")
	$PlayerElements/InteractiveZone.connect("area_exited", self, "_on_InteractiveZone_area_exited")
	
	
# Берет объект в инвентарь
func take_object(obj):
	$Equipment.take_object(obj)

# Выбрасывает объект из инвентаря
func drop_object(obj):
	if current_interactive_body.get_ref() == obj:
		current_interactive_body = null
	$Equipment.drop_object(obj)

func set_object_shape(obj):
	if obj.has_method("get_collision"):
		$PlayerElements/WeaponArea/CollisionShape.disabled = false
		$PlayerElements/WeaponArea/CollisionShape.shape = obj.get_collision().shape
		$PlayerElements/WeaponArea/CollisionShape.global_transform = $PlayerElements/WeaponPosition.global_transform
	else:
		$PlayerElements/WeaponArea/CollisionShape.disabled = true

var grenade
func _physics_process(delta):
	if playable and is_network_master() and not $PlayerControl.is_busy():
		__look_at()
		scan_for_objects()
		if Input.is_action_just_pressed("game_esc"):
			_pause = not _pause
			$PlayerControl.pause(_pause)
		if Input.is_action_just_released("pl_throw_grenade") and not $PlayerControl.is_busy():
			if grenade and grenade.get_ref():
				grenade.get_ref().throw()

func _input(event):
	if event is InputEventMouseMotion:
		move_camera(-event.relative.x)

func move_camera(dist: float) -> void:
	var camera_anchor = $PlayerElements/CameraAnchor
	var sensetivity =  Properties.get("camera.sensetivity")
	camera_anchor.global_rotate(Vector3(0, 1, 0), dist * sensetivity)

func get_camera_rotation() -> Vector3:
	return $PlayerElements/CameraAnchor.rotation_degrees

func jump():
	pass

# Вызывается, когда игрок нажимет "pl_shoot"
func shoot(delta):
	var hand = $Equipment.get_hand()
	if can_shoot and hand:
		if hand.has_method("shoot"): # Обычная стрельба
			hand.shoot() 
			$AnimationTree.set("parameters/OneShot/active", true)
		elif hand.has_method("setting"): # Установка заряда
			hand.setting(delta)

func start_animation(normal_motion):
	if(normal_motion != 0):
		blend_speed+=0.01
	else:
		blend_speed-=0.01
	blend_speed = max(-1, blend_speed)
	blend_speed = min(1, blend_speed)
	$AnimationTree.set("parameters/BlendSp/blend_position", blend_speed)

# Вызывается, когда игрок нажимает "pl_use"
func use():
	if current_interactive_body and current_interactive_body.get_ref() \
	   and current_interactive_body.get_ref().get_class() != "Player":
		if current_interactive_body.get_ref().has_method("use"):
			current_interactive_body.get_ref().use(self)

func hit(damage):
	$Stats.change_hp(damage)

func change_hp(cur_hp):
	$PlayerElements/HUDLayer/HUD.change_hp_bar_value(cur_hp)

func death():
	_is_dead = true

func _on_InteractiveZone_area_entered(area):
	current_interactive_body = weakref(area)
	print("Player curent interact: ", current_interactive_body.get_ref())
	
func _on_InteractiveZone_area_exited(area):
	if current_interactive_body and area == current_interactive_body.get_ref():
		current_interactive_body = null
	
# Возвращает позицию, где должно находится оружие
func get_weapon_position():
	return get_node(innerDependencies["weaponPos"])

func get_equipment_position():
	return $PlayerElements/EquipmentPosition
	
func set_control_script(script):
	if script:
		control_script = script

func is_alive():
	return $Stats.is_alive()

# Проверка, мешает ли что-то стрелять
var count_entered_body = 0
func _on_WeaponArea_body_entered(body):
	count_entered_body += 1
	can_shoot = false

func _on_WeaponArea_body_exited(body):
	count_entered_body -= 1
	if count_entered_body == 0:
		can_shoot = true

# Проверка SmartWalls, с которыми можно будет взаимодействовать
var walls = {}
func _on_SetArea_body_entered(body):
	if body is SmartTile:
		walls[body] = "0"

func _on_SetArea_body_exited(body):
	if body is SmartTile:
		walls.erase(body)
		
func set_equipped(type):
	new_equipped = type
	
func get_walls():
	return walls

func get_HUD():
	return $PlayerElements/HUDLayer/HUD

func get_control():
	return $PlayerControl

func get_Camera():
	return camera

func __look_at():
	var space_state = get_world().direct_space_state
	rayOrigin = camera.project_ray_origin(get_viewport().get_mouse_position())
	rayTarget = camera.project_ray_normal(get_viewport().get_mouse_position()) * 2000
	
	var intersection = space_state.intersect_ray(rayOrigin, rayTarget)
	
	if not intersection.empty():
		var pos = intersection.position
		$Model.look_at(Vector3(pos.x, translation.y, pos.z), Vector3(0, 1, 0))


var hit_pos
func scan_for_objects():
	var objectsNames = []
	var targetsNames = []
	var targetsObjectsNames = []
	var targets = $PlayerElements.visibleBody
	if targets.size() == 0:
		return
		
	#Собираем названия целей
	for target in targets:
		targetsNames.append(target.name)
	
	var space_state = get_world().direct_space_state
	
	#Собираем названия объектов до которых достает рейкаст при попытке достать до target
	for target in targets: 
		var result = space_state.intersect_ray(global_transform.origin, 
			target.global_transform.origin, [self], collision_mask)
		if result:
			objectsNames.append(result.collider.name)
		var temp = [target.name, result.collider.name]
		targetsObjectsNames.append(temp)
		
	#print("ObjectsList: ", objectsNames)
	#print("TargetObjectsList: ", targetsObjectsNames)
	for pair in targetsObjectsNames:
		if pair[0] == pair[1]:
			var curent = get_parent().get_node("Players/"+ pair[0])
			if curent == null:
				break
			curent.get_node("MeshInstance").set_layer_mask_bit(1, true)
		else:
			var curent = get_parent().get_node("Players/"+ pair[0])
			if curent == null:
				break
			curent.get_node("MeshInstance").set_layer_mask_bit(1, false)
	

