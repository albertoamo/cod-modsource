main()
{
maps\mp\_load::main();
//setExpFog(0.0001, 0.55, 0.6, 0.55, 0);

// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
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

level thread RemoveTurret();
thread trigger_tut(); 
level thread luik();
level thread boot();
level thread jwz();
thread SpawnFix();
}

RemoveTurret()
{
	weapon = getentarray("misc_turret", "classname");

	for(i=0;i<weapon.size;i++)
	{
		if(weapon[i].origin == (1677, 128, 496) || weapon[i].origin == (1677, -112, 496))
		{
			weapon[i] delete();
		}
	}
}

SpawnFix()
{
	trig = Spawn( "trigger_radius", (-2083, -574.952, 568.125), 0, 50, 50);

	while(1)
	{
		trig waittill("trigger", player);

		spawnpointname = "mp_tdm_spawn";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = player maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);
      		player setorigin(spawnpoint.origin);
		player SetPlayerAngles(spawnpoint.angles);
	}
}

trigger_tut() 
{
trig = getent("trigger_tut","targetname"); 
while(1)
{
trig waittill ("trigger",user);
user iprintlnbold ("Shoot tha ^1bitchezz ^7 for a ^1Hotttt ^7Shower ^1:^7]"); 
wait 8; 
}
}
luik()
{

luik = getent ("luik", "targetname");
trig = getent ("luiktrigger", "targetname");

while(1)
{
trig waittill ("trigger");

luik rotateroll (90,1);
luik waittill ("rotatedone");

wait(3);

luik rotateroll (-90,1);
luik waittill ("rotatedone");
}
}
boot()
{
liftpad2=getent("boot","targetname");
while(1)
	{
wait (3);
liftpad2 movex (940,5,3,2);
liftpad2 waittill ("movedone");
wait (3);
liftpad2 movex (-940,5,3,2);
liftpad2 waittill ("movedone");
	}
}
jwz()
{
liftpad3=getent("jwz2","targetname");
while(1)
	{
wait (3);
liftpad3 movez (1030,7,5,2);
liftpad3 waittill ("movedone");
wait (3);
liftpad3 movez (-1030,7,5,2);
liftpad3 waittill ("movedone");
	}
}
