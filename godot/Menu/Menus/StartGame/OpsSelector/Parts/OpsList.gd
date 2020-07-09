extends VBoxContainer

signal operative_selected(image, info)

func _ready():

	var ops_list = OperativeManager.get_operatives()
	
	for i in ops_list:
		var ops = ops_list[i]
		var info = ops.operative_information
		
		assert(info) # У всех ли оперативников есть инофрмация о них
		
		if info.NAME == "Recruit":
			$HBoxContainer/Rectuit.connect("pressed", self, "selected", [null, info])
			continue
		
		var btn = Button.new()
		btn.rect_min_size = Vector2(64, 64)
		btn.text = info.NAME
		
		btn.connect("pressed", self, "selected", [null, info])
		$GridContainer.add_child(btn)
		

func selected(image, info):
	emit_signal("operative_selected", image, info)
