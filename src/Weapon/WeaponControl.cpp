#include "WeaponControl.hpp"

namespace godot {

	namespace {

		String std_to_gd_string(std::string str) {
			return str.c_str();
		}

		std::string gd_to_std_string(String str) {
			return str.utf8().get_data();
		}

	}

	void godot::WeaponControl::_register_methods()
	{
		register_method("_init", &WeaponControl::_init, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("_process", &WeaponControl::_process, GODOT_METHOD_RPC_MODE_DISABLED);

		register_method("start", &WeaponControl::start, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("take", &WeaponControl::take, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("drop", &WeaponControl::drop, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("shoot", &WeaponControl::shoot, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("reload", &WeaponControl::reload, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("use", &WeaponControl::use, GODOT_METHOD_RPC_MODE_DISABLED);

		register_method("get_collision", &WeaponControl::get_collision, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("get_ammo", &WeaponControl::get_ammo, GODOT_METHOD_RPC_MODE_DISABLED);

		register_method("_sync_shoot", &WeaponControl::_sync_shoot, GODOT_METHOD_RPC_MODE_REMOTE);
		register_method("_sync_use", &WeaponControl::_sync_use, GODOT_METHOD_RPC_MODE_REMOTE);
		register_method("_sync_drop", &WeaponControl::_sync_drop, GODOT_METHOD_RPC_MODE_REMOTE);
		register_method("_sync_reload", &WeaponControl::_sync_reload, GODOT_METHOD_RPC_MODE_REMOTE);
	}

	void godot::WeaponControl::_init()
	{
	}

	void WeaponControl::start(int damage, int start_ammo, String bullet_path)
	{
		set_physics_process(false);
		set_process(false);
		weapon = std::make_shared<StaticBody>(*static_cast<StaticBody*>(get_parent()->get_parent()));
		RifleBullet = ResourceLoader::get_singleton()->load(bullet_path);
		shoot_control = new ShootControl(start_ammo);
	}

	void godot::WeaponControl::take(KinematicBody* player_)
	{
		player = std::make_shared<KinematicBody>(*static_cast<KinematicBody*>(player_));
		set_process(true);
	}

	void godot::WeaponControl::drop()
	{
		rpc("_sync_drop");
		_sync_drop();
	}



	void godot::WeaponControl::shoot()
	{
		if (static_cast<Timer*>(weapon->get_node("WeaponElements/ShootDelay"))->is_stopped()
			&& shoot_control->can_shoot()) {
			auto muzzle = weapon->get_node("WeaponElements/Muzzle");
			rpc("_sync_shoot", muzzle->call("get_global_transform"));
			_sync_shoot(muzzle->call("get_global_transform"));
			static_cast<Timer*>(weapon->get_node("WeaponElements/ShootDelay"))->start();
		}
	}

	void WeaponControl::reload(int add_ammo)
	{
		rpc("_sync_reload", add_ammo);
		_sync_reload(add_ammo);
	}

	void godot::WeaponControl::use(KinematicBody* player_)
	{
		rpc("_sync_use", player_->get_path());
		_sync_use(player_->get_path());
	}

	void godot::WeaponControl::_process(float delta)
	{
		auto weapon_position = player->call("get_weapon_position");
		if (player.get() != nullptr //&&
			/*weapon_position.has_method("get_global_position")*/) {  // don't work in debug mode
			Transform pos = (Transform)(weapon_position.call("get_global_transform", nullptr, 0));
			weapon->set_global_transform(pos);
		}
	}

	CollisionShape* godot::WeaponControl::get_collision()
	{
		return static_cast<CollisionShape*>(get_parent()->get_node("CollisionShape"));
	}

	String WeaponControl::get_object_type()
	{
		return "weapon";
	}

	int WeaponControl::get_ammo()
	{
		return shoot_control->get_ammo();
	}

	void godot::WeaponControl::_sync_shoot(Transform global_transform)
	{
		auto bullet = RifleBullet->instance();
		bullet->call("start", global_transform);
		weapon->get_node("WeaponElements")->call("shoot"); // draw Sprite
		weapon->get_parent()->add_child(bullet);
		player->call("recoil");
		shoot_control->shoot();
	}

	void godot::WeaponControl::_sync_use(NodePath player_path)
	{
		get_tree()->get_root()->get_node(player_path)->call("take_object", get_parent()->get_parent());
	}

	void WeaponControl::_sync_drop()
	{
		player.reset();
		set_process(false);
	}

	void WeaponControl::_sync_reload(int add_ammo)
	{
		shoot_control->add_ammo(add_ammo);
	}

}