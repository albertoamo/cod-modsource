main()
{
	maps\mp\mp_canal_final_fx::main();
	maps\mp\barrels::barrelInit();
	maps\mp\_load::main();

	ambientPlay("ambient_mp_canal_final");

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";

	setCvar("r_glowbloomintensity0", ".25");
	setCvar("r_glowbloomintensity1", ".25");
	setcvar("r_glowskybleedintensity0",".3");

	if(getcvar("g_gametype") == "hq")
	{
		level.radio = [];
		level.radio[0] = spawn("script_model", (-1117.2, 161.39, 417));
		level.radio[0].angles = (0, 323.9, 0);
		
		level.radio[1] = spawn("script_model", (-1666, -55.0003, 269));
		level.radio[1].angles = (0, 360, 0);
		
		level.radio[2] = spawn("script_model", (-854.0, 920.0, 269));
		level.radio[2].angles = (0, 360, 0);
		
		level.radio[3] = spawn("script_model", (-17.0012, 1074.0, 27));
		level.radio[3].angles = (0, 180.2, 0);
		
		level.radio[4] = spawn("script_model", (1190.2, 1104.56, 192));
		level.radio[4].angles = (0, 140, 0);
		
		level.radio[5] = spawn("script_model", (949.998, 745.998, 360));
		level.radio[5].angles = (0, 270.2, 0);
		
		level.radio[6] = spawn("script_model", (1320.0, 799.0, 384));
		level.radio[6].angles = (0, 0, 0);
		
		level.radio[7] = spawn("script_model", (1245.54, 1458.21, 215));
		level.radio[7].angles = (0, 221.9, 0);
		
		level.radio[8] = spawn("script_model", (2032.88, 1192.58, 348));
		level.radio[8].angles = (0, 174.3, 0);
		
		level.radio[9] = spawn("script_model", (1914.26, 842.926, 257));
		level.radio[9].angles = (0, 89.8, 0);
		
		level.radio[10] = spawn("script_model", (1629.91, 405.876, 263));
		level.radio[10].angles = (0, 57.5, 0);
		
		level.radio[11] = spawn("script_model", (1651.74, -671.928, 268));
		level.radio[11].angles = (0, 270.2, 0);

		level.radio[12] = spawn("script_model", (1240.43, -84.7628, 480));
		level.radio[12].angles = (0, 359.7, 0);
		
		level.radio[13] = spawn("script_model", (1006.84, -508.108, 272));
		level.radio[13].angles = (0, 50.3, 0);
		
		level.radio[14] = spawn("script_model", (598.572, -484.236, 292));
		level.radio[14].angles = (0, 180.1, 0);
		
		level.radio[15] = spawn("script_model", (296.811, -752.101, 124));
		level.radio[15].angles = (0, 47.9, 0);
		
		level.radio[16] = spawn("script_model", (345.257, -29.0754, 128));
		level.radio[16].angles = (0, 89.4, 0);
		
		level.radio[17] = spawn("script_model", (-800.261, 187.074, 480));
		level.radio[17].angles = (0, 269.8, 0);
		
		level.radio[18] = spawn("script_model", (-606.033, -332.13, 336));
		level.radio[18].angles = (0, 62.3, 0);
		
		level.radio[19] = spawn("script_model", (-940.263, -587.927, 224));
		level.radio[19].angles = (0, 270, 0);

		level.radio[20] = spawn("script_model", (-1049.26, 290.073, 272));
		level.radio[20].angles = (0, 270, 0);
		
		level.radio[21] = spawn("script_model", (1254.4, 465.705, 360));
		level.radio[21].angles = (0, 316.3, 0);
		
		level.radio[22] = spawn("script_model", (1139.92, 323.902, 232));
		level.radio[22].angles = (0, 180, 0);
		
		level.radio[23] = spawn("script_model", (575.921, 247.457, 216));
		level.radio[23].angles = (0, 320.4, 0);
		
		level.radio[24] = spawn("script_model", (728.081, 259.098, 320));
		level.radio[24].angles = (0, 360, 0);
		
		level.radio[25] = spawn("script_model", (-9.91858, -147.902, 356));
		level.radio[25].angles = (0, 360, 0);

		
	}

}

/*