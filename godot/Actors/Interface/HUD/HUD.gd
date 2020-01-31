extends Control

onready var viewport = $Minimap/MarginContainer/ViewportContainer/Viewport
onready var hp_TextureProgress = $Stats/Hp_st/MarginContainer/TextureProgress
onready var hpbar = $HP_bar

signal hp_changed(health)

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


