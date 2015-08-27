minefields()
{
	minefields = getentarray("minefield", "targetname");
	if (minefields.size > 0)
	{
		level._effect["mine_explosion"] = loadfx ("fx/explosions/grenadeExp_dirt.efx");
	}
	
	for(i = 0; i < minefields.size; i++)
	{
		minefields[i] thread minefield_think();
	}	
}

minefield_think()
{
	while (1)
	{
		self waittill ("trigger",other);
		
		if(isPlayer(other))
			other thread minefield_kill(self);
	}
}

minefield_kill(trigger)
{
	if(isDefined(self.minefield))
		return;

	if(getCvar("mapname") == "mp_elevation_v2" && self.pers["team"] == "axis")
	{
		self.spawnprotected = true;
		spawnpointname = "mp_tdm_spawn";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);

      		self setorigin(spawnpoint.origin);
		self SetPlayerAngles(spawnpoint.angles);
		wait(0.15);
		self.spawnprotected = undefined;

		return;
	}
		
	self.minefield = true;
	self playsound ("minefield_click");

	wait(.5);
	wait(randomFloat(.5));

	if(isdefined(self) && self istouching(trigger))
	{
		origin = self getorigin();
		range = 300;
		maxdamage = 2000;
		mindamage = 50;

		self playsound("explo_mine");
		playfx(level._effect["mine_explosion"], origin);
		radiusDamage(origin, range, maxdamage, mindamage);
	}
	
	self.minefield = undefined;
}
