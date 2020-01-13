#include "ShootControl.hpp"

ShootControl::ShootControl(int start_ammo)
{
	ammo = start_ammo;
}

bool ShootControl::can_shoot()
{
	return (ammo > 0);
}

void ShootControl::shoot()
{
	ammo -= 1;
}

int ShootControl::get_ammo()
{
	return ammo;
}

void ShootControl::add_ammo(int add)
{
	ammo += add;
}


