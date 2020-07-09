extends Control

signal stage_complited()
signal ops_selected(operative_name)

func _on_OK_pressed():
	emit_signal("stage_complited")


func _on_OpsList_operative_selected(image, info):
	$Panel/VBox/HBox/Info/Description.text = "Name: " + info.NAME + "\n\n" \
											+ "Skill: " + info.SKILL_DESCRIPTION
	gamestate.rpc("operative_selected",
					 get_tree().get_network_unique_id(),
					 info.NAME)
