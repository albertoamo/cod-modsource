main()
{
maps\mp\_load::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_mp_center");

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "africa";
game["german_soldiertype"] = "africa";

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");

thread fix();
}

fix()
{
	volume = [];
	volume[0] = -4065; // min (x)
	volume[1] = -4033; // min (y)
	volume[2] = -811; // min  (z)
	volume[3] = 4073; // max  (x)
	volume[4] = 3050; // max  (y)
	volume[5] = -375; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
	trigger.dmg = 100000;
}