#include "PlayerControl.hpp"

namespace godot {

	namespace {

		String std_to_gd_string(std::string str) {
			return str.c_str();
		}

		std::string gd_to_std_string(String str) {
			return str.utf8().get_data();
		}

	}

	void PlayerControl::_register_methods() {
		register_property<PlayerControl, int>("walk_speed", &PlayerControl::walk_speed, 200);
		register_property<PlayerControl, int>("run_speed", &PlayerControl::run_speed, 300);

		register_property<PlayerControl, Vector2>("puppet_position", &PlayerControl::puppet_position, Vector2(0, 0), GODOT_METHOD_RPC_MODE_SLAVE);
		register_property<PlayerControl, Vector2>("puppet_motion", &PlayerControl::puppet_motion, Vector2(0, 0), GODOT_METHOD_RPC_MODE_SLAVE);
		register_property<PlayerControl, float>("puppet_rotation", &PlayerControl::puppet_rotation, 0, GODOT_METHOD_RPC_MODE_SLAVE);

		register_method("_init", &PlayerControl::_init, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("_physics_process", &PlayerControl::_physics_process, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("start", &PlayerControl::start, GODOT_METHOD_RPC_MODE_DISABLED);
	}

	void PlayerControl::_init() {
	}

	void PlayerControl::start() {
		player = std::make_shared<KinematicBody2D>(*static_cast<KinematicBody2D*>(get_parent()));
		player->call("set_network_master", (int)player->call("get_network_master"));
	}

	void PlayerControl::_physics_process(float delta) {
		if (is_network_master()) {
			player->look_at(get_global_mouse_position());
			motion = Vector2();
			Input* input = Input::get_singleton();
			if (input->is_action_pressed("ui_left")) {
				motion.x -= 1;
			}
			if (input->is_action_pressed("ui_right")) {
				motion.x += 1;
			}
			if (input->is_action_pressed("ui_down")) {
				motion.y += 1;
			}
			if (input->is_action_pressed("ui_up")) {
				motion.y -= 1;
			}

			if (input->is_action_just_pressed("pl_run")) {
				player_speed = run_speed;
			}
			if (input->is_action_just_released("pl_run")) {
				player_speed = walk_speed;
			}

			if (input->is_action_pressed("pl_shoot")) {
				player->call("shoot");
			}

			if (input->is_action_just_pressed("pl_drop")) {
				player->call("drop_weapon");
			}

			if (input->is_action_just_pressed("pl_use")) {
				player->call("use");
			}

			rset("puppet_motion", motion);
			rset("puppet_rotation", player->get_global_rotation());
			rset("puppet_position", player->get_global_position());
		} else {
			player->set_global_position(puppet_position);
			player->set_global_rotation(puppet_rotation);
			motion = puppet_motion;
		}

		motion = motion.normalized() * player_speed;
		player->call("move_and_slide", motion);
		player->call("start_animation", motion);

		if (!is_network_master()) {
			puppet_position = player->get_global_position();
		}
	}

}


