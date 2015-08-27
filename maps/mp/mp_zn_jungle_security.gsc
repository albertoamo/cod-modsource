main()
{
	thread precache();
	thread SecurityPanel();
	thread GetAllSecurityTriggers();
}

precache()
{
	game["alarmpanel"] = "m_alarm_panel";
	precacheShader(game["alarmpanel"]);
	game["alarmON"] = &"^2On";
	precacheString(game["alarmON"]);
	game["alarmOff"] = &"^1Off";
	precacheString(game["alarmOff"]);
}

SecurityPanel()
{
	trig = getent("trig_security", "targetname");
	object = getent("security_red_object", "targetname");

	while(1)
	{
		trig waittill("trigger", user);

		user OpenSecurityPanel( trig, object );
	}	
}


GetAllSecurityTriggers()
{
	trig = getentarray("security_red", "targetname");
	object = getent("security_red_object", "targetname");
	level.securitysystem = true;
	object notsolid();

	for(i=0;i<trig.size;i++)
		trig[i] thread MonitorSecurityTrig();
}

MonitorSecurityTrig()
{
	while(1)
	{
		self waittill("trigger", user);

		if(user istouching(self) && level.securitysystem)
			user suicide();
	}
}

OpenSecurityPanel( trig, object )
{
	self endon("killed_player");

	if(!isDefined(self.alarmcp)) 
	{
		self.alarmcp = newClientHudElem(self);
		self.alarmcp.horzAlign = "left";
		self.alarmcp.vertAlign = "top";
		self.alarmcp.x = 50;
		self.alarmcp.y = 80;
		self.alarmcp.archived = false;
		self.alarmcp setshader(game["alarmpanel"],150,150);
	}

	if(!isDefined(self.alarmcpc))
	{
		self.alarmcpc = newClientHudElem(self);
		self.alarmcpc.horzAlign = "left";
		self.alarmcpc.vertAlign = "top";
		self.alarmcpc.x = 106;
		self.alarmcpc.y = 197;
		self.alarmcpc.font = "default";
		self.alarmcpc.fontscale = 2;
		self.alarmcpc.archived = false;
	}

	if(level.securitysystem)
	{
		self.alarmcpc setText( game["alarmON"] );
		object show();
	}
	else
	{
		self.alarmcpc setText( game["alarmOff"] );
		object hide();
	}

	self thread UpdateStatus( trig, object );

	while(self istouching(trig))
		wait(0.05);

	self notify("end_alarmcp");

	if(isDefined(self.alarmcp)) self.alarmcp Destroy();
	if(isDefined(self.alarmcpc)) self.alarmcpc Destroy();
}

UpdateStatus( trig, object )
{
	self endon("end_alarmcp");

	while(1)
	{
		trig waittill("trigger");

		level notify("using_securitypanel");

		if(self istouching(trig))
		{
			if(level.securitysystem)
			{
				self.alarmcpc setText( game["alarmOff"] );
				object hide();
				level.securitysystem = false;
				self thread EnableLasersAuto( object );
			}
			else
			{
				self.alarmcpc setText( game["alarmON"] );
				object show();
				level.securitysystem = true;
			}
			
		}
	}
}

EnableLasersAuto( object )
{
	level endon("using_securitypanel");

	wait(30);
	
	if(!level.securitysystem)
	{
		if(isDefined(self.alarmcpc)) self.alarmcpc setText( game["alarmON"] );
		object show();
		level.securitysystem = true;
	}

}