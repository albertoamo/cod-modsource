main()
{
	thread passage1();
	thread passage2();
	thread passage3();
	thread passage4();
	thread passage5();
	thread passage6();
	thread passage1Fix();
	thread passage2Fix();
}

moveObject(dist, time)
{
	self.ismoving = true;
	self moveY(dist, time);
	self waittill("movedone");
	self.ismoving = undefined;
}


passage1Fix()
{
	volume = [];
	volume[0] = 1010; // min (x)
	volume[1] = -650; // min (y)
	volume[2] = 4; // min  (z)
	volume[3] = 1094; // max  (x)
	volume[4] = -500; // max  (y)
	volume[5] = 168; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(level.passage1isblocked))
		{
			player maps\mp\gametypes\_callbacksetup::CodeCallback_PlayerDamage(trigger, trigger, 10, 0, "MOD_TRIGGER_HURT", "none", player.origin, (0,0,0), "none", 0);	
		}

		wait(0.25);
	}
}

passage2Fix()
{
	volume = [];
	volume[0] = 1010; // min (x)
	volume[1] = -206; // min (y)
	volume[2] = 300; // min  (z)
	volume[3] = 1094; // max  (x)
	volume[4] = -123; // max  (y)
	volume[5] = 468; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(level.passage2isblocked))
		{
			player maps\mp\gametypes\_callbacksetup::CodeCallback_PlayerDamage(trigger, trigger, 10, 0, "MOD_TRIGGER_HURT", "none", player.origin, (0,0,0), "none", 0);	
		}

		wait(0.25);
	}
}

passage1()
{
	trig = getent("trig_passage1", "targetname");
	door = getent("passage1", "targetname");
	
	while(1)
	{
		trig waittill("trigger", user);
	
		if(user UseButtonPressed())
		{
			door MoveX(4, 1);
			door waittill("movedone");
			
			wait(0.15);

			door MoveY(122, 2);
			door waittill("movedone");

			wait(2);

			door thread moveObject(-122, 2);

			wait(2);

			while(isDefined(door.ismoving))
			{
				level.passage1isblocked = true;
				wait(0.05);
			}
			
			level.passage1isblocked = undefined;

			wait(0.15);

			door MoveX(-4, 1);
			door waittill("movedone");

			wait(0.5);
		}

		wait(0.05);
	}
}

passage2()
{
	trig = getent("trig_passage2", "targetname");
	door = getent("passage2", "targetname");
	
	while(1)
	{
		trig waittill("trigger", user);
	
		if(user UseButtonPressed())
		{
			door MoveX(4, 1);
			door waittill("movedone");
			
			wait(0.15);

			door MoveY(122, 2);
			door waittill("movedone");

			wait(2);

			door thread moveObject(-122, 2);

			wait(2);

			while(isDefined(door.ismoving))
			{
				level.passage2isblocked = true;
				wait(0.05);
			}
			
			level.passage2isblocked = undefined;

			wait(0.15);

			door MoveX(-4, 1);
			door waittill("movedone");

			wait(0.5);
		}

		wait(0.05);
	}
}

passage3()
{
	trig = getent("trig_passage3", "targetname");
	door = getent("passage3", "targetname");
	
	while(1)
	{
		trig waittill("trigger", user);
	
		if(user UseButtonPressed())
		{
			door MoveY(170, 3);
			door waittill("movedone");

			wait(2);

			door MoveY(-170, 3);
			door waittill("movedone");

			wait(0.5);
		}

		wait(0.05);
	}
}

passage4()
{
	trig = getent("trig_passage4", "targetname");
	door = getent("passage4", "targetname");
	
	while(1)
	{
		trig waittill("trigger", user);
	
		if(user UseButtonPressed())
		{
			door MoveY(170, 3);
			door waittill("movedone");

			wait(2);

			door MoveY(-170, 3);
			door waittill("movedone");

			wait(0.5);
		}

		wait(0.05);
	}
}

passage5()
{
	trig = getent("trig_passage5", "targetname");
	door = getent("passage5", "targetname");
	
	while(1)
	{
		trig waittill("trigger", user);
	
		if(user UseButtonPressed())
		{
			door MoveY(186, 3.5);
			door waittill("movedone");

			wait(2);

			door MoveY(-186, 3.5);
			door waittill("movedone");

			wait(0.5);
		}

		wait(0.05);
	}
}

passage6()
{
	trig = getent("trig_passage6", "targetname");
	door = getent("passage6", "targetname");
	
	while(1)
	{
		trig waittill("trigger", user);
	
		if(user UseButtonPressed())
		{
			door MoveX(-4, 1);
			door waittill("movedone");
			
			wait(0.15);

			door MoveY(-122, 2);
			door waittill("movedone");

			wait(2);

			door MoveY(122, 2);
			door waittill("movedone");

			wait(0.15);

			door MoveX(4, 1);
			door waittill("movedone");

			wait(0.5);
		}

		wait(0.05);
	}
}