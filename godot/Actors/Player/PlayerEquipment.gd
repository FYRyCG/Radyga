extends Node2D

export var equipments = {}

var ammunitions = {}

# Автоматическая смена на поднятое оружие
var autoswap = true
# Текущий предмет в руках
var hands = null

func start(equipments_, ammunitions_):
	equipments = equipments_
	ammunitions = ammunitions_
	# Создает экземпляры всего снаряжения
	_init_equipment()
	
# Создает экземпляры всего снаряжения
func _init_equipment():
	_instance_equipment("primary")
	_instance_equipment("secondary")
	_instance_equipment("melee")
	set_hand(equipments.primary)

func _instance_equipment(type):
	# parent == "Player"
	# parent.parent == "map/Players"
	if equipments[type]:
		var instance = equipments[type].instance()
		print("parent add ", get_parent().get_parent().get_path())
		get_parent().get_parent().add_child(instance)
		instance.take(get_parent())  # Подбираем оружие
		instance.hide()  # Прячем в инвентарь
		equipments[type] = instance
		
# Кладет obj в руки
func set_hand(obj):
	if hands and hands.get_ref():
		hands.get_ref().hide()  # Убираем в инвентарь
	hands = weakref(obj)   # Меняем объект в руке
	obj.show()  # Достаем из инвентаря
	# Ставим колизию объекта
	get_parent().set_object_shape(obj)

func get_hand():
	if hands and hands.get_ref():
		return hands.get_ref()
	else: return null

# Выкидывает объект в руке из инвентаря
func drop_hand():
	if hands and hands.get_ref():
		drop_object(hands.get_ref())
		hands = null

func object_in_hand(obj):
	if hands and hands.get_ref() and hands.get_ref() == obj:
		return true
	else:
		return false

func take_object(obj):
	if obj and obj.get_object_type() == "weapon":
		var weapon_type = obj.get_type()
		if equipments[weapon_type]:
			if object_in_hand(equipments[weapon_type]):
				hands = null
			drop_object(equipments[weapon_type])
			
		obj.take(get_parent())
		equipments[weapon_type] = obj
		set_hand(obj)

func drop_object(obj):
	obj.show()  # Если он был в инвентаре
	if obj and obj.has_method("drop"):
		obj.drop()

func switch_weapon(type):
	if type == "grenades":
		set_hand(_get_next_grenade(hands.get_ref().get_type()))
	elif equipments[type]:
		set_hand(equipments[type])

# TODO
func _get_next_grenade(cur):
	if not cur in equipments["grenades"]:
		pass


func reload():
	if hands and hands.get_ref():
		if hands.get_ref().has_method("reload"):
			var weapon_ammo_rest = hands.get_ref().my_call("get_ammo")
			var player_ammo_rest = ammunitions[hands.get_ref().Cartridge]
			var magazine_capacity = hands.get_ref().Capacity
			var add_ammo = min(player_ammo_rest, magazine_capacity - weapon_ammo_rest)
			ammunitions[hands.get_ref().Cartridge] -= add_ammo
			hands.get_ref().call("reload", add_ammo)

