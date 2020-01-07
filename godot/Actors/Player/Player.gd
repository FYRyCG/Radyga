extends KinematicBody2D

var cur_weapon = null

var current_interactive_body = null

func _ready():
	$PlayerControl._start(self)
	$PlayerElements/InteractiveZone.connect("body_entered", self, "_on_Interactive_body_entered")
	
	
func take_weapon(weapon_):
	if cur_weapon and cur_weapon.get_ref():
		drop_weapon()
	cur_weapon = weakref(weapon_)
	weapon_.take(self)
	
	# set weapon collision
	$WeaponCollision.shape = weapon_.get_collision().shape
	$WeaponCollision.global_position = $PlayerElements/WeaponPosition.global_position
	$WeaponCollision.rotation = weapon_.get_collision().global_rotation
	

func drop_weapon():
	if cur_weapon and cur_weapon.get_ref():
		cur_weapon.get_ref().drop()
		cur_weapon = null

func shoot():
	if cur_weapon.get_ref():
		cur_weapon.get_ref().shoot()

func use():
	if current_interactive_body and current_interactive_body.get_ref() and current_interactive_body.get_ref() != self:
		if current_interactive_body.get_ref().has_method("use"):
			print("use = ", current_interactive_body.get_ref().get_path())
			current_interactive_body.get_ref().use(self)

func _on_Interactive_body_entered(body):
	current_interactive_body = weakref(body)

func get_weapon_position():
	return $PlayerElements/WeaponPosition