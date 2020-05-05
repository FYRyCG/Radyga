extends Control

enum {MAIN, PLAY, OPERATORS, SHOP}

var current_menu = MAIN

func _ready():
	gamestate.host_game("Player")
	
	$Panel/UpBar/MenuBar/MainBtn.connect("pressed", self, "change_menu", [MAIN])
	$Panel/UpBar/MenuBar/PlayBtn.connect("pressed", self, "change_menu", [PLAY])
	$Panel/UpBar/MenuBar/OperatorsBtn.connect("pressed", self, "change_menu", [OPERATORS])
	$Panel/UpBar/MenuBar/ShopBtn.connect("pressed", self, "change_menu", [SHOP])
	
	gamestate.connect("player_list_changed", self, "refresh_lobby")
	gamestate.connect("connection_succeeded", self, "connection_succeeded")
	#gamestate.connect("connection_failed", self, "connection_faild")

func menu_visible(enable):
	$Panel/UpBar/LobbyBar/VBoxContainer/LobbyMenu.visible = enable

# connect через графический
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

func _on_LobbyMenu_change_icon_pressed():
	$Profile.show()

func _on_LobbyMenu_connect(toIp):
	var icon = $Panel/UpBar/LobbyBar/VBoxContainer/Lobby.get_player_icon()
	gamestate.join_game(toIp, "newName", icon)

func connection_succeeded():
	$Panel/UpBar/LobbyBar/VBoxContainer/LobbyMenu.connection_succeeded()
	update_button_accessibility()

func _on_LobbyMenu_disconnect():
	gamestate.disconnect_game()
	gamestate.host_game("Player")
	update_button_accessibility()

func refresh_lobby():
	$Panel/UpBar/LobbyBar/VBoxContainer/Lobby.refresh(gamestate.get_player_list())

func update_button_accessibility():
	change_menu(MAIN)
	$Panel/UpBar/MenuBar/PlayBtn.disabled = not get_tree().is_network_server()
