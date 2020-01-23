extends KinematicBody2D

class_name Player
func get_class(): return "Player"
	
export var equipments = {
	"primary" : preload("res://Weapons/Rifles/AutomaticRifles/AK47.tscn"),
	"secondary" : preload("res://Weapons/Rifles/AutomaticRifles/M4.tscn"),
	"melee" : null,
	"gadget" : preload("res://Equipments/Charge/Charge.tscn")
}

export var ammunitions = {
	"7,62" : 90,
	"5,56" : 30
}

export (PackedScene) var control_script = preload("res://Actors/Player/PlayerControl.tscn") setget set_control_script
export (bool) var playable = false

# Проверяет возможность стрелять (если игроку мешает стрелять стена, то он не стреляет)
var can_shoot = true
# Строка, содержащая указание для изменения анимации
# "Shoot" - сыграть выбор оружия, если персонаж стоит
# "Use" - пока что просто сделать вид, что персонаж что-то делает
# "Stop" - прекратить действие
# "Idle" - остановить движение
var demanded_animation = null
# Выбранный игроком объект, который будет влиять на анимацию:
# 1 - пробивной заряд/без оружия
# 2 - дробовик
# 3 - пистолет
# 5 - автомат
var equipped_animation = 1
var new_equipped = 1
# Положение на матрице для плавной смены положения:
# (0.0, 0.0) = Без оружия/пробивной заряд
# (-0.5, 0.5) = Автомат
var blend = Vector2(-0.5, 0.5)
# Предыдущая анимация для обработки или игнорирования повторяющихся запросов
var previous_animation = ""
# Текущий предмет в зоне досягаемости,
# при нажатие "pl_use" будет вызван метод "use" у current_interactive_body
var current_interactive_body = null

func _ready():
	# Устанавливает скрипт - правило уп	равление player'ом
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
	if obj.has_method("get_collision"):
		$PlayerElements/WeaponArea/CollisionShape2D.disabled = false
		$PlayerElements/WeaponArea/CollisionShape2D.shape = obj.get_collision().shape
		$PlayerElements/WeaponArea/CollisionShape2D.global_position = $PlayerElements/WeaponPosition.global_position
		$PlayerElements/WeaponArea/CollisionShape2D.rotation = obj.get_collision().rotation
	else:
		$PlayerElements/WeaponArea/CollisionShape2D.disabled = true

var grenade
func _physics_process(delta):
	if is_network_master():
		if Input.is_action_just_pressed("pl_throw_grenade"):
			#grenade = weakref(preload("res://Equipments/Grenades/FragGrenade/FragGrenade.tscn").instance())
			grenade = weakref(preload("res://Equipments/Grenades/SmokeGrenade/SmokeGrenade.tscn").instance())
			grenade.get_ref().start()
			add_child(grenade.get_ref())
		if Input.is_action_just_released("pl_throw_grenade") and not $PlayerControl.is_busy():
			if grenade and grenade.get_ref():
				grenade.get_ref().throw()
				#demanded_animation = "Throw_HE"
				
		if Input.is_action_just_pressed("pl_primary_weapon") and not $PlayerControl.is_busy():
			$PlayerEquipment.switch_weapon("primary")
			new_equipped = 5
		if Input.is_action_just_pressed("pl_secondary_weapon") and not $PlayerControl.is_busy():
			$PlayerEquipment.switch_weapon("secondary")
			new_equipped = 5
		if Input.is_action_just_pressed("pl_gadget") and not $PlayerControl.is_busy():
			$PlayerEquipment.switch_weapon("gadget")
			new_equipped = 1
		if Input.is_action_just_pressed("pl_reload") and not $PlayerControl.is_busy():
			$PlayerEquipment.reload()
			demanded_animation = "Use"

# Вызывается, когда игрок нажимет "pl_shoot"
func shoot(delta):
	var hand = $PlayerEquipment.get_hand()
	if can_shoot and hand:
		if hand.has_method("shoot"):
			demanded_animation = "Shoot"
			hand.shoot()
		elif hand.has_method("setting"):
			demanded_animation = "Shoot"
			hand.setting(delta)

# Вызывается, когда игрок нажимает "pl_use"
func use():
	if current_interactive_body and current_interactive_body.get_ref() \
       and current_interactive_body.get_ref().get_class() != "Player":
		if current_interactive_body.get_ref().has_method("use"):
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

func get_equipment_position():
	return $PlayerElements/EquipmentPosition
	
func set_control_script(script : GDScript):
	control_script = script
	$PlayerElements/ControleNode.set_script(control_script)

func start_animation(velocity):
	if(has_node("AnimationPlayer")):
		var new_animation = null
		var moving = velocity.x != 0 || velocity.y != 0
		var animation_tree = get_node("AnimationPlayer").get_node("AnimationTree").get("parameters/playback")
		if(new_equipped != equipped_animation):
			equipped_animation = -1 # Пока анимация не зафиксирована, будет значение -1
			var demanded_blend
			if(new_equipped == 5):
				demanded_blend = Vector2(-0.5,0.5)
			else:
				demanded_blend = Vector2.ZERO
			if(abs(demanded_blend.x-blend.x) + abs(demanded_blend.y-blend.y) > 0.05):
				blend.x += 0.01 * sign(demanded_blend.x - blend.x)
				blend.y += 0.01 * sign(demanded_blend.y - blend.y)
			else:
				blend = demanded_blend
				equipped_animation = new_equipped
			get_node("AnimationPlayer").get_node("AnimationTree")["parameters/Idle/blend_position"] = blend
			get_node("AnimationPlayer").get_node("AnimationTree")["parameters/Walk/blend_position"] = blend
			get_node("AnimationPlayer").get_node("AnimationTree")["parameters/Use/blend_position"] = blend
			get_node("AnimationPlayer").get_node("AnimationTree")["parameters/Idle_shooting/blend_position"] = blend
		else:
			match(demanded_animation):
				"Use":
					new_animation = "Use"
				"Shoot":
					if(!moving):
						new_animation = "Idle_shooting"
				"Idle":
					if(moving):
						new_animation = "Idle"
		# Проверка на движение
		if(new_animation == null):
			if (moving):
				if(previous_animation != "Walk"):
					new_animation = "Walk"
			else:
				if(previous_animation != "Idle"):
					new_animation = "Idle"
		if(new_animation != null):
			demanded_animation = null
			animation_tree.travel(new_animation)
			previous_animation = new_animation
	

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

func get_walls():
	return walls

