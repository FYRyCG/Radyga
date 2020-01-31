extends Node2D

func _ready():
	$ShootSprite.global_position = $Muzzle.global_position

func shoot():
	$ShootSprite.show()
	$ShootSprite/Lifetime.start()

func _on_Lifetime_timeout():
	$ShootSprite.hide()
	if(get_parent().has_node("AnimationPlayer")):
		get_parent().get_node("AnimationPlayer").play("Idle")