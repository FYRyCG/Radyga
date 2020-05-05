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

		register_method("set_busy", &PlayerControl::set_busy, GODOT_METHOD_RPC_MODE_DISABLED);
		register_method("is_busy", &PlayerControl::is_busy, GODOT_METHOD_RPC_MODE_DISABLED);

		register_method("pause", &PlayerControl::pause, GODOT_METHOD_RPC_MODE_DISABLED);
	}

	void PlayerControl::_init() {
	}

	void PlayerControl::start() {
		player = std::make_shared<KinematicBody2D>(*static_cast<KinematicBody2D*>(get_parent()));
		player->call("set_network_master", (int)player->call("get_network_master"));
	}

	void PlayerControl::_physics_process(float delta) {
		if (pause_) {
			return;
		}

		if (is_network_master()) {
			Input* input = Input::get_singleton();
			motion = Vector2();

			if (!busy) {
				player->look_at(get_global_mouse_position());
			}

			if (input->is_action_pressed("ui_left") && !busy) {
				motion.x -= 1;
			}
			if (input->is_action_pressed("ui_right") && !busy) {
				motion.x += 1;
			}
			if (input->is_action_pressed("ui_down") && !busy) {
				motion.y += 1;
			}
			if (input->is_action_pressed("ui_up") && !busy) {
				motion.y -= 1;
			}

			if (input->is_action_pressed("pl_run") && !busy) {
				player_speed = run_speed;
			} else {
				player_speed = walk_speed;
			}

			if (input->is_action_pressed("pl_shoot")) {
				player->call("shoot", delta);
			}

			if (input->is_action_just_pressed("pl_drop") && !busy) {
				player->call("drop_object");
			}

			if (input->is_action_just_pressed("pl_use") && !busy) {
				player->call("use");
			}

			if (input->is_action_just_pressed("pl_primary_weapon") && !busy) {
				player->get_node("Equipment")->call("switch_weapon", "primary");
				player->call("set_equipped", RIFLE);
			}
			if (input->is_action_just_pressed("pl_secondary_weapon") && !busy) {
				player->get_node("Equipment")->call("switch_weapon", "secondary");
				player->call("set_equipped", RIFLE);
			}
			if (input->is_action_just_pressed("pl_gadget") && !busy) {
				player->get_node("Equipment")->call("switch_weapon", "gadget");
				player->call("set_equipped", FREE);
			}

			if (input->is_action_just_pressed("pl_reload") && !busy) {
				player->get_node("Equipment")->call("reload");
			}
			if (input->is_action_just_pressed("pl_skill") && !busy) {
				player->get_node("Skill")->call("use");
			}

			rset("puppet_motion", motion);
			rset("puppet_rotation", player->get_global_rotation());
			rset("puppet_position", player->get_global_position());
		} else {
			player->set_global_position(puppet_position);
			player->set_global_rotation(puppet_rotation);
			motion = puppet_motion;
		}

		Vector2 normal_motion = motion.normalized();
		if (normal_motion != motion) {
			normal_motion *= 1.2;
		}

		player->call("move_and_slide", normal_motion * player_speed);
		player->call("start_animation", normal_motion);

		if (!is_network_master()) {
			puppet_position = player->get_global_position();
		}
	}

	void PlayerControl::set_busy(bool flag)
	{
		busy = flag;
	}

	bool PlayerControl::is_busy()
	{
		return busy;
	}

	void PlayerControl::pause(bool enable) {
		pause_ = enable;
	}

}


