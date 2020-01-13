#ifndef SHOOTCONTROL_HPP
#define SHOOTCONTROL_HPP

class ShootControl {
private:
	int ammo = 0;

public:
	ShootControl(int start_ammo);

	bool can_shoot();

	void shoot();
	
	int get_ammo();

	void add_ammo(int add);
};


#endif /* !SHOOTCONTROL_HPP */