extends Control

enum {MAIN, PLAY, OPERATORS, SHOP}

var current_menu = MAIN

func _ready():
	gamestate.host_game("Player")
	
	$Panel/UpBar/MenuBar/MainBtn.connect("pressed", self, "change_menu", [MAIN])
	$Panel/UpBar/MenuBar/PlayBtn.connect("pressed", self, "change_menu", [PLAY])
	$Panel/UpBar/MenuBar/OperatorsBtn.connect("pressed", self, "change_menu", [OPERATORS])
	$Panel/UpBar/MenuBar/ShopBtn.connect("pressed", self, "change_menu", [SHOP])

func menu_visible(enable):
	$LobbyMenu.visible = enable

func _on_LobbyMenu_change_icon_pressed():
	$Profile.show()

func _on_Profile_icon_selected(icon):
	$Panel/UpBar/LobbyBar/Lobby.set_player_icon(icon)

func change_menu(type):
	hide_current_menu()
	match type:
		MAIN:
			$Main.show()
			$Panel/Type.text = "Main"
		PLAY:
			$Panel/Type.text = "Play"
			$Play.show()
		OPERATORS:
			$Panel/Type.text = "Operators"
			$Operators.show()
		SHOP:
			$Panel/Type.text = "Shop"
	current_menu = type

func hide_current_menu():
	match current_menu:
		MAIN:
			$Main.hide()
		PLAY:
			$Play.hide()
		OPERATORS:
			$Operators.hide()


func _on_Play_start():
	hide()
