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
thread govaslift();
} 
govaslift()
{
govas = getent("govaslift","targetname");
while(1)
{
govas movez (640,7,3,3);
govas waittill ("movedone");
wait(5);
govas movez (-640,7,3,3);
govas waittill ("movedone");
wait(5);
} 
} 