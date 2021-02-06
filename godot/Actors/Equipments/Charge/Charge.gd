extends StaticBody2D

class_name Charge

const Type = "gadget"
const Object_type = "gadget"

const red_texture = preload("res://Actors/Equipments/Charge/Sprites/charge-red.png")
const green_texture = preload("res://Actors/Equipments/Charge/Sprites/charge-green.png")
const bluer_texture = preload("res://Actors/Equipments/Charge/Sprites/charge-blue.png")
const gray_texture = preload("res://Actors/Equipments/Charge/Sprites/charge-gray.png")

const CHARGE_SETTING_TIME = 1

var __can_set = false
var __setted = false
var __player = null

var __detonator = preload("res://Actors/Equipments/Charge/ChargeDetonator.tscn").instance()

func _ready():
	__detonator.connect("explosion", self, "exploded")
	$EquipmentControl.start() # Сердце заряда, отвечает за него

var __alone_time = 0
func _physics_process(delta):
	if not __setted:
		if walls.size() > 1:
			$Sprite.texture =green_texture
		else:
			$Sprite.texture = red_texture
	else:
		if walls.size() < 2:
			__alone_time += delta
		else:
			__alone_time = 0
		if __alone_time > 0.1:
			queue_free()

func take(player):
	__player = weakref(player)
	$EquipmentControl.take(player) # Говорим заряду, что его подняли

func drop():
	__player = null
	$EquipmentControl.drop() # Говорим заряду, что его бросили

var timeSettingDestination = 0.0
var copy_walls = []
var aborting_timer = Timer.new()
func setting(delta):
	if not __can_set: copy_walls = walls.duplicate()
	if not __can_set and copy_walls.size() < 2:
		return
	else:
		__player.get_ref().look_at(_nearest_wall(copy_walls).global_position)
		__can_set = true
	
	__player.get_ref().get_node("PlayerControl").call("set_busy", true)  # Игрок точно должен быть
	$AbortingTimer.start()
	timeSettingDestination += delta
	if timeSettingDestination >= CHARGE_SETTING_TIME:
		_set_done()
		
func _set_done():
	timeSettingDestination = 0.0
	$AbortingTimer.stop()
	__setted = true
	__player.get_ref().get_node("PlayerControl").call("set_busy", false)  # Игрок точно должен быть
	get_parent().get_parent().add_child(__detonator)  # It's to World
	__player.get_ref().call("take_object", __detonator)
	# automatic dropped
	# __player.get_ref().call("drop_object", self)
	$Sprite.texture = bluer_texture

func _on_AbortingTimer_timeout():
	__can_set = false
	timeSettingDestination = 0.0
	__player.get_ref().get_node("PlayerControl").call("set_busy", false)  # Игрок точно должен быть

func near_wall(flag, wall_ = null):
	__can_set = flag

func get_type():
	return Type
	
func get_object_type():
	return Object_type

var walls = []
func _on_SetArea_body_entered(body):
	if body is SmartTile:
		walls.append(body)

func _on_SetArea_body_exited(body):
	if body is SmartTile:
		walls.erase(body)

func _nearest_wall(walls):
	var dist = -1
	var res = walls[0]
	var pos = __player.get_ref().global_position
	for wall in walls:
		if dist == -1 or pos.distance_to(wall.global_position) < dist:
			dist = pos.distance_to(wall.global_position)
			res = wall
	return res


var explosion_instance = load("res://Actors/Equipments/Charge/Explosion/Explosion.tscn").instance()

func exploded():
	explosion_instance.connect("explosion_done", self, "queue_free")
	add_child(explosion_instance)
	__detonator.queue_free() # Если взорвал
	# Удалять нельзя, так как еще идет сбор информацие о последствиях взрыва
	#visible = false 

