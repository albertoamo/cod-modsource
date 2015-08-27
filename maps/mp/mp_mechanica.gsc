main()	{
	maps\mp\_load::main();
	
	game["allies"] = "british";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["british_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";

	if(getcvar("g_gametype") == "hq")
	{
	level.radio = [];
	level.radio[0] = spawn("script_model", (1000, 1656, 1736));
	level.radio[0].angles = (0, 180, 0);
	level.radio[1] = spawn("script_model", (3392, -192, 1768));
	level.radio[1].angles = (0, 90, 0);
	level.radio[2] = spawn("script_model", (4296, 1096, 2056));
	level.radio[2].angles = (0, 270, 0);
	level.radio[3] = spawn("script_model", (4456, 2880, 1928));
	level.radio[3].angles = (0, 180, 0);
	level.radio[4] = spawn("script_model", (7240, 1696, 2032));
	level.radio[4].angles = (0, 90, 0);
	level.radio[5] = spawn("script_model", (8640, 1496, 1712));
	level.radio[5].angles = (0, 90, 0);
	level.radio[6] = spawn("script_model", (7224, -720, 1888));
	level.radio[6].angles = (0, 180, 0);
	level.radio[7] = spawn("script_model", (5392, -136, 1816));
	level.radio[7].angles = (0, 270, 0);
	}

}