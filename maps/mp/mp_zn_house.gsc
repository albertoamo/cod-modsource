main()
{
maps\mp\_load::main();
maps\mp\mp_zn_house_fx::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 2);
ambientPlay("ambient_mp_zn_house");

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


