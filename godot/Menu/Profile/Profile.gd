extends Control

var current_icon_id = 0

signal icon_selected(icon)

func _ready():
	var icon_id = 0
	while $Panel/HBoxContainer/GridContainer.has_node("Icon" + str(icon_id)):
		$Panel/HBoxContainer/GridContainer.get_node("Icon" + str(icon_id)) \
			.connect("pressed", self, "icon_change", [icon_id])
		icon_id += 1


func icon_change(id):
	current_icon_id = id

func _on_Save_pressed():
	emit_signal("icon_selected", \
		$Panel/HBoxContainer/GridContainer \
		.get_node("Icon" + str(current_icon_id)).icon)
	hide()
