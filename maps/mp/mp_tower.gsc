main()
{
maps\mp\_load::main();
ambientPlay("ambient_mp_tower");

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_france");

game["allies"] = "russian";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["russian_soldiertype"] = "padded";
game["german_soldiertype"] = "winterlight";

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");

thread fix();
thread tele();
}

tele()
{
	volume = [];
	volume[0] = -1161; // min (x)
	volume[1] = 467; // min (y)
	volume[2] = 16; // min  (z)
	volume[3] = -1103; // max  (x)
	volume[4] = 529; // max  y)
	volume[5] = 100; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (0,0,1);
	
	while(1)
	{
		trigger waittill("trigger", player);
		player setOrigin((-154, 180, 968));
	}
}

fix()
{
	volume = [];
	volume[0] = 132; // min (x)
	volume[1] = 208; // min (y)
	volume[2] = 624; // min  (z)
	volume[3] = 180; // max  (x)
	volume[4] = 252; // max  (y)
	volume[5] = 640; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (0,0,1);
	trigger.dmg = 5;
	trigger.delay = 0.5;
}