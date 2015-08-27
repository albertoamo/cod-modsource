main()
{
maps\mp\_load::main();
maps\mp\mp_pit_teleportenter::main();   //this calls up the teleportenter.gsc


// set background ambient noise
ambientPlay("ambient_mp_pit");

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

}