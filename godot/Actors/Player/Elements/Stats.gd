extends Node

var _max_health
var _max_stamina

var _current_health
var _current_stamina

signal died
signal stamina_over
signal stamina_restored

# Signals for HUD
signal health_changed(current_hp)

var died = false

func _ready():
	connect("died", get_parent(), "death")

func start(max_hp, max_stamina):
	_max_health = max_hp
	_max_stamina = max_stamina
	
	_current_health = _max_health
	_current_stamina = _max_stamina

func change_hp(damage):
	if damage >= _current_health:
		emit_signal("died")
		died = true
	_current_health -= damage
	emit_signal("health_changed", _current_health)

func change_stamina(dt):
	if dt >= _current_stamina:
		emit_signal("stamina_over")
	_current_stamina -= dt
	$StaminaRecoveryTimer.start()

func _on_StaminaRecoveryTimer_timeout():
	if _current_stamina < _max_stamina:
		_current_stamina += 1
	else:
		$StaminaRecoveryTimer.stop()
	if _current_stamina > _max_stamina * 0.3:
		emit_signal("stamina_restored")

func is_alive():
	return not died
