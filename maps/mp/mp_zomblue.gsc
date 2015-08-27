main()
{
maps\mp\_load::main();
maps\mp\teleportenter2::main();
maps\mp\mp_zomblue_rain::main();
maps\mp\mp_zomblue_elevator::main();
maps\mp\mp_zomblue_door::main();

//setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
//setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);

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

}