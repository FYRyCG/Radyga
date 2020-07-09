extends Node2D

"""

Увеличивает скорость передвижения

"""

export (int) var boost_time = 5
export (int) var reload_time = 10

export (int) var boost_value = 100


func _ready():
	$BoostTime.wait_time = boost_time
	$ReloadTime.wait_time = reload_time


func use():
	if $ReloadTime.is_stopped() and $BoostTime.is_stopped():
		$BoostTime.start()
		get_parent().get_control().walk_speed += boost_value
		get_parent().get_control().run_speed += boost_value


func _on_BoostTime_timeout():
	get_parent().get_control().walk_speed -= boost_value
	get_parent().get_control().run_speed -= boost_value
	$ReloadTime.start()

