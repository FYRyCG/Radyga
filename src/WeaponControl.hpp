#ifndef WEAPONCONTROL_HPP
#define WEAPONCONTROL_HPP

#include <Godot.hpp>
#include <Node2D.hpp>
#include <Input.hpp>
#include <Timer.hpp>
#include <KinematicBody2D.hpp>
#include <CollisionShape2D.hpp>
#include <ResourceLoader.hpp>
#include <PackedScene.hpp>
#include <Position2D.hpp>
#include <SceneTree.hpp>
#include <Viewport.hpp>
#include <NodePath.hpp>
#include <WeakRef.hpp>
#include <Ref.hpp>

#include <memory>

namespace godot {

	class WeaponControl : public Node2D {
		GODOT_CLASS(WeaponControl, Node2D)

	private:
		Ref<PackedScene> RifleBullet = ResourceLoader::get_singleton()->load("res://Weapons/Rifles/RifleBullet.tscn");
		std::shared_ptr<KinematicBody2D> player;

	public:
		static void _register_methods();

		void _init();

		void take(KinematicBody2D* player_);

		void drop();

		void shoot();

		void use();

		void _process(float delta);

		CollisionShape2D* get_collision();

	private:
		void _sync_shoot(Vector2 shoot_position, float shoot_rotation);

		void _sync_use(NodePath player_path);
	};

}

#endif /* !WEAPONCONTROL_HPP */