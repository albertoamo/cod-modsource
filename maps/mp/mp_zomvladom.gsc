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
thread elevator2();
thread elevator3();
thread elevator4();

}


elevator()
{
elevator = getent("tourauto","targetname");
while(1)
{
elevator movex (900,5,0.5,0.2);
elevator waittill ("movedone");
elevator rotateyaw (90,0.5);
elevator movey (512,2,0.2,0.2);
elevator waittill ("movedone");
elevator rotateyaw (-90,0.5);
elevator movex (1100,4,0.2,0.2);
elevator waittill ("movedone");
elevator rotateyaw (-90,0.5);
elevator movey (-1600,4,0.2,0.5);
elevator waittill ("movedone");
elevator rotateyaw (-90,0.5);
wait 5;
elevator movex (-2000,5,0.2,0.5);
elevator waittill ("movedone");
elevator rotateyaw (-90,0.5);
elevator movey (1088,4,0.2,0.5);
elevator waittill ("movedone");
elevator rotateyaw (-90,0.5);
wait 5;
} 
}

elevator2()
{
elevator2 = getent("racelift","targetname");
while(1)
{
elevator2 movez (112,5,0.5,0.2);
elevator2 waittill ("movedone");
elevator2 movey (-1792,5,1,0.5);
elevator2 waittill ("movedone");
elevator2 movez (-112,5,0.5,0.2);
elevator2 waittill ("movedone");
wait 5;
elevator2 movez (112,5,0.5,0.2);
elevator2 waittill ("movedone");
elevator2 movey (1792,5,1,0.5);
elevator2 waittill ("movedone");
elevator2 movez (-112,5,0.5,0.2);
elevator2 waittill ("movedone");
wait 5;
} 
}

elevator3()
{
elevator3 = getent("bloklift","targetname");
while(1)
{
elevator3 movez (-176,7,0.5,0.2);
elevator3 waittill ("movedone");
wait 10;
elevator3 movez (176,7,0.2,0.5);
elevator3 waittill ("movedone");
wait 10;
} 
}

elevator4()
{
elevator4=getent("nummerlift","targetname");
trig=getent("trig_nummerlift","targetname");
while(1)
{
trig waittill ("trigger");
elevator4 movez (-60,5,2,2);
elevator4 waittill ("movedone");
wait(5);
elevator4 movez (60,5,2,2);
elevator4 waittill ("movedone");
wait(10);
}
}