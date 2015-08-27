main()
{
maps\mp\_load::main();
maps\mp\mp_zomyellow_elevator1::main();
maps\mp\mp_zomyellow_elevator2::main();
maps\mp\mp_zomyellow_platform::main();
maps\mp\mp_zomyellow_secret::main();

//setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_france");
game["allies"] = "british";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";
setCvar("r_glowbloomintensity0", ".25");setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");

thread tele();
thread delhurt();
}

delhurt()
{
	hurt = getentarray("trigger_hurt", "classname");
	hurt[3] delete();
}

tele()
{
	volume = [];
	volume[0] = -1750; // min (x)
	volume[1] = 791;   // min (y)
	volume[2] = 432;   // min (z)
	volume[3] = -1691; // max (x)
	volume[4] = 1032;  // max (y)
	volume[5] = 530;   // max (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "use");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin((-1548.62, 653.018, 456.125));
	}
}