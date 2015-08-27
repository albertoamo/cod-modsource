main()
{
	precacheFX();
	ambientFX();
}

precacheFX()
{
	level._effect["building_fire_small"] = loadfx ("fx/fire/building_fire_small.efx");
	level._effect["firework"] = loadfx ("fx/explosions/firework.efx");
}


ambientFX()
{

	//fire
	maps\MP\_fx::loopfx("building_fire_small", (688.0, -1264.0, 32.0), 2);
	maps\MP\_fx::loopfx("building_fire_small", (-480.0, -1584.0, 48.0), 2);
	maps\MP\_fx::loopfx("building_fire_small", (516.0, -122.0, 32.0), 2);

	//fireworks
	maps\mp\_fx::loopfx("firework", (-896,-4672,192), 3);
	maps\mp\_fx::loopfx("firework", (0,-4672,192), 4);
	maps\mp\_fx::loopfx("firework", (768,-4672,192), 5);
	
}
                                                                                                                                                                                   