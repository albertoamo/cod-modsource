main()
{
	thread precache();
	thread mortar();
}

precache()
{
	game["Effect"]["mortar"][0]	= loadfx("fx/explosions/mortarExp_beach.efx");
	game["Effect"]["mortar"][1]	= loadfx("fx/explosions/mortarExp_concrete.efx");
	game["Effect"]["mortar"][2]	= loadfx("fx/explosions/mortarExp_dirt.efx");
	game["Effect"]["mortar"][3]	= loadfx("fx/explosions/mortarExp_mud.efx");
	game["Effect"]["mortar"][4]	= loadfx("fx/explosions/artilleryExp_grass.efx");
	game["Effect"]["tnt"]		= loadfx("fx/props/barrelexp.efx");
	game["Effect"]["barrel_explosion"] = loadfx ("fx/props/barrelExp.efx");
}



mortar()
{
	target[0] = (-568, -4200, -920);
	target[1] = (-352, -4192, -920);
	target[2] = (-136, -4184, -920);
	target[3] = (72, -4208, -920);
	target[4] = (288, -4224, -920);
	target[5] = (504, -4224, -920);
	target[6] = (680, -4208, -920);	

	
	while(1)
	{
		mortarplace = randomInt(target.size);

		wait 1;

		playfx (game["Effect"]["mortar"][randomInt(5)], target[mortarplace]);
		radiusDamage(target[mortarplace], 400, 150, 50);
		self thread playSoundAtLocation("mortar_explosion", target[mortarplace], .1 );
	
		earthquake(0.3, 3, target[mortarplace], 850);

		wait 3;
	}
}

PlaySoundAtLocation(sound, location, iTime)
{
	org = spawn("script_model", location);
	wait 0.05;
	org show();
	org playSound(sound);
	wait iTime;
	org delete();

	return;
}