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

level thread elevator();
level thread elevator2();
}

elevator2()
{
kabel=getent("elevator2","targetname");
while(1)
	{
wait (14);
kabel movey (-1288,10,8,2);
kabel waittill ("movedone");
wait (14);
kabel movey (1288,10,8,2);
kabel waittill ("movedone");
	}
}
elevator()
{
lift=getent("elevator","targetname");
while(1)
	{
wait (7);
lift movez (-672,7,5,2);
lift waittill ("movedone");
wait (7);
lift movez (672,7,5,2);
lift waittill ("movedone");
	}
}
