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
		set_physics_process(false);
		set_process(false);
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
		Input* input = Input::get_singleton();
		if (input->is_action_pressed("shoot") &&
			static_cast<Timer*>(get_node("WeaponElements/ShootDelay"))->is_stopped())
		{
			rpc("_sync_shoot");
			static_cast<Timer*>(get_node("WeaponElements/ShootDelay"))->start();
		}
	}

	void godot::WeaponControl::use()
	{
		rpc("_sync_use");
	}

	void godot::WeaponControl::_process(float delta)
	{
		if (player.get() != nullptr) {
			auto obj = player->call("get_weapon_position").operator godot_object * ();
			auto weapon_position = static_cast<Position2D*>(obj);
			set_position(weapon_position->call("get_global_position"));
			set_rotation(weapon_position->call("get_global_rotation"));
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
		get_node("WeaponElements")->call("shoot"); // draw Sprite
		get_parent()->get_parent()->get_parent()->add_child(bullet);
	}

	void godot::WeaponControl::_sync_use(NodePath player_path)
	{
		get_tree()->get_root()->get_node(player_path)->call("take_weapon", this);
	}

}