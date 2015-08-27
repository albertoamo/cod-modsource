main()
{
	maps\mp\_load::main();
	thread fix();
}


fix()
{
	volume = [];
	volume[0] = -1100; // min (x)
	volume[1] = -1100; // min (y)
	volume[2] = -458; // min  (z)
	volume[3] = 3000; // max  (x)
	volume[4] = 4000; // max  (y)
	volume[5] = -385; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", user);

		if(isPlayer(user) && user.pers["team"] == "axis")
			user thread DoRespawn();
		else
			user suicide();

		wait(0.05);
	}
}

DoRespawn()
{
	self.spawnprotected = true;
	spawnpointname = "mp_tdm_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = self maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);
      	self setorigin(spawnpoint.origin);
	self SetPlayerAngles(spawnpoint.angles);
	wait(0.05);
	self.spawnprotected = undefined;
}