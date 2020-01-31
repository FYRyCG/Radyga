extends Control

onready var viewport = $Minimap/MarginContainer/ViewportContainer/Viewport
onready var weapons = $Weapons
onready var hpbar = $HP_bar

signal hp_changed(health)
signal ammo_changed(amount)

var player = null


func _ready():
	viewport.add_child(MapManager.get_wall_map().duplicate())


func start(player_, max_health, max_ammo=30, max_mags=5):
	player = weakref(player_)
	$Minimap/MarginContainer/ViewportContainer/Viewport/MiniCam.start()
	hpbar.initilized(max_health)
	weapons.initilize(max_ammo, max_mags)

func get_player():
	if player and player.get_ref():
		return player.get_ref()


func change_hp_bar_value(value):
	emit_signal("hp_changed", value)


func set_bullet_counter_value(amount):
	emit_signal("ammo_changed", amount)

