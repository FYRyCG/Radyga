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
		register_method("use", &WeaponControl::use, GODOT_METHOD_RPC_MODE_DISABLED);

		register_method("get_collision", &WeaponControl::get_collision, GODOT_METHOD_RPC_MODE_DISABLED);

		register_method("_sync_shoot", &WeaponControl::_sync_shoot, GODOT_METHOD_RPC_MODE_REMOTESYNC);
		register_method("_sync_use", &WeaponControl::_sync_use, GODOT_METHOD_RPC_MODE_REMOTESYNC);
	}

	void godot::WeaponControl::_init()
	{
	}

	void WeaponControl::start()
	{
		set_physics_process(false);
		set_process(false);
		weapon = std::make_shared<StaticBody2D>(*static_cast<StaticBody2D*>(get_parent()));
	}

	void godot::WeaponControl::take(KinematicBody2D* player_)
	{
		player = std::make_shared<KinematicBody2D>(*static_cast<KinematicBody2D*>(player_));
		set_process(true);
	}

	void godot::WeaponControl::drop()
	{
		player.reset();
		set_process(false);
	}

	void godot::WeaponControl::shoot()
	{
		if (static_cast<Timer*>(weapon->get_node("WeaponElements/ShootDelay"))->is_stopped()) {
			auto muzzle = weapon->get_node("WeaponElements/Muzzle");
			rpc("_sync_shoot", muzzle->call("get_global_position"), muzzle->call("get_global_rotation"));
			static_cast<Timer*>(weapon->get_node("WeaponElements/ShootDelay"))->start();
		}
	}

	void godot::WeaponControl::use(KinematicBody2D* player_)
	{
		rpc("_sync_use", player_->get_path());
	}

	void godot::WeaponControl::_process(float delta)
	{
		auto weapon_position = player->call("get_weapon_position");
		if (player.get() != nullptr //&&
			/*weapon_position.has_method("get_global_position")*/) {  // don't work in debug mode
			auto pos = (Vector2)weapon_position.call("get_global_position", nullptr, 0);
			auto dir = (float)weapon_position.call("get_global_rotation", nullptr, 0);
			weapon->set_global_position(pos);
			weapon->set_global_rotation(dir);
		}
	}

	CollisionShape2D* godot::WeaponControl::get_collision()
	{
		return static_cast<CollisionShape2D*>(get_node("CollisionShape2D"));
	}

	void godot::WeaponControl::_sync_shoot(Vector2 shoot_position, float shoot_rotation)
	{
		auto bullet = RifleBullet->instance();
		bullet->call("start", shoot_position, shoot_rotation);
		weapon->get_node("WeaponElements")->call("shoot"); // draw Sprite
		weapon->get_parent()->get_parent()->get_parent()->add_child(bullet);
	}

	void godot::WeaponControl::_sync_use(NodePath player_path)
	{
		get_tree()->get_root()->get_node(player_path)->call("take_weapon", this);
	}

}