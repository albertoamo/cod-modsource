main()
{
	maps\mp\_load::main();
	maps\mp\mp_zn_arena_sweeper::main();	
	maps\mp\mp_zn_arena_teleportenter::main();
	thread getDoors();
	thread getGears();
	thread Name();
	thread Trap();
	thread Secret();
	thread Room();
	thread getBars();
	thread getTriggerDoors();
	thread WeaponOnWall();
}

WeaponOnWall()
{
	wep = getent("p90_wep", "targetname");
	model = getent("p90_origin", "targetname");
	wep linkto(model);
	wep.count = 999;
	wep.origin = model.origin;
}

getTriggerDoors()
{
	doors = getentarray("trig_movedoor", "targetname");

	for(i=0;i<doors.size;i++)
		doors[i] thread moveDoor2();
}

moveDoor2()
{
	object = getent(self.target, "targetname");

	hurt = getent(object.target, "targetname");
	hurt enableLinkTo();
	hurt linkto(object);

	while(1)
	{
		self waittill("trigger", user);

		if(user UseButtonPressed())
		{
			object moveY(120 * int(object.script_label), 2, 0.5, 0.5);
			object waittill("movedone");

			wait(5);

			object moveY(-120 * int(object.script_label), 2, 0.5, 0.5);
			object waittill("movedone");

			wait(0.75);
		}
	}
}

getBars()
{
	bars = getentarray("object_security_red", "targetname");

	for(i=0;i<bars.size;i++)
		bars[i] thread moveBar();	
}

moveBar()
{
	trig = getent(self.target, "targetname");
	trig enableLinkTo();
	trig linkto(self);
	trig thread triggerBar(self);
	self notsolid();

	wait(self.delay);

	while(1)
	{
		self moveZ(80, 1, 0.2, 0.2);
		self waittill("movedone");

		self moveZ(-80, 1, 0.2, 0.2);
		self waittill("movedone");
	}
}

triggerBar(obj)
{
	while(1)
	{
		self waittill("trigger", user);
		user thread [[level.callbackPlayerDamage]](user, user, 5, 0, "MOD_GRENADE_SPLASH", "none", user.origin, vectornormalize(user.origin - obj.origin), "none", 0);
		wait(0.05);
	}
}


Room()
{
	trig = getent("trig_open_sdoor", "targetname");
	one = getent(trig.target, "targetname");
	two = getent(one.target, "targetname");

	while(1)
	{
		trig waittill("trigger", user);

		one thread moveDoor(155, 2, 0.5, 0.5);
		two moveDoor(-155, 2, 0.5, 0.5);

		while(isDefined(one.ismoving))
			wait(0.05);

		wait(1);
	}
}

moveDoor(dist, time, ac, de)
{
	self.ismoving = true;
	self moveX(dist, time, ac, de);
	self waittill("movedone");

	wait(5);

	self moveX(-1 * dist, time, ac, de);
	self waittill("movedone");

	self.ismoving = undefined;
}

Secret()
{
	trig = getent("trig_room", "targetname");
	object = getent(trig.target, "targetname");
	
	trig enableLinkTo();
	trig linkto(object);

	while(1)
	{
		trig waittill("trigger", user);

		if(user UseButtonPressed())
		{
			object moveY(-128, 1.5, 0.5, 0.5);
			object waittill("movedone");

			active = true;
			while(active)
			{
				trig waittill("trigger", user);

				if(user UseButtonPressed())
				{
					object moveY(128, 1.5, 0.5, 0.5);
					object waittill("movedone");
					active = false;
				}
			}
		}
	}
}

Trap()
{
	activator = getent("trig_trap_activate", "targetname");
	object = getent("object_trap", "targetname");
	trig = getent(object.target, "targetname");
	roof = getent("object_trap_top", "targetname");

	trig enableLinkTo();
	trig linkto(object);

	object moveZ(28, 0.1);
	object waittill("movedone");

	while(1)
	{
		activator waittill("trigger", user);
		object moveZ(-28, 0.5);
		object waittill("movedone");
		object linkto(roof);
		roof moveZ(-100, 2.25);
		roof waittill("movedone");
		wait(5);
		roof moveZ(100, 3);
		roof waittill("movedone");
		object unlink();
		object moveZ(28, 0.5);
		object waittill("movedone");
		wait(15);
	}
}

Name()
{
	trig = getent("trigger_name", "targetname");
	object = getent(trig.target, "targetname");

	trig enableLinkto();
	trig linkto(object);

	while(1)
	{
		trig waittill("trigger", user);

		object rotateRoll(45, 0.5);
		object waittill("rotatedone");
	}
}

getGears()
{
	gears = getentarray("object_gears", "targetname");

	level.totalgearsup = gears.size;

	for(i=0;i<gears.size;i++)
		gears[i] thread rotateGear(gears.size);
}

rotateGear(gears)
{
	speed = 1;
	
	if(isDefined(self.script_speed))
		speed = self.script_speed;

	while(1)
	{
		currenttime = GetTime();
		level.totalgearsup--;
		self rotatePitch(speed * 360, 1);
		self waittill("rotatedone");

		level.totalgearsup++;
		
		if(level.totalgearsup != gears)
			level waittill("allgearsareup");
		else
		{
			if( GetTime() >= currenttime + 2000 )
				wait(5);

			level notify("allgearsareup");
		}	
	}
}

getDoors()
{
	doors = getentarray("object_doors", "targetname");

	level.totaldoorsup = doors.size;

	for(i=0;i<doors.size;i++)
		doors[i] thread movementDoor(doors.size);
}

movementDoor(totaldoors)
{
	hurt = getent(self.target, "targetname");
	hurt enableLinkTo();
	hurt linkto(self);
	
	while(1)
	{
		level.totaldoorsup--;
		wait(self.delay * 0.4);
		self moveZ(-128, 1, 0.5, 0.05);
		self waittill("movedone");

		wait(5);

		level.totaldoorsup++;
		
		if(level.totaldoorsup != totaldoors)
			level waittill("alldoorsareup");
		else
			level notify("alldoorsareup");
		
		self moveZ(128, 2, 0.3, 0.5);
		self waittill("movedone");

		wait(10);
	}
}