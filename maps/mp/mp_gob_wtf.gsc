main()
{
	
        // @Y, this is a very basic .gsc for a map,
        //     you can change the player types here below   	
        //     There is a list of player types on modsonline
        //     As you can see two // make a line into a remark
        //     So if you want to hear background noise
        //     remove the two // from //ambientplay
 

	// lets play some background sounds
	//ambientPlay("ambient_mp_brecourt");

	
	
	maps\mp\_load::main();
        maps\mp\mp_gob_wtf_teleportenter::main();   //this calls up the teleportenter.gsc
	
        
        

		
	game["allies"] = "british";
	game["axis"] = "german";

	game["british_soldiertype"] = "africa";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "africa";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
        
       	thread update();
	thread update2();
	thread fix();
	thread fix2();
	thread fix3();
}

fix()
{
	volume = [];
	volume[0] = 301; // min (x)
	volume[1] = 1451; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = 360; // max  (x)
	volume[4] = 1736; // max  (y)
	volume[5] = 108; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
			player setOrigin((895,298,730));

		wait(0.05);
	}
}

fix2()
{
	volume = [];
	volume[0] = 773; // min (x)
	volume[1] = 1195; // min (y)
	volume[2] = 80; // min  (z)
	volume[3] = 1050; // max  (x)
	volume[4] = 1254; // max  (y)
	volume[5] = 180; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
			player setOrigin((895,298,730));

		wait(0.05);
	}
}

fix3()
{
	volume = [];
	volume[0] = -361; // min (x)
	volume[1] = 1201; // min (y)
	volume[2] = 80; // min  (z)
	volume[3] = -113; // max  (x)
	volume[4] = 1260; // max  (y)
	volume[5] = 180; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
			player setOrigin((895,298,730));

		wait(0.05);
	}
}

update()
{
	volume = [];
	volume[0] = -1888; // min (x)
	volume[1] = 1914; // min (y)
	volume[2] = 200; // min  (z)
	volume[3] = -654; // max  (x)
	volume[4] = 3504; // max  (y)
	volume[5] = 500; // max  (z)

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

		wait(0.05);
	}
}

moveFix(trigger)
{
	self endon("disconnect");
	self.movefixactive = true;
	wait(60);
	
	if(isPlayer(self) && self sim\_sf_triggers::isTouchingTrigger(trigger) && self.pers["team"] == "allies")
	{
		self setOrigin((816,344,720));
	}

	self.movefixactive = undefined;
}

update2()
{
	volume = [];
	volume[0] = -1792; // min (x)
	volume[1] = 379; // min (y)
	volume[2] = -655; // min  (z)
	volume[3] = -1571; // max  (x)
	volume[4] = 628; // max  (y)
	volume[5] = -550; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		wait(0.5);
		if(isAlive(player)) player suicide();
	}
}