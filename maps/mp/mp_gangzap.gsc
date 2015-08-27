main()
{
maps\mp\_load::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
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


thread elevator();
thread elevator2();
level thread teleporters();

thread fix();
}

fix()
{
	volume = [];
	volume[0] = -19; // min (x)
	volume[1] = -31; // min (y)
	volume[2] = 16; // min  (z)

	volume[3] = -15; // max  (x) 
	volume[4] = -112; // max  (y)
	volume[5] = 70; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin((-382.434, -407.687, 16.125));
		wait(0.05);
	}
}

elevator()
{
elevator = getent("trap","targetname");
trig = getent ("traptrigger", "targetname"); 
while(1)
{
trig waittill ("trigger");
elevator movez (-40,3,1,1);
elevator waittill ("movedone");
wait(2);
elevator movez (40,3,1,1);
elevator waittill ("movedone");
wait(7);
} 
} 

teleporters()
{

entteleporter = getentarray("enter","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();

}
}


teleporter()
{
while(true)
{
self waittill("trigger",other);
entTarget = getent(self.target, "targetname");

wait(0.10);
other setorigin(entTarget.origin);
other setplayerangles(entTarget.angles);
wait(0.10);
}
}

elevator2()
{
elevator2 = getent("greenbalk","targetname");
trig = getent ("greenbalktrigger", "targetname"); 
while(1)
{
trig waittill ("trigger");
elevator2 movez (80,5,1,1);
elevator2 waittill ("movedone");
wait(5);
elevator2 movez (-80,5,1,1);
elevator2 waittill ("movedone");
wait(5);
} 
} 