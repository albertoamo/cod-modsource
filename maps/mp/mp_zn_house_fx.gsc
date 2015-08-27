main()
{
	precacheFX();
	ambientFX();
}

precacheFX()
{
	level._effect["building_fire_small"] = loadfx ("fx/fire/building_fire_small.efx");
}


ambientFX()
{

	//fire
	maps\MP\_fx::loopfx("building_fire_small", (-582.6, -852.9, -100.0), 2);
	maps\MP\_fx::loopfx("building_fire_small", (-419.4, -918.5, -100.0), 2);
	maps\MP\_fx::loopfx("building_fire_small", (-343.3, 2201.0, 162.5), 2);

	
}
                                                                                                                                                                                   