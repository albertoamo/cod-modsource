main()
{
maps\mp\_load::main();
maps\mp\mp_nationboX_v2_elevator::main(); 
maps\mp\mp_nationboX_v2_teleportenter::main(); 
maps\mp\mp_nationboX_v2_door::main();

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

level thread hatch();
thread Fix();
thread switchtp();
}

switchtp()
{
	target = getent("tp27", "targetname");
	target.origin = (448, 2144, 56);
}

Fix()
{
	trig = spawn("trigger_radius", (-368,152,-1432), 0, 230, 55);

	while(1)
	{
		trig waittill("trigger", player);

		player FinishPlayerDamage( player, player, 10, 1, "MOD_EXPLOSIVE", "none", player.origin, (0,0,0), "none", 0 );
		wait(0.05);
	}
}

hatch()
{
hatch = getent ("hatch", "targetname");
trig = getent ("hatchtrigger", "targetname"); 

while(1)
{
trig waittill ("trigger");

hatch rotatepitch (90,0.5);
hatch waittill ("rotatedone");

trig waittill ("trigger");

hatch rotatepitch (-90,0.5);
hatch waittill ("rotatedone");

}
}