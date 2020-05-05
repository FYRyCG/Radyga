#ifndef PLAYERCONTROL_HPP
#define PLAYERCONTROL_HPP

#include <Godot.hpp>
#include <Node2D.hpp>
#include <KinematicBody2D.hpp>
#include <WeakRef.hpp>
#include <Input.hpp>

#include <memory>

namespace godot {

	class PlayerControl : public Node2D {
		GODOT_CLASS(PlayerControl, Node2D)

	private:
		std::shared_ptr<KinematicBody2D> player;
		//WeakRef player;
		bool busy = false;
		bool pause_ = false;

		int walk_speed = 200;
		int run_speed = 300;

		int player_speed = 200;
		Vector2 motion;

		Vector2 puppet_position;
		Vector2 puppet_motion;
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
	};

}

#endif /* !PLAYERCONTROL_HPP */