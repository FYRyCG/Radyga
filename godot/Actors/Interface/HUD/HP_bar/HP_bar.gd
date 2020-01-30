extends MarginContainer

onready var maximum_value = 100
var curent_health

func _ready():
	$TextureProgress.max_value = maximum_value
	$TextureProgress.value = maximum_value

func initilized(maximum):
	maximum_value = maximum
	curent_health = maximum
	$TextureProgress.max_value = maximum_value
	
	
func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "set_value_text", start, end, 0.3, Tween.TRANS_QUART, Tween.EASE_OUT)
	$Tween.start()
	
	
func set_value_text(value):
	$value.text = str(round(value))
	

func _on_HUD_hp_changed(health):
	#Добавить преобразование в проценты
	animate_value(curent_health, health)
	set_value_text(health)
	curent_health = health
