main()
{
level._effect["lantern_light"] = loadfx("fx/props/glow_latern.efx");
maps\mp\_load::main();

ambientPlay("ambient_mp_ze_citystreets");

maps\mp\mp_ze_citystreets_fx::main();
maps\mp\mp_ze_citystreets_door::main();
maps\mp\mp_ze_citystreets_ground_mortars::main();
maps\mp\mp_ze_citystreets_water_drown::main();
maps\mp\mp_ze_citystreets_teleport::main();
maps\mp\mp_ze_citystreets_stukas::main();
maps\mp\mp_ze_citystreets_robot::main();
maps\mp\mp_ze_citystreets_rotate::main();

thread fix();
thread fix2();
thread fix3();
thread fix4();
thread fix5();
thread fix6();
}

fix6()
{
	volume = [];
	volume[0] = 2611; // min (x)
	volume[1] = -1072; // min (y)
	volume[2] = -188; // min  (z)
	volume[3] = 2655; // max  (x)
	volume[4] = -1018; // max  (y)
	volume[5] = -100; // max  (z)
	
	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "axis")
			player setOrigin((RandomIntRange(677, 1204), -1550, 784));

		wait(0.05);
	}
}

fix5()
{
	volume = [];
	volume[0] = 2468; // min (x)
	volume[1] = -1031; // min (y)
	volume[2] = -307; // min  (z)
	volume[3] = 2480; // max  (x)
	volume[4] = -919; // max  (y)
	volume[5] = -157; // max  (z)

	dmg = 2200;

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;

		angles = vectortoangles(player.origin - (player.origin + (100, 0, 0)));
		forward = AnglesToForward( angles );

		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, forward, "none", 0 );

		wait(0.05);
	}
}

fix4()
{
	volume = [];
	volume[0] = -2806; // min (x)
	volume[1] = -3443; // min (y)
	volume[2] = -724; // min  (z)
	volume[3] = 2307; // max  (x)
	volume[4] = 1614; // max  (y)
	volume[5] = -619; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
	trigger.dmg = 100000;
}

fix()
{
	volume = [];
	volume[0] = 145; // min (x)
	volume[1] = -32; // min (y)
	volume[2] = -320; // min  (z)
	volume[3] = 170; // max  (x)
	volume[4] = 0; // max  (y)
	volume[5] = -150; // max  (z)

	dmg = 2200;

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;

		angles = vectortoangles(player.origin - (player.origin + (100, 0, 0)));
		forward = AnglesToForward( angles );

		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, forward, "none", 0 );

		wait(0.05);
	}
}

fix2()
{
	volume = [];
	volume[0] = -238; // min (x)
	volume[1] = -411; // min (y)
	volume[2] = -320; // min  (z)
	volume[3] = -217; // max  (x)
	volume[4] = -374; // max  (y)
	volume[5] = -150; // max  (z)

	dmg = 2200;

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;

		angles = vectortoangles(player.origin - (player.origin - (100, 0, 0)));
		forward = AnglesToForward( angles );

		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, forward, "none", 0 );

		wait(0.05);
	}
}

fix3()
{
	volume = [];
	volume[0] = 1427; // min (x)
	volume[1] = -1035; // min (y)
	volume[2] = -320; // min  (z)
	volume[3] = 1446; // max  (x)
	volume[4] = -975; // max  (y)
	volume[5] = -150; // max  (z)

	dmg = 2200;

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;

		angles = vectortoangles(player.origin - (player.origin - (100, 0, 0)));
		forward = AnglesToForward( angles );

		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, forward, "none", 0 );

		wait(0.05);
	}
}




