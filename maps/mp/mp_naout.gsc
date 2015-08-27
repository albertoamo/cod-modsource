main()
 { 
maps\mp\mp_naout_fx::main();
maps\mp\_load::main(); 

ambientPlay("ambient_mp_naout");


	game["allies"] = "british";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["british_soldiertype"] = "africa";
	game["german_soldiertype"] = "africa";

	setcvar("r_glowbloomintensity0","1");
	setcvar("r_glowbloomintensity1","1");
	setcvar("r_glowskybleedintensity0",".25");

if(getcvar("g_gametype") == "hq")
	{
	level.radio = [];
		level.radio[0] = spawn("script_model", (664, 231, 171));
		level.radio[0].angles = (0, 180, 0);

		level.radio[1] = spawn("script_model", (-688, 240, 40));
		level.radio[1].angles = (0, 180, 0);

		level.radio[2] = spawn("script_model", (-1259, -126, -26.9439));
		level.radio[2].angles = (0.78 , 298, 0.59);

		level.radio[3] = spawn("script_model", (-1844, 517.999, 119));
		level.radio[3].angles = (0, 0, 0);

		level.radio[4] = spawn("script_model", (1074, -580.998, 160));
		level.radio[4].angles = (0, 151, 0);

		level.radio[5] = spawn("script_model", (752, 1496, 151));
		level.radio[5].angles = (0, 180, 0);

		level.radio[6] = spawn("script_model", (1120.94, 888.967, 24));
		level.radio[6].angles = (0, 150, 0);
	}

 }