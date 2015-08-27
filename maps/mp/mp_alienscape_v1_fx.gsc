main()
{
	precacheFX();
	ambientFX();
	 
}

precacheFX()
{
	
	level._effect["dust_wind_brown"] 			= loadfx ("fx/dust/dust_wind_brown.efx");
	level._effect["tank_fire_turret"] 			= loadfx ("fx/fire/tank_fire_turret_small.efx");
	

}

ambientFX()
{
	// tank fire fx	
	maps\mp\_fx::loopfx("tank_fire_turret", (3072,-160,864), 1, (3072,-160,874));
        maps\mp\_fx::loopfx("tank_fire_turret", (1152,-1064,544), 1, (1152,-1064,554));
	
		 
	// Dust FX 
	maps\mp\_fx::loopfx("dust_wind_brown", (616,-1096,8), .6, (616,-1096,28));
        maps\mp\_fx::loopfx("dust_wind_brown", (2144,-1856,-280), .6, (2144,-1856,-290));
	


	//Sound FX
	maps\mp\_fx::soundfx("medfire", (3072,-160,864));
        maps\mp\_fx::soundfx("medfire", (2144,-1856,-280));

        
	
}