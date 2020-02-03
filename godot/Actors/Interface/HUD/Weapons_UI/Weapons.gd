extends VBoxContainer

onready var bullet_conter = $HBoxContainer/Bullets/Bullets_counter
var curent_ammo
var curent_mags

var curent_primary_weapon_texture = "res://Actors/Interface/HUD/Weapons_UI/Main_weap.png"   #Текстура
var curent_secondary_weapon_texture  = "res://Actors/Interface/HUD/Weapons_UI/Sec_weap.png"  #Текстура

onready var curent_weapon_texture = $Primary   #Оружие в руках (Prim/Sec)
onready var weapon_compliance = {1: $Primary, 2: $Secondary}

var curent_weapon


func show_weapon(weapon, extra_ammo):
	if curent_weapon and curent_weapon.get_ref():
		curent_weapon.get_ref().disconnect("shoot", self, "_ammo_changed")
		
	curent_ammo = weapon.ammo
	curent_mags = extra_ammo
	curent_weapon = weakref(weapon)
	weapon.connect("shoot", self, "_ammo_changed")
	set_bullet_counter(curent_ammo, curent_mags)
	set_weapon_loadout(weapon)
	show_curent_weapon(1 if weapon.get_type() == "primary" else 2)


func update_ammo(weapon, extra_ammo):
	curent_ammo = weapon.ammo
	curent_mags = extra_ammo
	update_bullet_counter()


func set_bullet_counter(ammo, mags):
	bullet_conter.text = str(round(ammo)) + " / " + str(round(mags))


func update_bullet_counter():
	bullet_conter.text = str(round(curent_ammo)) + " / " + str(round(curent_mags))


func _ammo_changed(ammo):
	curent_ammo = ammo
	update_bullet_counter()


func set_weapon_loadout(weapon):  #При подборе оружия
	if weapon.get_type() == "primary":
		curent_primary_weapon_texture = weapon.get_node("WeaponElements/HUDSprite").texture
		$Primary.texture = weapon.get_node("WeaponElements/HUDSprite").texture
	else:
		curent_secondary_weapon_texture = weapon.get_node("WeaponElements/HUDSprite").texture
		$Secondary.texture = weapon.get_node("WeaponElements/HUDSprite").texture


func show_curent_weapon(number): #При переключении оружий 
	#number - номер клавиши (1 или 2) 
	weapon_compliance[number].visible = true
	for elem in weapon_compliance:
		if elem != number:
			print(elem)
			weapon_compliance[elem].visible = true
			$AnimationPlayer.play(str(elem))
			yield($AnimationPlayer, "animation_finished")
			weapon_compliance[elem].modulate = "ffffff"
			weapon_compliance[elem].visible = false
	curent_weapon_texture = weapon_compliance[number]
