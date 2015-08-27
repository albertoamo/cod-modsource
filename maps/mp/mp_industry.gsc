//Map by S.C. sc@hyper-nova.com

main()
{
	maps\mp\mp_industry_fx::main();
	maps\mp\_load::main();
	ambientPlay("ambient_mp_industry");

//	setCullFog(0, 16500, 0.9, 0.95, 1, 0);
	setExpFog( 0.00006, .4, .4, .444, 0 );
//	setExpFog(0.000125, 0.7, 0.85, 1.0, 0);

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";

	setcvar("r_glowbloomintensity0",".25");
	setcvar("r_glowbloomintensity1",".25");
	setcvar("r_glowskybleedintensity0",".5");

	if(getcvar("g_gametype") == "hq")
	{
		level.radio = [];
		level.radio[0] = spawn("script_model", (285.332, 471.947, 12.1747));
		level.radio[0].angles = (0, 335.6, 0);
		
		level.radio[1] = spawn("script_model", (-7.80745, 1100.36, -11.0072));
		level.radio[1].angles = (355.751, 55.1337, -2.21861);
		
		level.radio[2] = spawn("script_model", (1282.54, 731.845, -1.99999));
		level.radio[2].angles = (0, 133.073, 0);
		
		level.radio[3] = spawn("script_model", (2206.32, 411.609, 54.6547));
		level.radio[3].angles = (2.21806, 151.797, -7.6227);
		
		level.radio[4] = spawn("script_model", (758.63, 1725.03, 148));
		level.radio[4].angles = (0, 354.855, 0);
		
		level.radio[5] = spawn("script_model", (1558.4, 1569.03, 96.0133));
		level.radio[5].angles = (0.629538, 196.751, -2.07329);
		
		level.radio[6] = spawn("script_model", (986.298, 3040.61, 58.7701));
		level.radio[6].angles = (0.640552, 196.255, -3.11342);
		
		level.radio[7] = spawn("script_model", (2295.88, 2483.53, 70.7077));
		level.radio[7].angles = (1.35945, 129.516, 1.18606);
		
		level.radio[8] = spawn("script_model", (2971.51, 1570.41, 45.4606));
		level.radio[8].angles = (0.282498, 74.994, -0.237561);
		
		level.radio[9] = spawn("script_model", (1758, 653.443, 176));
		level.radio[9].angles = (0, 39.351, 0);
		
		    	
	}

	thread left(100);
	thread down(100);
	thread fix();
}

fix()
{
	volume = [];
	volume[0] = -950; // min (x)
	volume[1] = -150; // min (y)
	volume[2] = 200; // min  (z)
	volume[3] = -870; // max  (x)
	volume[4] = -90; // max  (y)
	volume[5] = 270; // max  (z)

	dmg = 2200;

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;

		angles = vectortoangles(player.origin - (player.origin + (0, 100, 0)));
		forward = AnglesToForward( angles );

		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, forward, "none", 0 );

		wait(0.05);
	}
}

down(dmg)
{
	volume = [];
	volume[0] = -927; // min (x)
	volume[1] = -553; // min (y)
	volume[2] = 220; // min  (z)
	volume[3] = -804; // max  (x)
	volume[4] = -484; // max  (y)
	volume[5] = 368; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
		{
			if(isDefined(player) && isPlayer(player))
			{
				if(isDefined(player.debugmode))
				{
					player iprintln("Down trigger");
				}
			}
			angles = VectorToAngles( player.origin - (player.origin[0], player.origin[0], 0) );
			player.health += dmg;
			player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(angles), -1000), "none", 0 );
		}

		wait(0.05);
	}
}

left(dmg)
{
	volume = [];
	volume[0] = -854; // min (x)
	volume[1] = -560; // min (y)
	volume[2] = 220; // min  (z)
	volume[3] = -710; // max  (x)
	volume[4] = -535; // max  (y)
	volume[5] = 290; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
		{
			if(isDefined(player) && isPlayer(player))
			{
				if(isDefined(player.debugmode))
				{
					player iprintln("Left trigger");
				}
			}
			angles = VectorToAngles( player.origin - (player.origin[0], -300, player.origin[2]) );
			player.health += dmg;
			player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(angles), -1000), "none", 0 );
		}

		wait(0.05);
	}
}
