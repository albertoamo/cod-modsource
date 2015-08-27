main()
{
	maps\mp\_load::main();

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";
	
	thread RoofBlock();
}

// Origin: (-2518.7, 498.13, 704.125)
// Origin: (-2518.7, 498.13, 704.125)
// Origin: (-2573.06, 292.682, 668.709)
// Origin: (-2567.98, 300.228, 727.545)

RoofBlock()
{
	trig = Spawn( "trigger_radius", (-2568, 300, 700), 0, 300, 50);

	while(1)
	{
		trig waittill("trigger", player);

		spawnpointname = "mp_tdm_spawn";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = player maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);
      		player setorigin(spawnpoint.origin);
		player SetPlayerAngles(spawnpoint.angles);
	}
}
