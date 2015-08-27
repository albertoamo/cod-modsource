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

thread elevator();
thread elevator2();
thread elevator3();

}



elevator()
{
elevator1 = getent("bloklift","targetname");
elevator1 solid();
while(1)
{
elevator1 movez (224,3,0.5,0.5);
elevator1 waittill ("movedone");
wait 5;
elevator1 notsolid();
elevator1 movez (-224,3,0.5,0.5);
elevator1 waittill ("movedone");
elevator1 solid();
wait 2;
} 
} 

elevator2()
{
elevator1 = getent("bloklift2","targetname");
elevator1 solid();
while(1)
{
elevator1 movez (904,6,0.5,0.5);
elevator1 waittill ("movedone");
wait 3;
elevator1 notsolid();
elevator1 movez (-904,6,0.5,0.5);
elevator1 waittill ("movedone");
elevator1 solid();
wait 2;
} 
} 

elevator3()
{
elevator1 = getent("bloklift3","targetname");
elevator1 solid();
while(1)
{
elevator1 movez (-1432,7,0.5,0.5);
elevator1 waittill ("movedone");
wait 5;
elevator1 notsolid();
elevator1 movez (1432,7,0.5,0.5);
elevator1 waittill ("movedone");
elevator1 solid();
wait 2;
} 
} 


