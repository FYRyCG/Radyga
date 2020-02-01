extends VBoxContainer


onready var bullet_conter = $HBoxContainer/Bullets/Bullets_counter
var curent_ammo
var curent_mags
var curent_primary_weapon = "res://Actors/Interface/HUD/Weapons_UI/Main_weap.png"   #Текстура
var curent_secondary_weapon  = "res://Actors/Interface/HUD/Weapons_UI/Sec_weap.png"  #Текстура
onready var curent_weapon = $Primary   #Оружие в руках (Prim/Sec)
var weapon_compliance = {1: $Primary, 2: $Secondary}


func _ready():
	pass
	
	
func initilize(max_ammo, max_mags):
	curent_ammo = max_ammo
	curent_mags = max_mags
	$HBoxContainer/Bullets/Bullets_counter.text = str(curent_ammo) + " / " + str(curent_mags)
	$Primary.texture = load(curent_primary_weapon)
	$Secondary.texture = load(curent_secondary_weapon)
	curent_weapon.visible = true
	
	
func set_bullet_counter(ammo, mags):
	bullet_conter.text = str(round(ammo)) + " / " + str(round(mags))


func animate_value(curent_ammo, curent_mags, ammo, mags):
	pass
	
	
func _on_HUD_ammo_changed(ammo, mags):
	#animate_value(curent_ammo, curent_mags, ammo, mags)
	set_bullet_counter(ammo, mags)
	curent_ammo = ammo
	curent_mags = mags


func set_weapon_loadout(primary, secondary):  #При подборе оружия
	$Primary.texture = primary
	$Secondary.texture = secondary
	curent_primary_weapon = primary
	curent_secondary_weapon = secondary


func show_curent_weapon (number): #При переключении оружий 
	#number - номер клавиши (1 или 2) 
	curent_weapon.visible = false
	curent_weapon = weapon_compliance[number]
	curent_weapon.visible = true


func _on_HUD_set_loadout(primary, secondary):
	set_weapon_loadout(primary, secondary)


func _on_HUD_weapon_swap(number):
	show_curent_weapon(number)

