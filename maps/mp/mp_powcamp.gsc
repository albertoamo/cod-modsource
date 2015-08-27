#include maps\mp\_utility;
main()
{
	maps\mp\_load::main();

	setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
//	setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
	ambientPlay("ambient_mp_powcamp");

	game["allies"] = "russian";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["russian_soldiertype"] = "coats";
	game["german_soldiertype"] = "normandy";

	setCvar("r_glowbloomintensity0", ".25");
	setCvar("r_glowbloomintensity1", ".25");
	setcvar("r_glowskybleedintensity0",".3");

	if(getcvar("g_gametype") == "hq") 
	{ 
	level.radio = []; 
	level.radio[0] = spawn("script_model", (-632, -2092, 8)); 
	level.radio[0].angles = (0, 0, 0); 
	level.radio[1] = spawn("script_model", (2128, 2089, 8)); 
	level.radio[1].angles = (0, 0, 0); 
	level.radio[2] = spawn("script_model", (823, 2654, 40)); 
	level.radio[2].angles = (0, 0, 0); 
	level.radio[3] = spawn("script_model", (1338, -1318, 8)); 
	level.radio[3].angles = (0, 0, 0); 
	level.radio[4] = spawn("script_model", (585, 348, 8)); 
	level.radio[4].angles = (0, 0, 0); 
	level.radio[5] = spawn("script_model", (934, 1284, 8)); 
	level.radio[5].angles = (0, 0, 0); 
	level.radio[6] = spawn("script_model", (-828, 1833, 8)); 
	level.radio[6].angles = (0, 0, 0); 
	level.radio[7] = spawn("script_model", (-261, -548, 8)); 
	level.radio[7].angles = (0, 0, 0);
	}

	if(getcvar("scr_allow_turrets") != "" && getcvarint("scr_allow_turrets") < 1) 
	{ 
		deletePlacedEntity("weapon_mp44_mp");
	} 
	
	thread fix();
}

fix()
{
	volume = [];
	volume[0] = 763; // min (x)
	volume[1] = -2228; // min (y)
	volume[2] = 208; // min  (z)
	volume[3] = 932; // max  (x)
	volume[4] = -2075; // max  (y)
	volume[5] = 308; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", user);

		if(user.pers["team"] == "allies")
			user thread [[level.callbackPlayerDamage]](user, user, 1, 0, "MOD_GRENADE_SPLASH", "none", user.origin, (0,0,0), "none", 0);	

		wait(0.05);
	}
}