main()
{
	thread dropLamp();
}


dropLamp()
{
	door1 = getent("door", "targetname");
	trig = getent("doortrigger", "targetname");
	hurt = getent("hurt", "targetname");
	hurt enablelinkto();
	hurt linkto(door1);

	timeout = 60 * 10;

	while (1)
	{
		trig waittill ("trigger",other);

		if ((isplayer (other)) && (other.pers["team"] == "axis"))
		{
			trig waittill("trigger");
			door1 movez ( 832, 40, 20, 20);
			thread spawnFireFX(timeout);
			thread spawnFireSoundFX(timeout);
			wait(timeout); // 10 minutes
			door1 movez ( -832, 40, 20, 20);
			door1 waittill("movedone");
		}
	}
}

spawnFireFX(timeout)
{
	wait (3);
	maps\mp\_fx::loopfx("building_fire_small", (-96, -16, 0), 2, undefined, undefined, undefined, timeout);
	wait (2);
	maps\mp\_fx::loopfx("building_fire_med", (-96, -16, 0), 2, undefined, undefined, undefined, timeout);
	wait (3);
	maps\mp\_fx::loopfx("building_fire_med", (-24, 88, 0), 2, undefined, undefined, undefined, timeout);
	wait (4);
	maps\mp\_fx::loopfx("building_fire_med", ( 64, -40, 0), 2, undefined, undefined, undefined, timeout);
	wait (5);
	maps\mp\_fx::loopfx("building_fire_large", ( 0, -64, 0), 2, undefined, undefined, undefined, timeout);
	wait (2);
	maps\mp\_fx::loopfx("building_fire_med", ( -42, 49, 126), 2, undefined, undefined, undefined, timeout);
	wait (3);
	maps\mp\_fx::loopfx("building_fire_large", ( 0, 30, 280), 2, undefined, undefined, undefined, timeout);
	wait (4);
	maps\mp\_fx::loopfx("building_fire_large", ( 0, 30, 550), 2, undefined, undefined, undefined, timeout);
	wait (2);
	maps\mp\_fx::loopfx("building_fire_large", ( -110, 24, 283), 2, undefined, undefined, undefined, timeout);
	maps\mp\_fx::loopfx("building_fire_large", ( 110, 24, 283), 2, undefined, undefined, undefined, timeout);
	wait (4);
	maps\mp\_fx::loopfx("building_fire_large", ( -80, 96, 640), 2, undefined, undefined, undefined, timeout);
	wait (3);
	maps\mp\_fx::loopfx("building_fire_large", (  80, 96, 640), 2, undefined, undefined, undefined, timeout);
	wait (1);
	maps\mp\_fx::loopfx("building_fire_large", ( 0, 0, 800), 2, undefined, undefined, undefined, timeout);
	wait (20);
	maps\mp\_fx::loopfx("dark_smoke_trail", ( 0, 112, 664), 2, undefined, undefined, undefined, timeout);
}

spawnFireSoundFX(timeout)
{
	wait (5);
	thread soundfx("medfire", (0,0,0), timeout);
	thread soundfx("medfire", (0,0,0), timeout);

	//maps\mp\_fx::loopfx("heavy_smoke", (896,88,216), 0.3, (896,95,220), undefined, undefined, timeout);
	//maps\mp\_fx::loopfx("medfire", (896,88,216), 2, undefined, undefined, undefined, timeout);
	//maps\mp\_fx::loopfx("heavy_smoke", (-536,-80,178), 0.3, (-536,-80,182), undefined, undefined, timeout);
	//maps\mp\_fx::loopfx("medfire", (-536,-80,178), 2, undefined, undefined, undefined, timeout);

	wait (20);

	thread soundfx("medfire", (0,0,600), timeout);
	thread soundfx("medfire", (0,0,600), timeout);
	thread soundfx("medfire", (0,0,600), timeout);

	//maps\mp\_fx::loopfx("heavy_smoke", (-305,-1770,110), 0.3, (-305,-1770,114), undefined, undefined, timeout);
	//maps\mp\_fx::loopfx("medfire", (-305,-1770,110), 2, undefined, undefined, undefined, timeout);
	//maps\mp\_fx::loopfx("heavy_smoke", (1562,-1125,110), 0.3, (1562,-1125,114), undefined, undefined, timeout);
	//maps\mp\_fx::loopfx("medfire", (1562,-1125,110), 2, undefined, undefined, undefined, timeout);
	//maps\mp\_fx::loopfx("smoke_vehicle", (1624,-147,49), 0.3, (1624,-147,55), undefined, undefined, timeout);
	//maps\mp\_fx::loopfx("medfire", (1624,-147,49), 2, undefined, undefined, undefined, timeout);
}

soundfx(fxId, fxPos, timeout)
{
	org = spawn ("script_origin",(0,0,0));
	org.origin = fxPos;
	org playloopsound (fxId);
	
	if(isDefined(timeout))
	{
		wait timeout;
		org delete();	
	}
}