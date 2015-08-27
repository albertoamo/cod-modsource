// Scripted By Mitch
main()
{
	maps\mp\_load::main();
	maps\mp\mp_zn_bunker_script::init();
	maps\mp\mp_zn_bunker_code::init();

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

	thread GetLiftTriggers();
	thread trap1();
	thread Boat1();
	thread Security1();
	thread Secret1();
	thread Secret2();
	thread SpawnFix();
	thread SpawnFix2();
	thread SpawnFix3();
}

SpawnFix()
{
	precacheModel("xmodel/prop_barrel_benzin_wet");

	trig = Spawn( "trigger_radius", (-1649,-4147,386), 0, 14, 45);
	model = Spawn( "script_model", (-1649,-4147,370));
	model setModel("xmodel/prop_barrel_benzin_wet");

	while(1)
	{
		trig waittill("trigger", player);

      		player setorigin((-2378,-4570,600));
	}
}

SpawnFix2()
{
	precacheModel("xmodel/light_lantern_on");

	trig = Spawn( "trigger_radius", (-7744,-2072,553), 0, 5, 28);
	model = Spawn( "script_model", (-7744,-2072,537));
	model setModel("xmodel/light_lantern_on");

	while(1)
	{
		trig waittill("trigger", player);

      		player setorigin((-1391,-6640,420));
	}
}

SpawnFix3()
{
	precacheModel("xmodel/prop_bear_detail_sitting");

	trig = Spawn( "trigger_radius", (-78,-5226,16), 0, 7, 15);
	model = Spawn( "script_model", (-77,-5227,0));
	model setModel("xmodel/prop_bear_detail_sitting");
	model.angles = (0,130,0);

	while(1)
	{
		trig waittill("trigger", player);

      		player setorigin((-7336,-2805,630));
	}
}

GetLiftTriggers()
{
	precacheString(&"Press ^4[^7Use^4] ^7to go down");

	trig = getentarray("trig_lift1", "targetname");
	
	level.bunker_lift = false;

	for(i=0;i<trig.size;i++)
	{
		trig[i] thread WaitLiftTrigger();
		//if(i == 1)
			//trig[i] SetHintString("Press ^4[^7Use^4] ^7to go down");
	}
}

WaitLiftTrigger()
{
	while(1)
	{
		self waittill("trigger");
		if(!level.bunker_lift)
		{
			level.bunker_lift = true;
			Dolift1Move();
			level.bunker_lift = false;
		}
	}
}

Dolift1Move()
{
	lift = getent("object_lift1", "targetname");

	wait(2);

	lift moveZ( 466, 4);
	lift waittill("movedone");

	wait(7);

	lift moveZ( -466, 4);
	lift waittill("movedone");

	wait(2);
}

trap1()
{
	trig = getent("trig_trap_activate", "targetname");
	floor = getent("object_trap_floor", "targetname");
	bars = getent("object_trap", "targetname");
	dmg = getent("trig_trap", "targetname");
	
	while(1)
	{
		trig waittill("trigger");
		
		wait(2.1);
		bars moveZ( 169,3);
		bars waittill("movedone");
		wait(1);
		dmg thread KillOnTouch();
		floor moveZ(169, 4);
		floor waittill("movedone");

		wait(3);

		floor moveZ(-169, 4);
		floor waittill("movedone");

		dmg notify("disabletrap");

		bars moveZ( -169,3);
		bars waittill("movedone");

		wait(5);
	}

}

KillOnTouch()
{
	self endon("disabletrap");

	while(1)
	{
		self waittill("trigger", player);
		player suicide();
	}
}

Boat1()
{
	trig = getent("trig_boat", "targetname");
	boat = getent("object_boat", "targetname");
	spot1 = getent("origin_org1", "targetname");
	spot2 = getent("origin_org2", "targetname");

	startp = boat getOrigin();

	org1 = spot1 getOrigin();
	org2 = spot2 getorigin();

	while(1)
	{
		trig waittill("trigger");

		wait(3);		

		boat MoveTo( (org1[0], org1[1], startp[2]), 10);
		boat waittill("movedone");

		wait(0.15);

		boat RotateYaw(90, 3);
		boat waittill("rotatedone");

		wait(0.15);

		boat MoveTo( (org2[0], org2[1], startp[2]), 7);
		boat waittill("movedone");

		wait(7);

		boat MoveTo( (org1[0], org1[1], startp[2]), 7);
		boat waittill("movedone");

		wait(0.15);

		boat RotateYaw(-90, 3);
		boat waittill("rotatedone");

		wait(0.15);

		boat MoveTo( startp, 10);
		boat waittill("movedone");

		wait(3);
	}

}

Security1()
{
	light1 = getent("object_security1", "targetname");
	light2 = getent("object_security2", "targetname");
	light3 = getent("object_security3", "targetname");

	themoveorigin = getent("origin_security", "targetname");

	moveorigin = themoveorigin getOrigin();

	light1 thread KillOnTouch2(light1, light3);
	//light2 thread KillOnTouch2(light1, light3);
	//light3 thread KillOnTouch2(light1, light3);

	light2 linkto(light1);
	light3 linkto(light1);

	startp = light1 getOrigin();

	light1 notsolid();
	light2 notsolid();
	light3 notsolid();

	while(1)
	{
		light1 MoveTo( (moveorigin[0], startp[1], startp[2]), 10);
		light1 waittill("movedone");

		wait(1.3);

		light1 MoveTo(startp, 10);
		light1 waittill("movedone");

		wait(1.3);	
	}
}

KillOnTouch2(first, last)
{
	while(1)
	{
		players = getentarray("player", "classname");
		
		for(i=0;i<players.size;i++)
		{
			if(!isPlayer(player) || player.sessionstate != "playing")
				continue;

			_p = players[i];
			org = self getOrigin();
			org2 = last getOrigin();
			orgp = _p getOrigin();
			orgf = first getOrigin();
		
			if(orgp[0] > org[0] - 10 && orgp[0] < org[0] + 10)
			{
				if(orgp[1] > org[1] - 160 && orgp[1] < org[1] + 160)
				{
					if(orgf[2] > org[2] - 7.5 && orgp[2] < org2[2] + 7.5)
					{
						_p suicide();
					}
				}
			}

			wait(0.0001);
		}
		
		wait(0.05);		
	}

}

Secret1()
{
	trig = getent("trig_wep_code", "targetname");
	//spawnorigin = getent("origin_wepspawn", "targetname");
	origin = (648, -6336, -64);

	weapon[0]["xmodel"] = "xmodel/ak47_w";
	weapon[0]["name"] = "ak47";
	weapon[0]["spawnname"] = "weapon_ak47_mp";
	weapon[1]["xmodel"] = "xmodel/rem_model2";
	weapon[1]["name"] = "remington";
	weapon[1]["spawnname"] = "weapon_remington_mp";
	weapon[2]["xmodel"] = "xmodel/model_benelli2";
	weapon[2]["name"] = "benelli";
	weapon[2]["spawnname"] = "weapon_benelli_mp";
	weapon[3]["xmodel"] = "xmodel/sniper_wm14";
	weapon[3]["name"] = "m14 sniper";
	weapon[3]["spawnname"] = "weapon_m14_scoped_mp";
	weapon[4]["xmodel"] = "xmodel/rpd_w";
	weapon[4]["name"] = "rpd";
	weapon[4]["spawnname"] = "weapon_rpd_mp";
	weapon[5]["xmodel"] = "xmodel/viewmodel_barret";
	weapon[5]["name"] = "barret";
	weapon[5]["spawnname"] = "weapon_barret_mp";

	while(1)
	{
		trig waittill("trigger", user);

		if(!isDefined(user.secret1used) && user.pers["team"] == "allies")
		{
			user.secret1used = true;
			
			rand = randomInt(10);

			if(rand <= 5)
			{
				user iprintlnbold("You won a " + weapon[rand]["name"]);
				
				if(weapon[rand]["name"] == "m14 sniper")
					wep = Spawn( weapon[rand]["spawnname"], (647.5,-6343.5,4));
				else
					wep = Spawn( weapon[rand]["spawnname"], origin);

				wep setModel(weapon[rand]["xmodel"]);
				wep.angles = (0, 270, 0);
				wep.count = 999;
			}
		}
	}
}

Secret2()
{
	one = getent("trig_secret_p1", "targetname");
	two = getent("trig_secret_p2", "targetname");
	three = getent("trig_secret_p3", "targetname");
	model = getent("move_secret2", "targetname");
	last = getent("move_secret_p4", "targetname");

	while(1)
	{
		one waittill("damage", dmg, first);
		if(dmg > 30)
		{
			two waittill("damage", dmg, second);
			if(dmg > 30 && first == second)
			{
				three waittill("damage", dmg, player);
				if(dmg > 30 && first == second && second == player)
				{
					last notsolid();

					model moveZ( 169, 4);
					model waittill("movedone");

					wait(2);
				
					model moveZ( -169, 4);
					model waittill("movedone");
			
					last solid();
				}
			}
		}
	}

}
