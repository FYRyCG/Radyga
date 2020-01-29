extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _process(delta):
	print("Screenshot")
	print(get_viewport())
	print(self.get_parent().get_viewport())
	var img = get_viewport().get_texture().get_data()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var tex = ImageTexture.new()
	print(img)
	#tex.create_from_image(img)
	#var screenshot = get_viewport().get_screen_capture()
	img.save_png("res://Actors/Interface/Sprites/screenshot.png")
	#$sprite.texture = tex