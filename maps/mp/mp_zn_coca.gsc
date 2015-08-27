main()
{
maps\mp\_load::main();
maps\mp\mp_zn_coca_drown::main();
maps\mp\mp_zn_coca_wep::main();

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "africa";

thread secretdoor();
thread transporter();
thread getWall();
thread getWepTriggers();
thread mapShot();
thread fix();
}

fix()
{
	volume = [];
	volume[0] = -208; // min (x)
	volume[1] = 936; // min (y)
	volume[2] = -16; // min  (z)
	volume[3] = -176; // max  (x)
	volume[4] = 984; // max  (y)
	volume[5] = 16; // max  (z)
	
	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
}

mapShot()
{
	level endon("intermission");

	trig = getent("trig_mapshot", "targetname");
	
	while(1)
	{
		trig waittill("damage", dmg, user);
		user thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback();
	}
}

getWepTriggers()
{
	trig = getentarray("trig_wep", "targetname");

	for(i=0;i<trig.size;i++)
		level thread WepSpawn(trig[i]);
}

WepSpawn(trig)
{
	level endon("intermission");

	wait(0.05);

	if(!isDefined(trig.target))
	{
		trig delete();
		return;
	}	

	model = getent(trig.target, "targetname");

	if(!isDefined(model) || !isDefined(model.script_team) || !isDefined(model.script_label) || !isDefined(level.weapons[model.script_team]))
	{
		trig delete();
		return;
	}

	while(1)
	{
		trig waittill("trigger", user);

		wait(0.05);

		if(user isTouching(trig))
			break;
	}

	trig delete();

	wep = Spawn( "weapon_" + model.script_team, model.origin);
	wep setModel(model.script_label);

	if(isdefined(model.angles))
		wep.angles = model.angles;

	wep.count = 999;

	if(isDefined(model.script_linked) && model.script_linked == 1)
		wep linkto(model);
	else
		model delete();
}

getWall()
{
	wall = getent("object_wall", "targetname");
	trig = getent(wall.target, "targetname");
	trig enableLinkTo();
	trig linkto(wall);
	wall.backtrig = trig;
	
	wall thread getWallTrigger();
	wall thread getWallSecret();
}

getWallTrigger()
{
	level endon("intermission");

	trig = getent("trig_wall", "targetname");

	while(1)
	{
		trig waittill("trigger", user);
		self moveWall();
		wait(0.05);
	}
}

getWallSecret()
{
	level endon("intermission");

	one = getent("trig_wall_1", "targetname");
	two = getent("trig_wall_2", "targetname");
	three = getent("trig_wall_3", "targetname");

	while(1)
	{
		one waittill("trigger", user);
		two waittill("trigger", user2);
		if(isPlayer(user) && isPlayer(user2) && user == user2)
		{
			three waittill("trigger", user3);

			if(isPlayer(user2) && isPlayer(user3) && user2 == user3)
				self moveWall();
		}
	}
}

moveWall()
{
	level endon("intermission");

	if(isDefined(self.ismoving))
		return;

	self.ismoving = true;
	self thread moveWallHurt();

	self moveX(-256, 3);
	self waittill("movedone");

	self notify("wallatend");

	wait(5);

	self moveX(256, 3);
	self waittill("movedone");

	wait(3);
	
	self.ismoving = undefined;
}

moveWallHurt()
{
	level endon("intermission");
	self endon("wallatend");

	while(1)
	{
		self.backtrig waittill("trigger", user);
		user thread [[level.callbackPlayerDamage]](user, user, 5, 0, "MOD_GRENADE_SPLASH", "none", user.origin, (0,0,0), "none", 0);   
		wait(0.25);
	}
}

triggerOff()
{
	self.origin += (0, 0, -10000);
}

triggerOn()
{
	self.origin += (0, 0, 10000);
}

transporter()
{
	level endon("intermission");
	trig = getent("trig_transporter", "targetname");
	object = getent(trig.target, "targetname");
	next = getent(object.target, "targetname");

	trig enableLinkTo();

	while(1)
	{
		trig waittill("trigger", user);
		//user iprintln("^1You activated the transporter");

		trig triggerOff();
		trig linkto(object);
	
		object moveTo(next getOrigin(), 5);
		object waittill("movedone");

		object rotateYaw(-90, 1);
		object waittill("rotatedone");

		next = getent(next.target, "targetname");

		trig unlink();
		trig triggerOn();
		trig thread sayCharging();

		wait(1);
		trig notify("charged");
	}
}

sayCharging()
{
	level endon("intermission");
	self endon("charged");

	while(1)
	{
		self waittill("trigger", user);
		user iprintln("^1The transporter is charging...");
		wait(0.05);
	}
}

secretdoor()
{
	level endon("intermission");
	trig = getent("trig_door", "targetname");
	door = getent("script_door", "targetname");
	dist = door.script_delay;

	while(1)
	{
		trig waittill("damage", dmg, user);

		if(dmg > 20 && user MeleeButtonPressed())
		{
			door moveY(dist * -1, 1);
			door waittill("movedone");
			
			wait(5);
			
			door moveY(dist, 1);
			door waittill("movedone");
		}

		wait(1);
	}
}