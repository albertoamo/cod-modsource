main()
{
	maps\mp\rnr_murmansk_keypad::main();
	maps\mp\rnr_murmansk_fx::main();
	maps\mp\_load::main();
	
	setExpFog(0.00028, .58, .57, .57, 0);
	ambientPlay("ambient_rnr_murmansk");

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "normandy";
	game["german_soldiertype"] = "winterlight";

	setcvar("r_glowbloomintensity0","1");
	setcvar("r_glowbloomintensity1","1");
	setcvar("r_glowskybleedintensity0",".25");

	if(getcvar("g_gametype") == "hq")
	{
		level.radio = [];
		level.radio[0] = spawn("script_model", (4624.18, -312.871, -52));
		level.radio[0].angles = (0, 252.3, 0);
		
		level.radio[1] = spawn("script_model", (3007, -2098, -92.1422));
		level.radio[1].angles = (357.929, 297.003 ,2.03431);
		
		level.radio[2] = spawn("script_model", (1045, -969.91, -57.4948));
		level.radio[2].angles = (0, 191.6, 0);
		
		level.radio[3] = spawn("script_model", (247, 288, -101.454));
		level.radio[3].angles = (5.72029, 359.959, 1.1667);
		
		level.radio[4] = spawn("script_model", (1645, 532, -80));
		level.radio[4].angles = (0, 178.9, 0);
		
		level.radio[5] = spawn("script_model", (3495, -437, -256));
		level.radio[5].angles = (0, 89.989, 0);
		
		level.radio[6] = spawn("script_model", (3681, -1653, -286));
		level.radio[6].angles = (0, 270, 0);
		
		level.radio[7] = spawn("script_model", (1585.8, -500.409, 188));
		level.radio[7].angles = (0, 307.6, 0);
		
		level.radio[8] = spawn("script_model", (3207.21, -903.143, -63));
		level.radio[8].angles = (0, 20.5, 0);
		
		level.radio[9] = spawn("script_model", (2931.28, -1459.17, 275));
		level.radio[9].angles = (0, 26.5, 0);
		
		level.radio[10] = spawn("script_model", (1485.08, -440.9, -68));
		level.radio[10].angles = (0, 100.6, 0);
		
		level.radio[11] = spawn("script_model", (1180.95, 949.952, -30));
		level.radio[11].angles = (0, 84.2, 0);
	}
}
