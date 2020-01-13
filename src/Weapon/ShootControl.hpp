#ifndef SHOOTCONTROL_HPP
#define SHOOTCONTROL_HPP

class ShootControl {
private:
	int ammo = 0;

public:
	ShootControl(int start_ammo);

	bool can_shoot();

	void shoot();
};


#endif /* !SHOOTCONTROL_HPP */