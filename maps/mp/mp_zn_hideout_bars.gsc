main()
{
	thread getDestroyTriggers();
	thread getFixTriggers();
}

getDestroyTriggers()
{
	trigger = getentarray("trig_destroy", "targetname");

	for(i=0;i<trigger.size;i++)
	{
		trigger[i] enableLinkTo();
		trigger[i] thread DestroyBar();
	}
}

getFixTriggers()
{
	trigger = getentarray("trig_fix", "targetname");

	for(i=0;i<trigger.size;i++)
	{
		trigger[i] thread FixBar();
	}
}

FixBar()
{
	bars = StrTok( self.script_label, " " );
	
	max = 100;
	
	brushmodel = [];
	for(i=0;i<bars.size;i++)
	{
		if(bars[i] == "destroy1" || bars[i] == "destroy2" || bars[i] == "destroy3" || bars[i] == "destroy4")
			max = 60;

		brushmodel[i] = getent(bars[i], "targetname");
	}

	while(1)
	{
		self waittill("trigger", player);

		found = false;

		for(i=0;i<brushmodel.size;i++)
		{
			if(brushmodel[i].height < max && !found && player.pers["team"] == "allies")
			{
				if(brushmodel[i].height == 0)
					time = 4;
				else
					time = (max-brushmodel[i].height)/max*4;
				
				if(!isDefined(time) || time <= 0)
					time = 4;

				trig = getDestroyTrigFromModel(bars[i]);
				trig linkto(brushmodel[i]);
				brushmodel[i] MoveTo((brushmodel[i].origin[0], brushmodel[i].origin[1], brushmodel[i].startheight), time);
				brushmodel[i] waittill("movedone");
				trig unlink();
				brushmodel[i].height = max;
				player iprintln("^1You fixed one bar^7. ^1Good job^7.");
				found = true;
			}
		}

		wait(0.05);
	}
}

getDestroyTrigFromModel(modeltarget)
{
	trigger = getentarray("trig_destroy", "targetname");

	trig = undefined;

	for(i=0;i<trigger.size;i++)
	{
		if(trigger[i].target == modeltarget)
		{
			trig = trigger[i];
			break;
		}
	}

	return trig;
}

DestroyBar()
{
	brushmodel = getent(self.target, "targetname");
	brushmodel.height = 100;

	if(self.target == "destroy1" || self.target == "destroy2" || self.target == "destroy3" || self.target == "destroy4")
		brushmodel.height = 60;

	max = brushmodel.height;

	brushmodel.startheight = brushmodel.origin[2];

	while(1)
	{
		self waittill("damage", dmg, player);

		if(dmg >= 10 && brushmodel.height > 0 && player.pers["team"] == "axis")
		{
			if(brushmodel.height >= 30 && max == 100)
				height = 50;
			else if(brushmodel.height >= 20 && max == 60)
				height = 30;
			else
				height = brushmodel.height;
		
			self linkto(brushmodel);
			brushmodel MoveZ(height * -1, 1);
			brushmodel waittill("movedone");
			self unlink();
			brushmodel.height -= height;

			if(brushmodel.height == 0)
			{
				player iprintln("^1You destroyed one bar^7. ^1Good job^7.");
			}
		}

		wait(0.05);
	}
}