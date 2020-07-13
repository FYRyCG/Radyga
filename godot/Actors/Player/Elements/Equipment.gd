extends Node2D

export var equipments = {}

var ammunitions = {}

# Автоматическая смена на поднятое оружие
var autoswap = true
# Текущий предмет в руках
var hands = null

func start(equipments_, ammunitions_):
	equipments = equipments_.duplicate(true)
	ammunitions = ammunitions_.duplicate(true)
	# Создает экземпляры всего снаряжения
	_init_equipment()

# Создает экземпляры всего снаряжения
func _init_equipment():
	_instance_equipment("primary")
	_instance_equipment("secondary")
	_instance_equipment("melee")
	_instance_equipment("gadget")
	set_hand(equipments.primary)

func _instance_equipment(type):
	# parent == "Player"
	# parent.parent == "map/Players"
	if equipments[type]:
		var instance = equipments[type].instance()
		get_parent().get_parent().call_deferred("add_child", instance)
		if instance.has_method("take"):
			instance.call_deferred("take", get_parent())  # Подбираем оружие
		instance.hide()  # Прячем в инвентарь
		equipments[type] = instance
		
# Кладет obj в руки
func set_hand(obj):
	if hands and hands.get_ref() and obj:
		hands.get_ref().hide()  # Убираем в инвентарь
	hands = weakref(obj)   # Меняем объект в руке
	obj.show()  # Достаем из инвентаря
	# меняем HUD
	if obj.get_object_type() == "weapon":
		show_weapon_on_HUD(obj, ammunitions[obj.Cartridge])
	else:
		pass
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
	var obj_type = obj.get_object_type()
	if obj and (obj_type == "weapon" or obj_type == "gadget"):
		var weapon_type = obj.get_type()
		if equipments[weapon_type]:
			drop_object(equipments[weapon_type])
		obj.take(get_parent())
		equipments[weapon_type] = obj
		set_hand(obj)

func drop_object(obj):
	obj.show()  # Если он был в инвентаре
	if object_in_hand(obj):
		hands = null
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
		if hands.get_ref().has_method("reload") and \
			ammunitions[hands.get_ref().Cartridge] > 0 and \
			hands.get_ref().get_ammo() < hands.get_ref().Capacity:
					
			get_parent().reload()
			var weapon_ammo_rest = hands.get_ref().get_ammo()
			var player_ammo_rest = ammunitions[hands.get_ref().Cartridge]
			var magazine_capacity = hands.get_ref().Capacity
			var add_ammo = min(player_ammo_rest, magazine_capacity - weapon_ammo_rest)
			ammunitions[hands.get_ref().Cartridge] -= add_ammo
			hands.get_ref().call("reload", add_ammo)
			
			update_ammo_on_HUD(hands.get_ref(), ammunitions[hands.get_ref().Cartridge])

func show_weapon_on_HUD(weapon, extra_ammo):
	#print("take ", get_tree().get_network_unique_id())
	#print(is_network_master())
	if is_network_master():
		get_parent().get_HUD().show_weapon(weapon, extra_ammo)

func update_ammo_on_HUD(weapon, extra_ammo):
	if is_network_master():
		get_parent().get_HUD().update_ammo(weapon, extra_ammo)

