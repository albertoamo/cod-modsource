main()
{
	thread maps\mp\_load::main();

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";

	entTransporter = getentarray("enter","targetname");
	
	if(isdefined(entTransporter))
	{
		for(lp = 0; lp < entTransporter.size; lp++)
			entTransporter[lp] thread Transporter();
	}

thread tunnel1_rotate();
thread tunnel2_rotate();
thread custom_rotate();

}

Transporter()
{
while(true)
{
self waittill("trigger",other);
entTarget = getent(self.target, "targetname");

other setorigin(entTarget.origin);
other setplayerangles(entTarget.angles);
wait(0.2);
other iprintlnbold ("You have been teleported^1!!");

}
}

tunnel1_rotate()
{
tunnel1 = getent("tunnel1", "targetname");
trig = getent("trig_tunnel1", "targetname");
while (1)
{
trig waittill("trigger");
tunnel1 rotateroll(130,4,1,1);
tunnel1 waittill("rotatedone");
wait (4);
tunnel1 rotateroll(-130,4,1,1);
tunnel1 waittill("rotatedone");
wait (2);
}
}

tunnel2_rotate()
{
tunnel2 = getent("tunnel2", "targetname");
trig = getent("trig_tunnel2", "targetname");
while (1)
{
trig waittill("trigger");
tunnel2 rotatepitch(130,4,1,1);
tunnel2 waittill("rotatedone");
wait (4);
tunnel2 rotatepitch(-130,4,1,1);
tunnel2 waittill("rotatedone");
wait (2);
}
}



custom_rotate()
{
custom = getent("custom", "targetname");
while (1)
{
custom rotateyaw(720,12,0,0);
custom waittill("rotatedone");
wait(5);
}
}