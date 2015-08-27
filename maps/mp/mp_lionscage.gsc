#include maps\mp\_utility;

main() 
{

	maps\mp\mp_lionscage_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_lionscage_teleportenter::main();

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";

	setcvar("r_glowbloomintensity0",".25");
	setcvar("r_glowbloomintensity1",".25");
	setcvar("r_glowskybleedintensity0",".3");
}