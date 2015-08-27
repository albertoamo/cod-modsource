init()
{
	if(getCvar("scr_deathsound") == "")
		setCvar("scr_deathsound", "1");

	if(getCvar("scr_removebody") == "")
		setCvar("scr_removebody", "1");

	if(getCvar("scr_sinkbody") == "")
		setCvar("scr_sinkbody", "1");

	if(getCvarFloat("scr_removebody") > 999)
		setCvar("scr_removebody", "999");
}

HandleDeadBody(team, owner)
{
	//Give the body a model
	self setModel(owner.model);

	voices = [];
	voices["german"] = 3;
	voices["american"] = 7;
	voices["russian"] = 6;
	voices["british"] = 6;

	// Death sound
	if(getCvar("scr_deathsound") == "1")
	{
		nationality = game[team];
		num = randomInt(voices[nationality]) + 1;
		scream = "generic_death_" + game[team] + "_" + num;
		self playSound(scream);
	}

	if(getCvarFloat("scr_removebody") > 0)
		self thread RemoveBody(getCvarFloat("scr_removebody"));
}

RemoveBody(time)
{
	level endon("intermission");
	
	if(time<0.05) time = 0.05;

	wait time;

	if(isdefined(self))
	{
		if(getCvar("scr_sinkbody") == "1")
		{
			for(i=0;i<(5*20);i++)
			{
				if(!isdefined(self)) return;
				self.origin = self.origin - (0,0,0.2);
				wait .05;
			}

		}
		if(isdefined(self)) self delete();
	}
}