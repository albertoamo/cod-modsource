main()
{
maps\mp\_load::main();
maps\mp\mp_s_i_m_teleportenter::main();
maps\mp\mp_s_i_m_jumpers::main();
maps\mp\mp_s_i_m_piano::main();

//setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
//setCullFog (0, 6500, .68, .68, .68, 0);


game["allies"] = "russian";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["russian_soldiertype"] = "italic";
game["german_soldiertype"] = "italic";

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");

thread fix();
thread fix2();
thread fix3();
}

fix3()
{
	volume = [];
	volume[0] = -732; // min (x)
	volume[1] = 855; // min (y)
	volume[2] = -221; // min  (z)
	volume[3] = -675; // max  (x)
	volume[4] = 901; // max  (y)
	volume[5] = -100; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
		{
			if(!isDefined(player.movefixactive))
				player thread moveFix(trigger);
		}
	}
}

moveFix(trigger)
{
	self.movefixactive = true;
	wait(10);
	
	if(self sim\_sf_triggers::isTouchingTrigger(trigger))
	{
		spawnpointname = "mp_tdm_spawn";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = self maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);
      		self setorigin(spawnpoint.origin);
		self SetPlayerAngles(spawnpoint.angles);
	}

	self.movefixactive = undefined;
}

fix2()
{
	volume = [];
	volume[0] = 601; // min (x)
	volume[1] = -1172; // min (y)
	volume[2] = -305; // min  (z)
	volume[3] = 802; // max  (x)
	volume[4] = -985; // max  (y)
	volume[5] = -155; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
		{
			if(!isDefined(player.movefixactive))
				player thread moveFix(trigger);
		}
	}
}

fix()
{
	volume = [];
	volume[0] = 303; // min (x)
	volume[1] = -616; // min (y)
	volume[2] = -1355; // min  (z)
	volume[3] = 334; // max  (x)
	volume[4] = -509; // max  (y)
	volume[5] = -1250; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "use");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		y = RandomIntRange( 3400, 3713 );

		player setOrigin((32,y,8.125));
	}
}