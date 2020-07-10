extends Control

enum {MAIN, PLAY, OPERATORS, SHOP}

var current_menu = MAIN

func _ready():
	gamestate.host_game("Player")
	
	$Panel/VBoxContainer/Split/UpBar/MenuBar/MainBtn.connect("pressed", self, "change_menu", [MAIN])
	$Panel/VBoxContainer/Split/UpBar/MenuBar/PlayBtn.connect("pressed", self, "change_menu", [PLAY])
	$Panel/VBoxContainer/Split/UpBar/MenuBar/OperatorsBtn.connect("pressed", self, "change_menu", [OPERATORS])
	#$Panel/UpBar/MenuBar/ShopBtn.connect("pressed", self, "change_menu", [SHOP])
	
	gamestate.connect("player_list_changed", self, "refresh_lobby")
	gamestate.connect("connection_succeeded", self, "connection_succeeded")
	#gamestate.connect("connection_failed", self, "connection_faild")
	gamestate.connect("game_ended", self, "game_ended")

func menu_visible(enable):
	$Panel/VBoxContainer/Split/HBoxContainer/LobbyMenu.visible = enable

# connect через графический
func _on_Profile_icon_selected(icon):
	$Panel/VBoxContainer/Split/UpBar/MenuBar/Lobby.set_player_icon(icon)

func change_menu(type):
	hide_current_menu()
	match type:
		MAIN:
			$Panel/VBoxContainer/Parts/Stages/Main.show()
		PLAY:
			$Panel/VBoxContainer/Parts/Stages/Play.show()
		OPERATORS:
			$Panel/VBoxContainer/Parts/Stages/Operators.show()
	current_menu = type

func hide_current_menu():
	match current_menu:
		MAIN:
			$Panel/VBoxContainer/Parts/Stages/Main.hide()
		PLAY:
			$Panel/VBoxContainer/Parts/Stages/Play.hide()
		OPERATORS:
			$Panel/VBoxContainer/Parts/Stages/Operators.hide()


func _on_Play_start():
	hide()

func _on_LobbyMenu_change_icon_pressed():
	$Panel/VBoxContainer/Split/UpBar/MenuBar/Lobby.show()

func _on_LobbyMenu_connect(toIp):
	var icon = $Panel/VBoxContainer/Split/UpBar/MenuBar/Lobby.get_player_icon()
	gamestate.join_game(toIp, "newName", icon)

func connection_succeeded():
	$Panel/VBoxContainer/Split/HBoxContainer/LobbyMenu.connection_succeeded()
	update_button_accessibility()

func _on_LobbyMenu_disconnect():
	gamestate.disconnect_game()
	gamestate.host_game("Player")
	update_button_accessibility()

func refresh_lobby():
	$Panel/VBoxContainer/Split/UpBar/MenuBar/Lobby.refresh(gamestate.get_player_list())

func update_button_accessibility():
	change_menu(MAIN)
	$Panel/VBoxContainer/UpBar/MenuBar/PlayBtn.disabled = not get_tree().is_network_server()

func game_ended():
	gamestate.host_game("Player")
	show()
	update_button_accessibility()

func _on_Map_pick_play():
	hide()

