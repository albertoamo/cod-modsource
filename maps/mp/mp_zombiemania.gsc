main()
{
	maps\mp\_load::main();
	maps\mp\mp_zombiemania_winda::main();

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "africa";
	game["german_soldiertype"] = "africa";

	thread hurt1();
	thread hurt2();
	
	dmg = 2200;
	thread forward1(dmg);
	thread forward2(dmg);
	thread forward3(dmg);
	thread telefix();
	thread telefix2();
	thread timeout();
}

timeout()
{
	volume = [];
	volume[0] = -6; // min (x)
	volume[1] = 634; // min (y)
	volume[2] = 904; // min  (z)
	volume[3] = 740; // max  (x)
	volume[4] = 771; // max  (y)
	volume[5] = 1088; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies" && !isDefined(player.movefixactive))
		{
			player thread moveFix(trigger);
		}

		wait(0.05);
	}
}

moveFix(trigger)
{
	self endon("disconnect");
	self.movefixactive = true;
	timeout = 60 * 5;
	wait(timeout);
	
	if(isPlayer(self) && self sim\_sf_triggers::isTouchingTrigger(trigger) && self.pers["team"] == "allies")
	{
		spawnpointname = "mp_tdm_spawn";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);
      		self setorigin(spawnpoint.origin);
		self SetPlayerAngles(spawnpoint.angles);
	}

	self.movefixactive = undefined;
}

telefix()
{
	volume = [];
	volume[0] = 549; // min (x)
	volume[1] = -524; // min (y)
	volume[2] = 1032; // min  (z)
	volume[3] = 1585; // max  (x)
	volume[4] = -500; // max  (y)
	volume[5] = 1232; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
		{
			spawnpointname = "mp_tdm_spawn";
			spawnpoints = getentarray(spawnpointname, "classname");
			spawnpoint = player maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);
      			player setorigin(spawnpoint.origin);
			player SetPlayerAngles(spawnpoint.angles);
		}

		wait(0.05);
	}
}

telefix2()
{
	volume = [];
	volume[0] = 471; // min (x)
	volume[1] = -616; // min (y)
	volume[2] = 524; // min  (z)
	volume[3] = 525; // max  (x)
	volume[4] = -551; // max  (y)
	volume[5] = 630; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
		{
			spawnpointname = "mp_tdm_spawn";
			spawnpoints = getentarray(spawnpointname, "classname");
			spawnpoint = player maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);
      			player setorigin(spawnpoint.origin);
			player SetPlayerAngles(spawnpoint.angles);
		}

		wait(0.05);
	}
}

hurt1()
{
	volume = [];
	volume[0] = 962; // min (x)
	volume[1] = -497; // min (y)
	volume[2] = 200; // min  (z)
	volume[3] = 1137; // max  (x)
	volume[4] = -447; // max  (y)
	volume[5] = 230; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
}

hurt2()
{
	volume = [];
	volume[0] = 965; // min (x)
	volume[1] = -305; // min (y)
	volume[2] = 200; // min  (z)
	volume[3] = 1137; // max  (x)
	volume[4] = -143; // max  (y)
	volume[5] = 230; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
}

forward1(dmg)
{
	volume = [];
	volume[0] = 1511; // min (x)
	volume[1] = -340; // min (y)
	volume[2] = 200; // min  (z)
	volume[3] = 1561; // max  (x)
	volume[4] = -301; // max  (y)
	volume[5] = 230; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;
		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(player GetPlayerAngles()), 1000), "none", 0 );

		wait(0.05);
	}
}

forward2(dmg)
{
	volume = [];
	volume[0] = 1468; // min (x)
	volume[1] = 63; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = 1499; // max  (x)
	volume[4] = 105; // max  (y)
	volume[5] = 38; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;
		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(player GetPlayerAngles()), 1000), "none", 0 );

		wait(0.05);
	}
}

forward3(dmg)
{
	volume = [];
	volume[0] = -993; // min (x)
	volume[1] = 570; // min (y)
	volume[2] = 208; // min  (z)
	volume[3] = -903; // max  (x)
	volume[4] = 637; // max  (y)
	volume[5] = 238; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;
		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(player GetPlayerAngles()), 1000), "none", 0 );

		wait(0.05);
	}
}