main()
{
maps\mp\_load::main();
maps\mp\_stenen::main();
maps\mp\_teleporters::main();
maps\mp\_draai::main();
maps\mp\_tekst::main();
maps\mp\_kogels::main();
maps\mp\_cellenblok::main();
maps\mp\_vallen::main();

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
thread elevator2();
thread elevator3();
thread elevator4();
thread elevator5();
thread elevator6();
thread elevator13();
thread elevator14();
thread elevator15();
thread elevator16();
thread elevator18();
thread elevator19();
thread elevator20();
thread elevator21();
thread elevator22();
}

elevator()
{
elevator = getent("transportlift1","targetname");
while(1)
{
elevator movez (-128,4,1.9,1.9);
elevator waittill ("movedone");
wait(3);
elevator movez (-288,5,1.9,1.9);
elevator waittill ("movedone");
wait(7);
elevator movez (288,5,1.9,1.9);
elevator waittill ("movedone");
wait(3);
elevator movez (128,4,1.9,1.9);
elevator waittill ("movedone");
wait(7);
} 
} 

elevator1()
{
elevator1 = getent("transportcar1","targetname");
while(1)
{
wait(5);
elevator1 movey (1472,7,3,2);
elevator1 waittill ("movedone");
wait(5);
elevator1 movey (-1472,7,3,2);
elevator1 waittill ("movedone");
} 
} 

elevator2()
{
elevator2 = getent("transportschip1","targetname");
trig = getent ("schip1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
wait(11);
elevator2 movex (650,6,3,2);
elevator2 waittill ("movedone");
elevator2 moveto((1750,-750,-20),5);
elevator2 waittill ("movedone");
elevator2 rotateyaw (90,0.5);
elevator2 waittill ("rotatedone");
elevator2 moveto((1750,816,500),7);
elevator2 waittill ("movedone");
elevator2 rotateyaw (-90,0.5);
elevator2 waittill ("rotatedone");
elevator2 moveto((3936,640,808),7);
elevator2 waittill ("movedone");
elevator2 rotateyaw (-90,0.5);
elevator2 waittill ("rotatedone");
elevator2 movey (-1120,7,3,2);
elevator2 waittill ("movedone");
wait(15);
elevator2 movey (-1120,7,3,2);
elevator2 waittill ("movedone");
elevator2 rotateyaw (-90,0.5);
elevator2 waittill ("rotatedone");
elevator2 moveto((1306,96,424),7);
elevator2 waittill ("movedone");
elevator2 rotateyaw (-180,1);
elevator2 waittill ("rotatedone");
elevator2 movex (-650,6,3,2);
elevator2 waittill ("movedone");
wait(15);
} 
} 

elevator3()
{
elevator3 = getent("deur1","targetname");
trig = getent ("schip1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator3 movey (-424,10,3,2);
elevator3 waittill ("movedone");
wait(6);
elevator3 movey (424,10,3,2);
elevator3 waittill ("movedone");
wait(35);
elevator3 movey (-424,10,3,2);
elevator3 waittill ("movedone");
wait(10);
elevator3 movey (424,10,3,2);
elevator3 waittill ("movedone");
wait(5);
} 
} 

elevator4()
{
elevator4 = getent("transportschip2","targetname");
trig = getent ("schip2trigger", "targetname");
while(1)
{
trig waittill ("trigger");
wait(11);
elevator4 movex (-1472,7,3,2);
elevator4 waittill ("movedone");
elevator4 moveto((-4000,-192,1148),7);
elevator4 waittill ("movedone");
elevator4 movex (-624,5,1,1);
elevator4 waittill ("movedone");
wait(15);
elevator4 movex (-800,5,1,1);
elevator4 waittill ("movedone");
elevator4 rotateyaw (-90,1);
elevator4 waittill ("rotatedone");
elevator4 movey (800,5,1,1);
elevator4 waittill ("movedone");
elevator4 rotateyaw (-90,1);
elevator4 waittill ("rotatedone");
elevator4 moveto((-1432,96,424),7);
elevator4 waittill ("movedone");
elevator4 rotateyaw (-180,2);
elevator4 waittill ("rotatedone");
elevator4 movex (800,6,3,2);
elevator4 waittill ("movedone");
wait(15);
} 
} 

elevator5()
{
elevator5 = getent("deur2","targetname");
trig = getent ("schip2trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator5 movey (-424,10,3,2);
elevator5 waittill ("movedone");
wait(7);
elevator5 movey (424,10,3,2);
elevator5 waittill ("movedone");
wait(25);
elevator5 movey (-424,10,3,2);
elevator5 waittill ("movedone");
wait(7);
elevator5 movey (424,10,3,2);
elevator5 waittill ("movedone");
wait(5);
} 
} 

elevator6()
{
elevator6 = getent("deur3","targetname");
trig = getent ("deur3trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator6 movey (-424,10,3,2);
elevator6 waittill ("movedone");
wait(5);
trig waittill ("trigger");
elevator6 movey (424,10,3,2);
elevator6 waittill ("movedone");
wait(5);
} 
} 


elevator13()
{
elevator13 = getent("staal1deur","targetname");
trig = getent ("staal1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator13 movex (136,5,2,2);
elevator13 waittill ("movedone");
wait(15);
elevator13 movex (-136,5,2,2);
elevator13 waittill ("movedone");
wait(30);
} 
} 

elevator14()
{
elevator14 = getent("transportschip3","targetname");
while(1)
{
elevator14 movey (9000,8,0,0);
elevator14 waittill ("movedone");
elevator14 rotateyaw (90,2);
elevator14 waittill ("rotatedone");
elevator14 movex (-5000,4,1,1);
elevator14 waittill ("movedone");
elevator14 rotateyaw (90,2);
elevator14 waittill ("rotatedone");
elevator14 movey (-9000,8,3,2);
elevator14 waittill ("movedone");
elevator14 rotateyaw (90,2);
elevator14 waittill ("rotatedone");
elevator14 movex (5000,4,1,1);
elevator14 waittill ("movedone");
elevator14 rotateyaw (90,2);
elevator14 waittill ("rotatedone");
} 
} 

elevator15()
{
elevator15 = getent("transportschip4","targetname");
while(1)
{
elevator15 movey (9000,6,0,0);
elevator15 waittill ("movedone");
elevator15 rotateyaw (-90,2);
elevator15 waittill ("rotatedone");
elevator15 movex (5000,3,1,1);
elevator15 waittill ("movedone");
elevator15 rotateyaw (-90,2);
elevator15 waittill ("rotatedone");
elevator15 movey (-9000,6,3,2);
elevator15 waittill ("movedone");
elevator15 rotateyaw (-90,2);
elevator15 waittill ("rotatedone");
elevator15 movex (-5000,3,1,1);
elevator15 waittill ("movedone");
elevator15 rotateyaw (-90,2);
elevator15 waittill ("rotatedone");
} 
} 

elevator16()
{
elevator16 = getent("transportschip5","targetname");
while(1)
{
elevator16 movey (9000,7,0,0);
elevator16 waittill ("movedone");
elevator16 rotateyaw (-90,2);
elevator16 waittill ("rotatedone");
elevator16 movex (5000,3,1,1);
elevator16 waittill ("movedone");
elevator16 rotateyaw (-90,2);
elevator16 waittill ("rotatedone");
elevator16 movey (-9000,7,3,2);
elevator16 waittill ("movedone");
elevator16 rotateyaw (-90,2);
elevator16 waittill ("rotatedone");
elevator16 movex (-5000,3,1,1);
elevator16 waittill ("movedone");
elevator16 rotateyaw (-90,2);
elevator16 waittill ("rotatedone");
} 
} 

elevator18()
{
elevator18 = getent("hek","targetname");
trig = getent ("hektrigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator18 movey (-60,5,2,2);
elevator18 waittill ("movedone");
trig waittill ("trigger");
elevator18 movey (60,5,2,2);
elevator18 waittill ("movedone");
} 
} 

elevator19()
{
elevator19 = getent("hek1","targetname");
trig = getent ("hek1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator19 movey (550,8,2,2);
elevator19 waittill ("movedone");
trig waittill ("trigger");
elevator19 movey (-550,8,2,2);
elevator19 waittill ("movedone");
} 
} 

elevator20()
{
elevator20 = getent("door2","targetname");
trig = getent ("door2trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator20 movex (-60,5,2,2);
elevator20 waittill ("movedone");
trig waittill ("trigger");
elevator20 movex (60,5,2,2);
elevator20 waittill ("movedone");
} 
} 

elevator21()
{
elevator21 = getent("door1","targetname");
trig = getent ("door1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator21 movex (60,5,2,2);
elevator21 waittill ("movedone");
trig waittill ("trigger");
elevator21 movex (-60,5,2,2);
elevator21 waittill ("movedone");
} 
} 


elevator22()
{
elevator22 = getent("down","targetname");
trig = getent ("bloktrigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator22 movez (-196,9,2,2);
elevator22 waittill ("movedone");
trig waittill ("trigger");
elevator22 movez (196,9,2,2);
elevator22 waittill ("movedone");
} 
} 

