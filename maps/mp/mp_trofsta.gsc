main()
{
maps\mp\_load::main();

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
thread mo();
thread stand();
}

mo()
{
mo = getent ("motoot", "targetname");
while(1)
{
mo rotateyaw (360,1);
mo waittill ("rotatedone");
}
}

stand()
{
	level.stand_move = 0;
	trig=getent("vlieg","targetname");

	while(1)
	{
		trig waittill ("trigger",user);
		if(level.stand_move <= 5 && !isDefined(user.stand_move)) user thread stand_move();
	}
}

stand_move()
{
	self.stand_move = true;
	level.stand_move++;
	object = spawn("script_model", self.origin);
	wait 0.05;	
	self linkto(object);
	
	object moveto((864,-272,640),5);
	object waittill("movedone");
	
	self unlink(object);
	object delete();
	self.stand_move = undefined;
	level.stand_move--;
}