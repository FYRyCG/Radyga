#ifndef WEAPONCONTROL_HPP
#define WEAPONCONTROL_HPP

#include "ShootControl.hpp"

#include <Godot.hpp>
#include <Spatial.hpp>
#include <Object.hpp>
#include <Input.hpp>
#include <Timer.hpp>
#include <KinematicBody.hpp>
#include <CollisionShape.hpp>
#include <ResourceLoader.hpp>
#include <StaticBody.hpp>
#include <PackedScene.hpp>
#include <Position3D.hpp>
#include <SceneTree.hpp>
#include <Viewport.hpp>
#include <NodePath.hpp>
#include <WeakRef.hpp>
#include <Ref.hpp>

#include <memory>

namespace godot {

	class WeaponControl : public Spatial {
		GODOT_CLASS(WeaponControl, Spatial)

	private:
		Ref<PackedScene> RifleBullet;// = ResourceLoader::get_singleton()->load("res://Weapons/Rifles/RifleBullet.tscn");
		std::shared_ptr<KinematicBody> player;
		std::shared_ptr<StaticBody> weapon;

		ShootControl* shoot_control;

	public:
		static void _register_methods();

		void _init();

		void start(int damage, int start_ammo, String bullet_path);

		void take(KinematicBody* player_);

		void drop();

		void shoot();

		void reload(int add_ammo);

		void use(KinematicBody* player_);

		void _process(float delta);

		CollisionShape* get_collision();

		String get_object_type();

		int get_ammo();

	private:
		void _sync_shoot(Transform global_transform);

		void _sync_use(NodePath player_path);

		void _sync_drop();

		void _sync_reload(int add_ammo);
	};

}

#endif /* !WEAPONCONTROL_HPP */