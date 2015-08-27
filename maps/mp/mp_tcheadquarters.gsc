main()
{
maps\mp\mp_tcheadquarters_fx::main();
maps\mp\_load::main();

setExpFog(0.00015, 0.8, 0.8, 0.8, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_mp_tcheadquarters");

game["allies"] = "russian";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["russian_soldiertype"] = "coats";
game["german_soldiertype"] = "winterlight";

setCvar("r_glowbloomintensity0", ".1");
setCvar("r_glowbloomintensity1", ".1");
setcvar("r_glowskybleedintensity0",".5");

thread fix();
}

fix()
{
	volume = [];
	volume[0] = 35; // min (x)
	volume[1] = -824; // min (y)
	volume[2] = -431; // min  (z)
	volume[3] = 151; // max  (x)
	volume[4] = -711; // max  (y)
	volume[5] = -270; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "allies")
		{
			spawnpointname = "mp_tdm_spawn";
			spawnpoints = getentarray(spawnpointname, "classname");
			spawnpoint = player maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);
      			player setorigin(spawnpoint.origin);
			player SetPlayerAngles(spawnpoint.angles);
		}

		wait(0.05);	
	}
}