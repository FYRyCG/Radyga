extends Control

var mouse_in_menu = false

signal menu_visible(enable)
signal icon_changed(icon)

func _ready():
	self.connect("icon_changed", gamestate, "change_icon")

func _on_LobbyMenuBtn_pressed():
	emit_signal("menu_visible", true)

func set_player_icon(icon):
	$VBoxContainer/MarginContainer/HBoxContainer/Me.texture = icon
	emit_signal("icon_changed", $VBoxContainer/MarginContainer/HBoxContainer/Me.texture.resource_path)

func get_player_icon():
	return $VBoxContainer/MarginContainer/HBoxContainer/Me.texture.resource_path

func refresh(list):
	for i in range(4):
		get_node("VBoxContainer/MarginContainer/HBoxContainer/Friend" + str(i)) \
			.texture = load("res://Resources/Icons/icon0.png")

	var indx = 0
	for p in list:
		print("p = ", p)
		#var pba = PoolByteArray(p.icon)
		#print(p.icon.get_string_from_ascii ( ))
		#print(Image.new().load_png_from_buffer(p.icon))
		#var kekw = Image.new()
		#print(kekw.load_png_from_buffer(p.icon))
		#print(kekw)
		#print(kekw.get_data().get_string_from_ascii ( ))
		#var icon = load("res://Resources/Icons/icon" + str(p.icon) + ".png")
		get_node("VBoxContainer/MarginContainer/HBoxContainer/Friend" + str(indx)) \
			.texture = load(p.icon)
