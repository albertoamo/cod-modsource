main()
{
	maps\mp\mp_zom_dv_fx::main();
	maps\mp\_load::main();

	setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
//	setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
	ambientPlay("ambient_mp_zom_dv");

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
		level.radio[0] = spawn("script_model", (-1184, -239, 61));

		level.radio[0].angles = (0, 255, 0);

		level.radio[1] = spawn("script_model", (-2164, 180, 63));

		level.radio[1].angles = (0, 203, 0);

		level.radio[2] = spawn("script_model", (-41, 715, 48));

		level.radio[2].angles = (0, 300, 0);

		level.radio[3] = spawn("script_model", (-520, -1157, 168));

		level.radio[3].angles = (0, 300, 0);

		level.radio[4] = spawn("script_model", (-791, -2073, 55));

		level.radio[4].angles = (0, 270, 0);

		level.radio[5] = spawn("script_model", (-1226, -1087, 32));

		level.radio[5].angles = (0, 180, 0);

		level.radio[6] = spawn("script_model", (-1292, 312, 208));

		level.radio[5].angles = (0, 0, 0);
}



}
