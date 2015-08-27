main()
{
	//The cost of weapons
	game["waw_springfield_cost"] = "100";
	game["waw_kar98k_cost"] = "200";
	game["waw_garand_cost"] = "400";
	game["waw_gewehr_cost"] = "600";
	game["waw_carbine_cost"] = "700";
	game["waw_mp40_cost"] = "900";
	game["waw_mp44_cost"] = "1000";
	game["waw_thompson_cost"] = "1200";
	//cost of a go at the mystery box
	game["waw_mysterybox_cost"] = "2000";

	//cost to activate all electric fences                       
	game["waw_fences_cost"] = "5000";
	level.end_song_wait_time = 1527;	//time, in seconds, before  the end song plays

	game["waw_enablefences"] = "1"; 

	maps\mp\_load::main();
	maps\mp\mp_untoten_v2_shop::main();
	maps\mp\mp_untoten_v2_wood::main();
	maps\mp\mp_untoten_v2_spawnsplitter::main();
	maps\mp\mp_untoten_v2_waw_fx::main();

	setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
	// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
	ambientPlay("ambient_france");

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";

	setCvar("r_glowbloomintensity0", ".25");
	setCvar("r_glowbloomintensity1", ".25");
	setcvar("r_glowskybleedintensity0",".3");
}