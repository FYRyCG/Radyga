extends VBoxContainer


onready var bullet_conter = $HBoxContainer/Bullets/Bullets_counter
var curent_ammo
var curent_mags


func _ready():
	pass
	
	
func initilize(max_ammo, max_mags):
	curent_ammo = max_ammo
	curent_mags = max_mags
	$HBoxContainer/Bullets/Bullets_counter.text = str(curent_ammo) + " / " + str(curent_mags)
	
func set_bullet_counter(ammo, mags):
	bullet_conter.text = str(round(ammo)) + " / " + str(round(mags))


func animate_value(curent_ammo, curent_mags, ammo, mags):
	pass
	
	
func _on_HUD_ammo_changed(ammo, mags):
	#Добавить преобразование в проценты
	#animate_value(curent_ammo, curent_mags, ammo, mags)
	set_bullet_counter(ammo, mags)
	curent_ammo = ammo
	curent_mags = mags
