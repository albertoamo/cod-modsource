init()
{
	precacheShader("white");
	precacheShader("hudStopwatch");
	level._effect["bombexplosion"] = loadfx("fx/props/barrelexp.efx");

	thread GetAllDoors();
	thread GetAllVensters();
	thread plantTNT();
}

GetAllDoors()
{
	trigger = getentarray("trig_door", "targetname");
	rand = RandomIntRange(1,3);

	for(i=0;i<trigger.size;i++)
	{
		if(isDefined(trigger[i].script_team) && trigger[i].script_team == "broken") 
			trigger[i] thread BrokenTrigger();
		//else if(isDefined(trigger[i].script_team) && trigger[i].script_team == "door_" + rand) 
			//trigger[i] thread BrokenTrigger();
		else if(isDefined(trigger[i].script_team) && trigger[i].script_team == "open") 
			trigger[i] thread GetTrigger( true );
		else 
			trigger[i] thread GetTrigger( undefined );
	}

	trigger = getentarray("trig_door_special", "targetname");

	for(i=0;i<trigger.size;i++)
	{
		trigger[i] thread GetTriggerSpecial();
	}
}

BrokenTrigger()
{
	while(1)
	{
		self waittill("trigger", player);
		
		player iprintlnbold("Sorry, but this door is broken^4.");

		wait(2);
	}
}

GetTriggerSpecial()
{
	one = getent(self.target, "targetname");

	while(1)
	{
		self waittill("trigger", player);

		completed = undefined;
		nodelay = self.script_team;

		if(!isDefined(nodelay) && !isDefined(one.isopening))
		{
			completed = player ProgressBar(self);
		}
	
		if( (isDefined(nodelay) || isDefined(completed) ) && !isDefined(one.isopening) )
		{
			one.isopening = true;
			one MoveDoorSpecial();

			wait(3);
			one.isopening = undefined;
		}
	}
}

GetTrigger( open )
{
	one = getent(self.target, "targetname");
	two = getent(self.script_label, "targetname");

	if(isDefined(open))
	{
		dir = one.script_label;

		if(dir == "x") one MoveX(110, 0.1);
		if(dir == "-x") one MoveX(-110, 0.1);
		if(dir == "y") one MoveY(110, 0.1);
		if(dir == "-y") one MoveY(-110, 0.1);

		one waittill("movedone");

		dir = two.script_label;

		if(dir == "x") two MoveX(110, 0.1);
		if(dir == "-x") two MoveX(-110, 0.1);
		if(dir == "y") two MoveY(110, 0.1);
		if(dir == "-y") two MoveY(-110, 0.1);

		two waittill("movedone");

		return;
	}
	

	while(1)
	{
		self waittill("trigger", player);

		completed = undefined;
		nodelay = self.script_team;

		if(isDefined(open)) nodelay = undefined;

		if(isDefined(nodelay) && nodelay == "door_1" || isDefined(nodelay) && nodelay == "door_2")
			nodelay = undefined;

		if(!isDefined(nodelay) && !isDefined(one.isopening))
		{
			completed = player ProgressBar(self);
		}
	
		if( (isDefined(nodelay) || isDefined(completed) ) && !isDefined(one.isopening) )
		{
			one.isopening = true;
			one thread MoveDoor();
			two thread MoveDoor();

			one waittill("moved_door");

			wait(3);

			if(isDefined(two.ismoving))
				two waittill("moved_door");

			one.isopening = undefined;
		}
	}
}

MoveDoor()
{
	self.ismoving = true;
	dir = self.script_label;

	if(dir == "x") self MoveX(110, 3);
	if(dir == "-x") self MoveX(-110, 3);
	if(dir == "y") self MoveY(110, 3);
	if(dir == "-y") self MoveY(-110, 3);

	self waittill("movedone");
	
	wait(7);

	if(dir == "x") self MoveX(-110, 3);
	if(dir == "-x") self MoveX(110, 3);
	if(dir == "y") self MoveY(-110, 3);
	if(dir == "-y") self MoveY(110, 3);

	self waittill("movedone");
	self notify("moved_door");
	self.ismoving = undefined;
}

MoveDoorSpecial()
{
	dir = self.script_label;

	if(dir == "x") self MoveX(220, 6);
	if(dir == "-x") self MoveX(-220, 6);
	if(dir == "y") self MoveY(220, 6);
	if(dir == "-y") self MoveY(-220, 6);

	self waittill("movedone");
	
	wait(7);

	if(dir == "x") self MoveX(-220, 6);
	if(dir == "-x") self MoveX(220, 6);
	if(dir == "y") self MoveY(-220, 6);
	if(dir == "-y") self MoveY(220, 6);

	self waittill("movedone");
}

ProgressBar( trigger )
{
	planttime = 1.8;
	barsize = 192;

	self clientclaimtrigger(trigger);

	if(!isdefined(self.progressbackground))
	{
		self.progressbackground = newClientHudElem(self);
		self.progressbackground.x = 0;
		self.progressbackground.y = 104;
		self.progressbackground.alignX = "center";
		self.progressbackground.alignY = "middle";
		self.progressbackground.horzAlign = "center_safearea";
		self.progressbackground.vertAlign = "center_safearea";
		self.progressbackground.alpha = 0.5;
	}

	self.progressbackground setShader("black", (barsize + 4), 12);

	if(!isdefined(self.progressbar))
	{
		self.progressbar = newClientHudElem(self);
		self.progressbar.x = int(barsize / (-2.0));
		self.progressbar.y = 104;
		self.progressbar.alignX = "left";
		self.progressbar.alignY = "middle";
		self.progressbar.horzAlign = "center_safearea";
		self.progressbar.vertAlign = "center_safearea";
	}

	self.progressbar setShader("white", 0, 8);
	self.progressbar scaleOverTime(planttime, barsize, 8);

	//self playsound("MP_bomb_plant");
	self linkTo(trigger);
	self disableWeapon();

	progresstime = 0;
	while(isAlive(self) && self useButtonPressed() && (progresstime < planttime))
	{
		progresstime += 0.05;
		wait 0.05;
	}

	self clientreleasetrigger(trigger);

	if(progresstime >= planttime)
	{
		self.progressbackground destroy();
		self.progressbar destroy();
		self unlink();
		self enableWeapon();

		return true;
	}
	else
	{
		if(isdefined(self.progressbackground))
			self.progressbackground destroy();

		if(isdefined(self.progressbar))
			self.progressbar destroy();

		self unlink();
		self enableWeapon();

	}

	return undefined;
}

GetAllVensters()
{
	venster = getentarray("trig_venster", "targetname");

	for(i=0;i<venster.size;i++)
	{
		venster[i] thread WaitForDamage();
	}

}

WaitForDamage()
{
	totaldmg = 0;
	object = getent(self.target, "targetname");
	
	while(1)
	{
		self waittill("damage", dmg);

		totaldmg += dmg;

		if(totaldmg > 300)
		{
			object hide();
			object notsolid();
			
			break;
		}

	}
}

plantTNT()
{
	tnt = getent("tnt_object", "targetname");
	trig = getent("trig_tnt_plant", "targetname");
	wall = getent("tnt_wall", "targetname");

	tnt hide();

	while(1)
	{
		trig waittill("trigger", player);

		completed = player ProgressBar(trig);

		if(isDefined(completed))
		{
			trig delete();	
			tnt show();
			origin = tnt getOrigin();
			player playLocalSound("US_mp_explosivesplanted");
			tnt playLoopSound("bomb_tick");

			player iprintlnbold("Take cover^4!");

			bombtimer = NewTeamHudElem("allies");
			bombtimer.x = 6;
			bombtimer.y = 76;
			bombtimer.horzAlign = "left";
			bombtimer.vertAlign = "top";
			bombtimer setClock(15, 15, "hudStopwatch", 48, 48);

			wait(15);

			tnt stopLoopSound("bomb_tick");
			bombtimer Destroy();
			tnt hide();

			playfx(level._effect["bombexplosion"], origin);
			thread PlaySoundAtLocation("explo_metal_rand", origin, 5);
			RadiusDamage( origin - (0,0,10), 500, 2000, 1000 );
			wall hide();
			wall notsolid();
			break;
		}
	}
}

PlaySoundAtLocation(sound, location, iTime)
{
	org = spawn("script_model", location);
	wait 0.05;
	org show();
	org playSound(sound);
	wait iTime;
	org delete();

	return;
}