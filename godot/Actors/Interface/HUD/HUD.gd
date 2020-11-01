extends Control

onready var viewport = $Minimap/MarginContainer/ViewportContainer/Viewport

signal hp_changed(health)
signal ammo_changed(amount)
signal weapon_swap(number)
signal set_loadout(primary, secondary)


var player = null
var cam = null

func _ready():
	cam = get_node("Minimap/ViewportContainer/Viewport/MiniCam")


func start(player_, max_health):
	player = weakref(player_)
	#$Minimap/MarginContainer/ViewportContainer/Viewport/MiniCam.start()
	$HP_bar.initilized(max_health)


func get_player():
	if player and player.get_ref():
		return player.get_ref()


func change_hp_bar_value(value):
	emit_signal("hp_changed", value)

func show_weapon(weapon, extra_ammo):
	$Weapons.show_weapon(weapon, extra_ammo)

func update_ammo(weapon, extra_ammo):
	$Weapons.update_ammo(weapon, extra_ammo)
	
func _process(delta):
	var man = get_player()
	var pos = man.get_translation()
	var new_pos = Vector3(pos[0], cam.get_translation()[1], pos[2])
	cam.set_translation(new_pos)

