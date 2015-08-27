main()
{
maps\mp\_load::main();
maps\mp\mp_zom_windmill_flubberlamp::main();
maps\mp\mp_zom_windmill_fx::main();

setExpFog(0.001, 0.55, 0.6, 0.55, 0);
setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);	
ambientPlay("ambient_mp_zombie");

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

thread fix();
}

fix()
{
	volume = [];
	volume[0] = -1952; // min (x)
	volume[1] = 3334; // min (y)
	volume[2] = 150; // min  (z)
	volume[3] = -1710; // max  (x)
	volume[4] = 3626; // max  (y)
	volume[5] = 400; // max  (z)

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