main()
{
	//thread spawner();
	thread end();
}

spawner()
{
	trig = getent("spawnsplit","targetname");
	spawnpointallies = getentarray("mp_ctf_spawn_allied","classname");
	spawnpointaxis = getentarray("mp_ctf_spawn_axis","classname");
	
	while(1)
	{
		trig waittill("trigger", other);
	
		if(other.pers["team"] == "allies")
		{
			if(spawnpointallies.size > 0)
			{
				randomall = randomint(spawnpointallies.size);
				teleall = spawnpointallies[randomall];
		
				other setorigin(teleall.origin);
				other setplayerangles(teleall.angles);
		
			}
		}
		else if(other.pers["team"] == "axis")
		{
			if(spawnpointaxis.size > 0)
			{
				randomax = randomint(spawnpointaxis.size);
				teleax = spawnpointaxis[randomax];
		
				other setorigin(teleax.origin);
				other setplayerangles(teleax.angles);
			}
		}
	}
}

end()
{
	wait(level.end_song_wait_time);
	players = getentarray("player","classname");
	for(i=0;i<players.size;i++)
	{
		players[i] playlocalsound("MP_zomend");
	}
}