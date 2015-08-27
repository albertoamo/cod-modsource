main()
{
	maps\mp\mp_toujane_fx::main();
	maps\mp\_load::main();
	ambientPlay("ambient_africa");

	setExpFog(0.00015, 0.9, 0.95, 1, 0);

	game["allies"] = "british";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["british_soldiertype"] = "africa";
	game["german_soldiertype"] = "africa";

	setcvar("r_glowbloomintensity0",".25");
	setcvar("r_glowbloomintensity1",".25");
	setcvar("r_glowskybleedintensity0",".5");

	if(getcvar("g_gametype") == "hq")
	{
		level.radio = [];
		level.radio[0] = spawn("script_model", (285.332, 471.947, 12.1747));
		level.radio[0].angles = (0, 335.6, 0);

		level.radio[1] = spawn("script_model", (-7.80745, 1100.36, -11.0072));
		level.radio[1].angles = (355.751, 55.1337, -2.21861);

		level.radio[2] = spawn("script_model", (1282.54, 731.845, -1.99999));
		level.radio[2].angles = (0, 133.073, 0);

		level.radio[3] = spawn("script_model", (2206.32, 411.609, 54.6547));
		level.radio[3].angles = (2.21806, 151.797, -7.6227);

		level.radio[4] = spawn("script_model", (758.63, 1725.03, 148));
		level.radio[4].angles = (0, 354.855, 0);

		level.radio[5] = spawn("script_model", (1558.4, 1569.03, 96.0133));
		level.radio[5].angles = (0.629538, 196.751, -2.07329);

		level.radio[6] = spawn("script_model", (986.298, 3040.61, 58.7701));
		level.radio[6].angles = (0.640552, 196.255, -3.11342);

		level.radio[7] = spawn("script_model", (2295.88, 2483.53, 70.7077));
		level.radio[7].angles = (1.35945, 129.516, 1.18606);

		level.radio[8] = spawn("script_model", (2971.51, 1570.41, 45.4606));
		level.radio[8].angles = (0.282498, 74.994, -0.237561);

		level.radio[9] = spawn("script_model", (1758, 653.443, 176));
		level.radio[9].angles = (0, 39.351, 0);
	}

	if(getCvar("scr_nokilltrigger") == "1" || getCvar("scr_nokilltrigger_" + getCvar("mapname")) == "1")
	{
		i = 0;
		//level.killtriggers[i] = spawnstruct();
		//level.killtriggers[i].origin = (2025, 1835, 316);
		//level.killtriggers[i].radius = 277;
		//level.killtriggers[i].height = 80;
		//i++;

		//level.killtriggers[i] = spawnstruct();
		//level.killtriggers[i].origin = (1968, 1572, 284);
		//level.killtriggers[i].radius = 50;
		//level.killtriggers[i].height = 30;
		//i++;

		//level.killtriggers[i] = spawnstruct();
		//level.killtriggers[i].origin = (2060, 1584, 284);
		//level.killtriggers[i].radius = 50;
		//level.killtriggers[i].height = 30;
		//i++;

		//level.killtriggers[i] = spawnstruct();
		//level.killtriggers[i].origin = (736, 1652, 232);
		//level.killtriggers[i].radius = 110;
		//level.killtriggers[i].height = 140;
		//i++;

		//level.killtriggers[i] = spawnstruct();
		//level.killtriggers[i].origin = (584, 944, 296);
		//level.killtriggers[i].radius = 280;
		//level.killtriggers[i].height = 140;
		//i++;

		level.killtriggers[i] = spawnstruct();
		level.killtriggers[i].origin = (1850, 2855, 298);
		level.killtriggers[i].radius = 12;
		level.killtriggers[i].height = 12;
		i++;

		level.killtriggers[i] = spawnstruct();
		level.killtriggers[i].origin = (1616, 720, 256);
		level.killtriggers[i].radius = 12;
		level.killtriggers[i].height = 12;
		i++;

		level.killtriggers[i] = spawnstruct();
		level.killtriggers[i].origin = (1320, 536, 302);
		level.killtriggers[i].radius = 12;
		level.killtriggers[i].height = 12;
		i++;

		level.killtriggers[i] = spawnstruct();
		level.killtriggers[i].origin = (1932, 1054, 336);
		level.killtriggers[i].radius = 12;
		level.killtriggers[i].height = 12;

		thread maps\mp\_killtriggers::init();
	}
}
