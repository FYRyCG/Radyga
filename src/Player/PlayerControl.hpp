#ifndef PLAYERCONTROL_HPP
#define PLAYERCONTROL_HPP

#include <Godot.hpp>
#include <Spatial.hpp>
#include <KinematicBody.hpp>
#include <WeakRef.hpp>
#include <Input.hpp>

#include <memory>

namespace godot {

	class PlayerControl : public Spatial {
		GODOT_CLASS(PlayerControl, Spatial)

	private:
		std::shared_ptr<KinematicBody> player;
		//WeakRef player;
		bool busy = false;
		bool pause_ = false;
        Vector3 gravity = Vector3(0, -9.8, 0);
		int walk_speed = 20;
		int run_speed = 40;

		int player_speed = 40;
		Vector3 motion;

		Vector3 puppet_position;
		Vector3 puppet_motion;
		float puppet_rotation;

		enum equipment {FREE, SHOTGUN, PISTOL, RIFLE};

	public:
		static void _register_methods();

		void _init();

		void start();

		void _physics_process(float delta);

		void set_busy(bool flag);
        
		bool is_busy();

		void pause(bool enable);
	private:
		void sync_switch_weapon(String equip_type, int type);
	};

}

#endif /* !PLAYERCONTROL_HPP */