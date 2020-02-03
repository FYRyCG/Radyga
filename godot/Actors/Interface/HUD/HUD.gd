extends Control

onready var viewport = $Minimap/MarginContainer/ViewportContainer/Viewport
onready var weapons = $Weapons
onready var hpbar = $HP_bar

signal hp_changed(health)
signal ammo_changed(amount)
signal weapon_swap(number)
signal set_loadout(primary, secondary)


var player = null


func _ready():
	viewport.add_child(MapManager.get_wall_map().duplicate())


func start(player_, max_health):
	player = weakref(player_)
	$Minimap/MarginContainer/ViewportContainer/Viewport/MiniCam.start()
	hpbar.initilized(max_health)


func get_player():
	if player and player.get_ref():
		return player.get_ref()


func change_hp_bar_value(value):
	emit_signal("hp_changed", value)

func show_weapon(weapon, extra_ammo):
	weapons.show_weapon(weapon, extra_ammo)

func update_ammo(weapon, extra_ammo):
	weapons.update_ammo(weapon, extra_ammo)

