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
setcvar("r_glowskybleedintensity0",".3");

thread elevator();
thread elevator1();
thread deur();
level thread teleporters();

}

elevator()
{
elevator = getent("kabel","targetname");
while(1)
{
elevator movey (-1784,12,2,2);
elevator waittill ("movedone");
wait(10);
elevator movey (1784,12,2,2);
elevator waittill ("movedone");
wait(10);

} 
} 

elevator1()
{
elevator1 = getent("boot","targetname");
while(1)
{
elevator1 movex (1400,6,2,2);
elevator1 waittill ("movedone");
wait(10);
elevator1 movex (-1400,6,2,2);
elevator1 waittill ("movedone");
wait(10);

} 
} 


deur()
{
deur = getent ("deur", "targetname");
trig = getent ("deurtrigger", "targetname"); 
while(1)
{
trig waittill ("trigger");
deur rotateyaw (90,1.5);
deur waittill ("rotatedone");
wait 3;
deur rotateyaw (-90,1.5);
deur waittill ("rotatedone");
wait 6;
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