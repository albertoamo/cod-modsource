main()
{
	precacheFX();
	ambientFX();
	spawnWorldFX();
}

precacheFX()
{
	level._effect["glow_latern"]	= loadfx ("fx/props/glow_latern.efx");
        level._effect["insects_carcass_flies"]    = loadfx ("fx/misc/insects_carcass_flies.efx");
}

ambientFX()
{


}

spawnWorldFX()
{
	//props
	

        //smoke


        //misc
        maps\mp\_fx::loopfx("insects_carcass_flies", (648.0, 1024.0, 64.0), 0.3);
        maps\mp\_fx::loopfx("insects_carcass_flies", (1592.0, 568.0, 320.0), 0.3);
        maps\mp\_fx::loopfx("insects_carcass_flies", (704.0, 648.0, 320.0), 0.3);
        maps\mp\_fx::loopfx("insects_carcass_flies", (1481.0, 118.0, 356.0), 0.3);
        maps\mp\_fx::loopfx("insects_carcass_flies", (1499.0, 246.0, 342.0), 0.3);
        maps\mp\_fx::loopfx("insects_carcass_flies", (1375.0, -148.0, 375.0), 0.3);
        maps\mp\_fx::loopfx("insects_carcass_flies", (1154.0, -149.0, 375.0), 0.3);
        maps\mp\_fx::loopfx("insects_carcass_flies", (1117.0, -156.0, 170.0), 0.3);
        maps\mp\_fx::loopfx("insects_carcass_flies", (-672.0, -737.0, 335.0), 0.3);


        //fire

        //amb_emmitters
        maps\mp\_fx::soundfx("motsflys", (648.0, 1024.0, 64));

}