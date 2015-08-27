main()
{
	thread getAllLazers();
}

getAllLazers()
{
	lazer = getentarray("security_lazer", "targetname");

	for(i=0;i<lazer.size;i++)
		lazer[i] thread InitLazer(i);


	thread EnableLazerTrig();
}

InitLazer(i)
{
	self.startorigin = self.origin;	
	self MoveZ(self.height, 0.1);
	self waittill("movedone");
	self.endorigin = self.origin;
	self notsolid();
}

EnableAllLazers()
{
	lazer = getentarray("security_lazer", "targetname");

	for(i=0;i<lazer.size;i++)
		lazer[i] thread EnableLazer(self);
}

EnableLazer(player)
{
	wait(self.delay);
	
	self thread MonitorTrigger(player);

	self MoveTo(self.startorigin, 3);
	self waittill("movedone");

	wait(30);

	level thread checkDelay(self.delay);

	level waittill("lazer_back");

	wait(5.5-self.delay+1);

	self MoveTo(self.endorigin, 3);
	self waittill("movedone");

	wait(self.delay);

	level notify("lazer_trig_end");

	wait(5);
	level notify("lazer_end");
}

checkDelay(delay)
{
	if(delay == 5.5)
	{
		wait(0.05);
		self notify("lazer_back");
	}
}

MonitorTrigger(player)
{
	level endon("lazer_trig_end");
	
	while(1)
	{
		players = getentarray("player", "classname");

		for(i=0;i<players.size;i++)
		{
			user = players[i] getOrigin();
			org = self getOrigin();

			if(user[0] >= org[0]-50 && user[0] <= org[0]+50)
			{
				if(user[1] >= org[1]-12 && user[1] <= org[1]+12)
				{
					if(user[2] >= org[2]-30 && user[2] <= org[2]+30)
					{
						if(isPlayer(player) && player.pers["team"] == "allies" && players[i].pers["team"] == "axis") 
							players[i] thread [[level.callbackPlayerDamage]](player, player, 2000, 0, "MOD_GRENADE_SPLASH", "mine_mp", players[i].origin, vectornormalize(players[i].origin + (0,0,20) - players[i].origin), "none", 0);
						else
							players[i] suicide();
					}
				}
			}
		}

		wait(0.05);
	}
}

EnableLazerTrig()
{
	trig = getent("trig_lasers", "targetname");
	price = trig.count;

	while(1)
	{
		trig waittill("trigger", player);

		if(player.power >= price && player.pers["team"] == "allies")
		{
			player thread EnableAllLazers();	
			player.power-= 1000;
			player notify("update_powerhud_value");
			player iprintln(player.name + " ^1Activated Lazers.");
			level waittill("lazer_end");
		}
		else if(player.pers["team"] == "allies")
			player iprintln("^1You don't have enough power.");

		wait(0.05);
	}
}