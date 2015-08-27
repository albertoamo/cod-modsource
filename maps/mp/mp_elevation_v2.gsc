main()
{
maps\mp\_load::main();
maps\mp\mp_elevation_v2_fx::main();

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");

thread fix();
thread fix2();
thread fix3();
thread fix4();
}

fix4()
{
	volume = [];
	volume[0] = 1150; // min (x)
	volume[1] = 792; // min (y)
	volume[2] = 729; // min  (z)
	volume[3] = 1400; // max  (x)
	volume[4] = 2400; // max  (y)
	volume[5] = 850; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(!isDefined(player.movefixactive))
			player thread moveFix(trigger);

		wait(0.05);
	}
}

fix3()
{
	volume = [];
	volume[0] = -1640; // min (x)
	volume[1] = -430; // min (y)
	volume[2] = 324; // min  (z)
	volume[3] = -1360; // max  (x)
	volume[4] = -130; // max  (y)
	volume[5] = 533; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(!isDefined(player.movefixactive))
			player thread moveFix(trigger);

		wait(0.05);
	}
}

moveFix(trigger)
{
	self endon("disconnect");
	self.movefixactive = true;
	wait(90);
	
	if(isPlayer(self) && self sim\_sf_triggers::isTouchingTrigger(trigger) && self.pers["team"] == "allies")
	{
		spawnpointname = "mp_tdm_spawn";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);
      		self setorigin(spawnpoint.origin);
		self SetPlayerAngles(spawnpoint.angles);	
	}

	self.movefixactive = undefined;
}

fix()
{
	volume = [];
	volume[0] = 1283; // min (x)
	volume[1] = 632; // min (y)
	volume[2] = 163; // min  (z)
	volume[3] = 1320; // max  (x)
	volume[4] = 656; // max  (y)
	volume[5] = 250; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin((1307,730,729));
		wait(0.05);
	}
}

fix2()
{
	volume = [];
	volume[0] = -1900; // min (x)
	volume[1] = 2427; // min (y)
	volume[2] = 416; // min  (z)
	volume[3] = -800; // max  (x)
	volume[4] = 2595; // max  (y)
	volume[5] = 550; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player suicide();
		wait(0.05);
	}
}
