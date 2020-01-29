extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _process(delta):
	print("2 ", get_viewport())
	print(self.get_parent().get_parent().get_viewport())
	var img = get_parent().get_parent().get_viewport().get_texture().get_data()
	var img1 = get_viewport().get_texture().get_data()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var tex = ImageTexture.new()
	#tex.create_from_image(img)
	#var screenshot = get_viewport().get_screen_capture()
	img.save_png("res://Actors/Interface/Sprites/screenshot.png")
	img1.save_png("res://Actors/Interface/Sprites/screenshot1.png")
	#$sprite.texture = tex