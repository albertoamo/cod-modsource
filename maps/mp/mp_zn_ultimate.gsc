// Scripted By Mitch
main()
{
	maps\mp\_load::main();
	maps\mp\mp_zn_ultimate_passage::main();
	maps\mp\mp_zn_ultimate_jeep::main();
	maps\mp\mp_zn_ultimate_flangun::main();

	setExpFog(0.0001, 0.55, 0.6, 0.55, 2);
	ambientPlay("ambient_france");

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";

	setCvar("r_glowbloomintensity0", ".25");
	setCvar("r_glowbloomintensity1", ".25");
	setcvar("r_glowskybleedintensity0",".3");

	thread ExitRoom();
	thread SecretRoom();
	thread Teleport();
	thread SecretRoomFix();
	origin = (19, 127, 608);
	thread JeepArenaFix1(origin);
	thread JeepArenaFix2(origin);
	thread JeepArenaFix3(origin);
	thread JeepArenaFix4(origin);
	thread JeepArenaFix5(origin);
}

JeepArenaFix1(origin)
{
	volume = [];
	volume[0] = 698; // min (x)
	volume[1] = -1024; // min (y)
	volume[2] = 598; // min  (z)
	volume[3] = 1154; // max  (x)
	volume[4] = -578; // max  (y)
	volume[5] = 1342; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin(origin);
	}
}

JeepArenaFix2(origin)
{
	volume = [];
	volume[0] = -1154; // min (x)
	volume[1] = -1026; // min (y)
	volume[2] = 600; // min  (z)
	volume[3] = -698; // max  (x)
	volume[4] = -574; // max  (y)
	volume[5] = 1342; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin(origin);
	}
}

JeepArenaFix3(origin)
{
	volume = [];
	volume[0] = -962; // min (x)
	volume[1] = 384; // min (y)
	volume[2] = 642; // min  (z)
	volume[3] = -698; // max  (x)
	volume[4] = 1060; // max  (y)
	volume[5] = 1342; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin(origin);
	}
}

JeepArenaFix4(origin)
{
	volume = [];
	volume[0] = 698; // min (x)
	volume[1] = 448; // min (y)
	volume[2] = 644; // min  (z)
	volume[3] = 898; // max  (x)
	volume[4] = 1060; // max  (y)
	volume[5] = 1342; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin(origin);
	}
}

JeepArenaFix5(origin)
{
	volume = [];
	volume[0] = -1428; // min (x)
	volume[1] = -3368; // min (y)
	volume[2] = -68; // min  (z)
	volume[3] = 1566; // max  (x)
	volume[4] = 1416; // max  (y)
	volume[5] = -50; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin(origin);
	}
}

SecretRoomFix()
{
	volume = [];
	volume[0] = -112; // min (x)
	volume[1] = -3099; // min (y)
	volume[2] = 122; // min  (z)
	volume[3] = 112; // max  (x)
	volume[4] = -3036; // max  (y)
	volume[5] = 200; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(level.secretroomisblocked))
		{
			player maps\mp\gametypes\_callbacksetup::CodeCallback_PlayerDamage(trigger, trigger, 10, 0, "MOD_TRIGGER_HURT", "none", player.origin, (0,0,0), "none", 0);	
		}

		wait(0.25);
	}
}

SecretRoom()
{
	one = getent("trig_secret1", "targetname");
	two = getent("trig_secret2", "targetname");
	door = getent("secretdoor", "targetname");

	while(1)
	{
		one waittill("damage", dmg, user);

		if(dmg > 30)
		{
			two waittill("damage", dmg, player);

			if(dmg > 30 && isPlayer(user) && player == user)
			{
				iprintln(player.name + " ^1Has Found A Secret Room...");
	
				door moveZ(-197, 3);
				door waittill("movedone");

				wait(3);

				door thread moveObject(197, 3);

				wait(3);

				while(isDefined(door.ismoving))
				{
					level.secretroomisblocked = true;
					wait(0.05);
				}

				level.secretroomisblocked = undefined;

				wait(1);
			}
		}
	}
}

moveObject(dist, time)
{
	self.ismoving = true;
	self moveZ(dist, time);
	self waittill("movedone");
	self.ismoving = undefined;
}

ExitRoom()
{
	trig = getent("trig_exit", "targetname");
	
	while(1)
	{
		trig waittill("trigger", user);
		
		user setOrigin((0,-2948,84));

		wait(0.05);
	}
}

Teleport()
{
	one = getent("trig_target1", "targetname");
	two = getent("trig_target2", "targetname");
	three = getent("trig_target3", "targetname");

	while(1)
	{
		one waittill("trigger", p1);

		if(isDefined(p1) && isPlayer(p1))
		{
			if(isDefined(p1.debugmode))
				p1 iprintln("Trigger One");
		}
		
		if(isPlayer(p1) && p1 UseButtonPressed())
		{
			if(isDefined(p1) && isPlayer(p1))
			{
				if(isDefined(p1.debugmode))
					p1 iprintln("Trigger One Done");
			}

			two waittill("trigger", p2);

			if(isDefined(p2) && isPlayer(p2))
			{
				if(isDefined(p2.debugmode))
					p2 iprintln("Trigger Two");
			}

			if(isPlayer(p1) && p1 == p2 && p2 UseButtonPressed())
			{
				if(isDefined(p2) && isPlayer(p2))
				{
					if(isDefined(p2.debugmode))
						p2 iprintln("Trigger Two Done");
				}

				further = true;

				while(isDefined(further))
				{
					three waittill("trigger", p3);

					if(isDefined(p3) && isPlayer(p3))
					{
						if(isDefined(p3.debugmode))
							p3 iprintln("Trigger Three");
					}
			
					if(isPlayer(p2) && p2 == p3 && p3 UseButtonPressed())
					{
						p3 iprintlnbold("^1Welcome^4, " + p3.name);
				
						wait(1);

						p3 setOrigin((0, 1226, 869));
						p3 setPlayerAngles((23, 270, 0));
					}
					else if(!isPlayer(p2) || (isPlayer(p2) && p2 != p3))
						further = undefined;
				}
			}
		}
	}
}