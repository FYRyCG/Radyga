extends VBoxContainer

func _ready():
	var ops_list = OperativeManager.get_operatives()
	
	for i in ops_list:
		var ops = ops_list[i]
		var info = ops.operative_information
		
		assert(info) # У всех ли оперативников есть инофрмация о них
		
		if info.NAME == "Recruite":
			continue
		
		var btn = Button.new()
		btn.rect_min_size = Vector2(64, 64)
		btn.text = info.NAME
		
		$GridContainer.add_child(btn)
