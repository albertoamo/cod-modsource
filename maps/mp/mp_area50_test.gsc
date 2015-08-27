main()
{
maps\mp\_load::main();
maps\mp\mp_area50_test_teleportenter::main();
maps\mp\mp_area50_test_damage_control::main();

thread liftpad_slider();
thread liftpad_bonuss();
thread liftpad_bonusss();
thread liftpad_bonussss();
thread liftpad_wait();
thread liftpad_wait10();
thread liftpad_wait9();
thread liftpad_wait8();
thread liftpad_wait7();
thread liftpad_wait6();
thread liftpad_wait5();
thread liftpad_wait4();
thread liftpad_wait3();
thread liftpad_wait2();
thread liftpad_wait1();
thread liftpad_waitgo();
thread liftpad_push();
thread liftpad_minebox();
thread liftpad_plate();
thread forward(100);
thread OutMapFix();
thread OutMapFix2();
thread OutMapFix3();
thread OutMapFix4();

ambientPlay("ambient_mp_area50");
setCullFog (0, 3500, .32, .36, .40, 0);

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
}

OutMapFix4()
{	
	volume = [];
	volume[0] = -2570; // min (x)
	volume[1] = 2511; // min (y)
	volume[2] = 16; // min  (z)
	volume[3] = 2877; // max  (x)
	volume[4] = 2970; // max  (y)
	volume[5] = 250; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(player) && isPlayer(player))
		{
			if(isDefined(player.debugmode))
			{
				player iprintln("Out Map trigger");
			}
		}

		if(isPlayer(player) && player.pers["team"] == "allies")
		{
			player DoRespawn();
		}

		wait(0.05);
	}
}

DoRespawn()
{
	spawnpointname = "mp_tdm_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = self maps\mp\gametypes\_spawnlogic::getSpawnpoint_MiddleThird(spawnpoints);
      	self setorigin(spawnpoint.origin);
	self SetPlayerAngles(spawnpoint.angles);
}

OutMapFix3()
{	
	volume = [];
	volume[0] = -2940; // min (x)
	volume[1] = -2456; // min (y)
	volume[2] = 16; // min  (z)
	volume[3] = -2575; // max  (x)
	volume[4] = 2876; // max  (y)
	volume[5] = 250; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(player) && isPlayer(player))
		{
			if(isDefined(player.debugmode))
			{
				player iprintln("Out Map trigger");
			}
		}

		if(isPlayer(player) && player.pers["team"] == "allies")
		{
			player DoRespawn();
		}

		wait(0.05);
	}
}

OutMapFix2()
{	
	volume = [];
	volume[0] = -2942; // min (x)
	volume[1] = -2922; // min (y)
	volume[2] = 16; // min  (z)
	volume[3] = 2896; // max  (x)
	volume[4] = -2656; // max  (y)
	volume[5] = 250; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(player) && isPlayer(player))
		{
			if(isDefined(player.debugmode))
			{
				player iprintln("Out Map trigger");
			}
		}

		if(isPlayer(player) && player.pers["team"] == "allies")
		{
			player DoRespawn();
		}

		wait(0.05);
	}
}

OutMapFix()
{	
	volume = [];
	volume[0] = 2562; // min (x)
	volume[1] = -2641; // min (y)
	volume[2] = 16; // min  (z)
	volume[3] = 2896; // max  (x)
	volume[4] = 2576; // max  (y)
	volume[5] = 250; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(player) && isPlayer(player))
		{
			if(isDefined(player.debugmode))
			{
				player iprintln("Out Map trigger");
			}
		}

		if(isPlayer(player) && player.pers["team"] == "allies")
		{
			player DoRespawn();
		}

		wait(0.05);
	}
}

forward(dmg)
{	
	volume = [];
	volume[0] = -1388; // min (x)
	volume[1] = 150; // min (y)
	volume[2] = -659; // min  (z)
	volume[3] = -1107; // max  (x)
	volume[4] = 230; // max  (y)
	volume[5] = -559; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(player) && isPlayer(player))
		{
			if(isDefined(player.debugmode))
			{
				player iprintln("Forward trigger");
			}
		}

		player.health += dmg;
		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(player GetPlayerAngles() + (0,0,120)), 1000), "none", 0 );

		wait(0.05);
	}
}

liftpad_slider()
{
	liftpad=getent("simpson","targetname");
	trig=getent("elevator","targetname");

	while(1)
	{
		trig waittill ("trigger");
		liftpad movez (-239,10,0,1);
		liftpad waittill ("movedone");
		wait (5);
		trig waittill ("trigger");
		liftpad movez(239,10,0,1);
		liftpad waittill ("movedone");
		wait (3);
	}
}

liftpad_bonuss()
{
	liftpad=getent("bonuss","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		liftpad movez (1920,2.5,0,1);
		liftpad waittill ("movedone");
		wait (2);
		liftpad movez(-1920,15.5,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_bonusss()
{
	liftpad=getent("bonusss","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (3);
		liftpad movey (1648,2.5,0,1);
		liftpad waittill ("movedone");
		wait (1);
		liftpad movey(-1648,10,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_bonussss()
{
	liftpad=getent("bonussss","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (3);
		liftpad movey (1648,2.5,0,1);
		liftpad waittill ("movedone");
		wait (6);
		liftpad movey(-1648,0.5,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait()
{
	liftpad=getent("wait","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		liftpad movex (16,1,0,0.5);
		liftpad waittill ("movedone");
		wait (8);
		liftpad movex(-16,1,0,0.5);
		liftpad waittill ("movedone");
	}
}

liftpad_wait10()
{
	liftpad=getent("wait10","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (10);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait9()
{
	liftpad=getent("wait9","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (11);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait8()
{
	liftpad=getent("wait8","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (12);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait7()
{
	liftpad=getent("wait7","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (13);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait6()
{
	liftpad=getent("wait6","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (14);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait5()
{
	liftpad=getent("wait5","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (15);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait4()
{
	liftpad=getent("wait4","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (16);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait3()
{
	liftpad=getent("wait3","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (17);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait2()
{
	liftpad=getent("wait2","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (18);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_wait1()
{
	liftpad=getent("wait1","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (19);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_waitgo()
{
	liftpad=getent("waitgo","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (20);
		liftpad movex (16,0.2,0,0.1);
		liftpad waittill ("movedone");
		wait (0.6);
		liftpad movex(-16,0.2,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_push()
{
	liftpad=getent("push","targetname");
	trig=getent("elevatorr","targetname");

	while(1)
	{
		trig waittill ("trigger");
		wait (0.5);
		liftpad movex (144,1,0,0.1);
		liftpad waittill ("movedone");
		wait (20);
		liftpad movex(-144,1,0,0.1);
		liftpad waittill ("movedone");
	}
}

liftpad_minebox()
	{
	liftpad=getent("minebox","targetname");
	while(1)
	{
	liftpad movey (116,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (124,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (-232,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (-248,5,0,1);
	liftpad waittill ("movedone");
	liftpad movey (116,5,0,1);
	liftpad waittill ("movedone");
	liftpad movex (124,5,0,1);
	liftpad waittill ("movedone");
	}
	}

liftpad_plate()
{
	liftpad=getent("plate","targetname");
	liftpad2=getent("plate2","targetname");
	trig=getent("platee","targetname");

	plate = [];
	plate[1] = -1;
	plate[2] = -1;
	plate[3] = 1;
	plate[4] = 1;

	plate2 = [];
	plate2[1] = 1;
	plate2[2] = 1;
	plate2[3] = -1;
	plate2[4] = -1;

	step = 1;

	while(1)
	{
		trig waittill ("trigger");

		liftpad thread move_plate(step, plate[step]);
		liftpad2 thread move_plate(step, plate2[step]);

		wait(0.05);

		while(isDefined(liftpad.ismoving) || isDefined(liftpad2.ismoving))
			wait(0.05);

		step++;
		
		if(step > 4)
			step = 1;
	}
}

move_plate(step, value)
{
	self.ismoving = true;

	height = 600;
	y = 4128;
	x = 4672;

	wait (5);
	self movez (height,3,1,1);
	self waittill("movedone");
	wait (0.5);

	if(step == 1)
	{
		self movey (value * y,10,0,5);
		self waittill("movedone");
	}
	else if(step == 2)
	{
		self movex (value * x,10,0,5);
		self waittill("movedone");
	}
	else if(step == 3)
	{
		self movey (value * y,10,0,5);
		self waittill("movedone");
	}
	else
	{
		self movex (value * x,10,0,5);
		self waittill("movedone");
	}

	wait (0.5);
	self movez (-1 * height,3,1,1);
	self waittill ("movedone");

	self.ismoving = undefined;
}