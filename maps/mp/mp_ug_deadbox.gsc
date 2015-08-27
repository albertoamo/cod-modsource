main()
{
	maps\mp\_load::main();

	setcvar("r_glowbloomintensity0",".25");
	setcvar("r_glowbloomintensity1",".25");
	setcvar("r_glowskybleedintensity0",".5");

	dmg = 40;
	thread forward1(dmg);
	thread forward2(dmg);
}

forward1(dmg)
{
	volume = [];
	volume[0] = 3328; // min (x)
	volume[1] = -1018; // min (y)
	volume[2] = -350; // min  (z)
	volume[3] = 3456; // max  (x)
	volume[4] = -955; // max  (y)
	volume[5] = -265; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(player) && isPlayer(player))
		{
			if(isDefined(player.debugmode))
			{
				player iprintln("Forward trigger");
			}
		}

		player.health += dmg;
		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(player GetPlayerAngles()), 1000), "none", 0 );

		wait(0.05);
	}
}

forward2(dmg)
{
	volume = [];
	volume[0] = 3266; // min (x)
	volume[1] = -957; // min (y)
	volume[2] = -350; // min  (z)
	volume[3] = 3324; // max  (x)
	volume[4] = -651; // max  (y)
	volume[5] = -265; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(player) && isPlayer(player))
		{
			if(isDefined(player.debugmode))
			{
				player iprintln("Forward trigger");
			}
		}

		player.health += dmg;
		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(player GetPlayerAngles()), 1000), "none", 0 );

		wait(0.05);
	}
}