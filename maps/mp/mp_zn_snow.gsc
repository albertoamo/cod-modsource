main()
{
	maps\mp\_load::main();

	thread Precache();
	thread Level2Door1();
	thread Level2Door2();
	thread LevelUp();
	thread LevelUpTime();
	thread SecretTrick();
	thread SecretOne();
	thread BackDoors();
	thread BackDoors2();
	thread lift();
	thread Protect();
	thread antiElevatorBlock();
	//thread Test();

	setExpFog(0.00006, 0.55, 0.55, 0.55, 0);
	//setCullFog(5000, 20000, 0.55, 0.55, 0.55, 0);

	game["allies"] = "american"; 
	game["axis"] = "german";

	setcvar("r_glowbloomintensity0","1");
	setcvar("r_glowbloomintensity1","1");
	setcvar("r_glowskybleedintensity0",".25");

	game["attackers"] = "allies";
	game["defenders"] = "axis";

	game["british_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";
}

Test()
{
	volume = [];
	volume[0] = -1900; // min (x)
	volume[1] = -1600; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = -1800; // max  (x)
	volume[4] = -1400; // max  (y)
	volume[5] = 64; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "use");
	trigger._color = (0,0,1);

	while(1)
	{
		trigger waittill("trigger", player);

		player iprintlnbold("Working");
	}
}

Precache()
{
	PreCacheItem("panzerschreck_mp");
}

Level2Door1()
{
	object = getent("object_lvl2_door1", "targetname");
	
	while(1)
	{
		object MoveY( 272, 2);
		object waittill("movedone");
		
		wait(10);

		object MoveY( -272, 2);
		object waittill("movedone");
	
		wait(10);
	}
}

Level2Door2()
{
	object = getent("object_lvl2_door2", "targetname");
	
	while(1)
	{
		object MoveY( -256, 2);
		object waittill("movedone");
		
		wait(10);

		object MoveY( 256, 2);
		object waittill("movedone");
	
		wait(10);		
	}
}

LevelUp()
{
	level.doorupisbusy = false;
	trig = getent("trig_level1_up", "targetname");
	object = getent("object_level1_up", "targetname");
	
	while(1)
	{
		trig waittill("trigger");

		if(level.doorupisbusy == false)
		{
			level.doorupisbusy = true;
			object MoveZ( 240, 2); // 248
			object waittill("movedone");

			wait(10);
			
			object MoveZ( -240, 2); // -248
			object waittill("movedone");

			level.doorupisbusy = false;
		}
	}
}

LevelUpTime()
{
	level.doorupisbusy = false;
	trig = getent("trig_level1_up", "targetname");
	object = getent("object_level1_up", "targetname");
	
	while(1)
	{
		wait(10);

		if(level.doorupisbusy == false)
		{
			level.doorupisbusy = true;
			object MoveZ( 248, 2);
			object waittill("movedone");

			wait(10);
			
			object MoveZ( -248, 2);
			object waittill("movedone");

			level.doorupisbusy = false;
		}
	}
}

SecretTrick()
{
	trig = getent("trig_lvl1_secret", "targetname");

	while(1)
	{
		trig waittill("trigger", user);
		
		if(!isDefined(user.usedthistrick) && user.pers["team"] == "allies")
		{
			user.usedthistrick = true;
			if ( RandomInt( 100 ) > 50 ) 
				user setWeaponSlotAmmo( "primary", 999 );
			if ( RandomInt( 100 ) > 50 ) 
				user setWeaponSlotClipAmmo( "primary", 999 );
			if ( RandomInt( 100 ) > 50 ) 
				user setWeaponSlotAmmo( "primaryb", 999 );
			if ( RandomInt( 100 ) > 50 ) 
				user setWeaponSlotClipAmmo( "primaryb", 999 );

			if ( RandomInt( 100 ) > 75 )
			{
				user iprintlnbold("You won a panzershreck^4!");
				// spawn panzerschreck
				wep = Spawn( "weapon_panzerschreck_mp", (-800, 1008, 200));
				wep setModel("xmodel/weapon_panzerschreck");
				wep.angles = (0, 270, 0);
			}
		}	

	}
}

SecretOne()
{
	bash = getent("trig_lvl1_secret_p2", "targetname");
	sbash = getent("trig_lvl1_secret_p1", "targetname");

	object = getent("object_lvl1_secret", "targetname");

	while(1)
	{ 
		bash waittill("damage", dmg, user);
		if(isPlayer(user))
		{
			if(dmg > 30 && user getweaponslotweapon("primary") == user getcurrentweapon())
			{
				sbash waittill("damage", dmg, user);

				if(isPlayer(user))
				{
					if(dmg > 30 && level.doorsystemisbusy == true && user getweaponslotweapon("primaryb") == user getcurrentweapon())
					{
						level.openedsecret = true; 
						object MoveZ( 246 , 2); // 248
						object waittill("movedone");

						wait(1);

						object MoveZ( -246 , 2); // 248
						object waittill("movedone");
						level.openedsecret = undefined;
					}
				}
			}
		}
	}
}

BackDoors()
{
	level.doorsystemisbusy = false;

	one = getent("object_lvl1_back1", "targetname");
	two = getent("object_lvl1_back2", "targetname");

	trig = getent("trig_lvl1_back1", "targetname");

	while(1)
	{
		trig waittill("trigger");
		
		if(level.doorsystemisbusy == false)
		{
			level.doorsystemisbusy = true;
			MoveAllBackDoors( one, two );
		}
	}
}

BackDoors2()
{
	level.doorsystemisbusy = false;

	one = getent("object_lvl1_back1", "targetname");
	two = getent("object_lvl1_back2", "targetname");

	one MoveY( 260, 0.1);
	one waittill("movedone");

	two MoveY( 260, 0.1);
	two waittill("movedone");

	trig = getent("trig_lvl1_back2", "targetname");

	while(1)
	{
		trig waittill("trigger");
		
		if(level.doorsystemisbusy == false)
		{
			level.doorsystemisbusy = true;
			MoveAllBackDoors( one, two );
		}
	}
}

MoveAllBackDoors( one, two )
{
	two LinkTo(one);
	
	one MoveY( -260, 2);
	one waittill("movedone");

	wait(10);

	while(isDefined(level.openedsecret) && getCvar("zn_snow_secretdoor") == "1")
	{
		wait(0.05);
	}

	one MoveY( 260, 2);
	one waittill("movedone");
	
	two unlink();
	level.doorsystemisbusy = false;
}


lift()
{
	lift = getent("object_lift", "targetname");
	trig = getent("trig_lift", "targetname");

	while(1)
	{
		trig waittill("trigger");

		wait(3);

		lift MoveZ( 1072, 5);
		lift waittill("movedone");

		wait(5);

		level thread CountLiftTime(5.1);
		lift MoveZ( -1072, 5);
		lift waittill("movedone");
		level notify("stopcountinglift");
		level.antiblockenabled = undefined;
	}

}

CountLiftTime(time)
{
	level endon("stopcountinglift");
	
	wait(time);
	level.antiblockenabled = true;
}

Protect()
{
	object = getent("object_protect1", "targetname");
	clip = getent("object_protect1_clip", "targetname");

	object notsolid();

	clip LinkTo(object);

	while(1)
	{
		object MoveZ( 248, 1.5);
		object waittill("movedone");

		wait(30);

		object MoveZ( -248, 3);
		object waittill("movedone");

		wait(5);
	}
}

antiElevatorBlock()
{	
	level.antiblockenabled = undefined;
	trigger = Spawn( "trigger_radius", (1256,-672,16), 0, 200, 1 );

	while(1)
	{
		trigger waittill("trigger", player);

		if(isPlayer(player))
		{		
			if(isDefined(level.antiblockenabled))
			{
				porigin	= player GetOrigin();
				new = (1072, porigin[1], 8);
				player SetOrigin(new);
			}
		}
	}

}