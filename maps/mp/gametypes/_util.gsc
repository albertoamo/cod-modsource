// Modified by La Truffe

/*
USAGE OF "cvardef"
cvardef replaces the multiple lines of code used repeatedly in the setup areas of the script.
The function requires 5 parameters, and returns the set value of the specified cvar
Parameters:
	varname - The name of the variable, i.e. "scr_teambalance", or "scr_dem_respawn"
		This function will automatically find map-sensitive overrides, i.e. "src_dem_respawn_mp_brecourt"

	vardefault - The default value for the variable.  
		Numbers do not require quotes, but strings do.  i.e.   10, "10", or "wave"

	min - The minimum value if the variable is an "int" or "float" type
		If there is no minimum, use "" as the parameter in the function call

	max - The maximum value if the variable is an "int" or "float" type
		If there is no maximum, use "" as the parameter in the function call

	type - The type of data to be contained in the vairable.
		"int" - integer value: 1, 2, 3, etc.
		"float" - floating point value: 1.0, 2.5, 10.384, etc.
		"string" - a character string: "wave", "player", "none", etc.
*/
cvardef(varname, vardefault, min, max, type)
{
	mapname = getcvar("mapname");		// "mp_dawnville", "mp_rocket", etc.

	if(isdefined(level.ze_gametype))
		gametype = level.ze_gametype;	// "tdm", "bel", etc.
	else
		gametype = getcvar("g_gametype");	// "tdm", "bel", etc.

	tempvar = varname + "_" + gametype;	// i.e., scr_teambalance becomes scr_teambalance_tdm
	if(getcvar(tempvar) != "") 		// if the gametype override is being used
		varname = tempvar; 		// use the gametype override instead of the standard variable

	tempvar = varname + "_" + mapname;	// i.e., scr_teambalance becomes scr_teambalance_mp_dawnville
	if(getcvar(tempvar) != "")		// if the map override is being used
		varname = tempvar;		// use the map override instead of the standard variable


	// get the variable's definition
	switch(type)
	{
		case "int":
			if(getcvar(varname) == "")		// if the cvar is blank
				definition = vardefault;	// set the default
			else
				definition = getcvarint(varname);
			break;
		case "float":
			if(getcvar(varname) == "")	// if the cvar is blank
				definition = vardefault;	// set the default
			else
				definition = getcvarfloat(varname);
			break;
		case "string":
		default:
			if(getcvar(varname) == "")		// if the cvar is blank
				definition = vardefault;	// set the default
			else
				definition = getcvar(varname);
			break;
	}

	// if it's a number, with a minimum, that violates the parameter
	if((type == "int" || type == "float") && definition < min)
		definition = min;

	// if it's a number, with a maximum, that violates the parameter
	if((type == "int" || type == "float") && definition > max)
		definition = max;

	return definition;
}

GetRandomMapRotation()
{
	return GetMapRotation(true, false, undefined);
}

GetMapRotation(random, current, number)
{
	maprot = "";

	if(!isdefined(number))
		number = 0;

	// Get current maprotation
	if(current)
		maprot = strip(getcvar("sv_maprotationcurrent"));	

	// Get maprotation if current empty or not the one we want
	if(level.zn_debug) iprintln("(cvar)maprot: " + getcvar("sv_maprotation").size);
	if(maprot == "")
		maprot = strip(getcvar("sv_maprotation"));	
	if(level.zn_debug) iprintln("(var)maprot: " + maprot.size);

	// No map rotation setup!
	if(maprot == "")
		return undefined;
	
	// Explode entries into an array
//	temparr2 = explode(maprot," ");
	j=0;
	temparr2[j] = "";	
	for(i=0;i<maprot.size;i++)
	{
		if(maprot[i]==" ")
		{
			j++;
			temparr2[j] = "";
		}
		else
			temparr2[j] += maprot[i];
	}

	// Remove empty elements (double spaces)
	temparr = [];
	for(i=0;i<temparr2.size;i++)
	{
		element = strip(temparr2[i]);
		if(element != "")
		{
			if(level.zn_debug) iprintln("maprot" + temparr.size + ":" + element);
			temparr[temparr.size] = element;
		}
	}

	// Spawn entity to hold the array
	maps = [];
	lastexec = undefined;
	lastjeep = undefined;
	lasttank = undefined;
	lastgt = getcvar("g_gametype");
	for(i=0;i<temparr.size;)
	{
		switch(temparr[i])
		{
			case "allow_jeeps":
				if(isdefined(temparr[i+1]))
					lastjeep = temparr[i+1];
				i += 2;
				break;

			case "allow_tanks":
				if(isdefined(temparr[i+1]))
					lasttank = temparr[i+1];
				i += 2;
				break;
	
			case "exec":
				if(isdefined(temparr[i+1]))
					lastexec = temparr[i+1];
				i += 2;
				break;

			case "gametype":
				if(isdefined(temparr[i+1]))
					lastgt = temparr[i+1];
				i += 2;
				break;

			case "map":
				if(isdefined(temparr[i+1]))
				{
					maps[maps.size]["exec"]		= lastexec;
					maps[maps.size-1]["jeep"]	= lastjeep;
					maps[maps.size-1]["tank"]	= lasttank;
					maps[maps.size-1]["gametype"]	= lastgt;
					maps[maps.size-1]["map"]	= temparr[i+1];
				}
				// Only need to save this for random rotations
				if(!random)
				{
					lastexec = undefined;
					lastjeep = undefined;
					lasttank = undefined;
					lastgt = undefined;
				}

				i += 2;
				break;

			// If code get here, then the maprotation is corrupt so we have to fix it
			default:
				iprintlnbold("Error in map rotation");
	
				if(isGametype(temparr[i]))
					lastgt = temparr[i];
				else if(isConfig(temparr[i]))
					lastexec = temparr[i];
				else
				{
					maps[maps.size]["exec"]		= lastexec;
					maps[maps.size-1]["jeep"]	= lastjeep;
					maps[maps.size-1]["tank"]	= lasttank;
					maps[maps.size-1]["gametype"]	= lastgt;
					maps[maps.size-1]["map"]	= temparr[i];
	
					// Only need to save this for random rotations
					if(!random)
					{
						lastexec = undefined;
						lastjeep = undefined;
						lasttank = undefined;
						lastgt = undefined;
					}
				}
					

				i += 1;
				break;
		}
		if(number && maps.size >= number)
			break;
	}

	if(random)
	{
		// Shuffle the array 20 times
		for(k = 0; k < 20; k++)
		{
			for(i = 0; i < maps.size; i++)
			{
				j = randomInt(maps.size);
				element = maps[i];
				maps[i] = maps[j];
				maps[j] = element;
			}
		}
	}

	return maps;
}

isGametype(gt)
{
	switch(gt)
	{
		case "dm":
		case "tdm":
		case "sd":
		case "re":
		case "hq":
		case "bel":
		case "bas":
		case "dom":
		case "ctf":
		case "ter":
		case "actf":
		case "lts":
		case "lms":
		case "cnq":
		case "rsd":
		case "tdom":
		case "ad":
		case "htf":
		case "ihtf":
		case "stop":
// La Truffe ->
		case "vip" :
		case "ehq" :
		case "ctfb" :
		case "ectf" :
		case "hm" :
		case "esd" :
// La Truffe <-
		case "asn":

		case "mc_dm":
		case "mc_tdm":
		case "mc_sd":
		case "mc_re":
		case "mc_hq":
		case "mc_bel":
		case "mc_bas":
		case "mc_dom":
		case "mc_ctf":
		case "mc_ter":
		case "mc_actf":
		case "mc_lts":
		case "mc_lms":
		case "mc_cnq":
		case "mc_rsd":
		case "mc_tdom":
		case "mc_ad":
		case "mc_htf":
		case "mc_ihtf":
		case "mc_asn":

			return true;

		default:
			return false;
	}
}

isConfig(cfg)
{
	temparr = explode(cfg,".");
	if(temparr.size == 2 && temparr[1] == "cfg")
		return true;
	else
		return false;
}

spawnSpectator(origin, angles)
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	// Stop shellshock and rumble
	self stopShellshock();
	self stoprumble("damage_heavy");

	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;

	if(self.pers["team"] == "spectator")
		self.statusicon = "";

	maps\mp\gametypes\_spectating::setSpectatePermissions();
	
	if(isDefined(origin) && isDefined(angles))
		self spawn(origin, angles);
	else
	{
         	spawnpointname = "mp_global_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
	
		if(isDefined(spawnpoint))
			self spawn(spawnpoint.origin, spawnpoint.angles);
		else
			maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	}
}

getGametypeName(gt)
{
	switch(gt)
	{
		case "dm":
		case "mc_dm":
			gtname = "Deathmatch";
			break;

		case "stop":
			gtname = "Verstoppertje";
			break;
		
		case "lms":
		case "mc_lms":
			gtname = "Last Man Standing";
			break;
		
		case "ihtf":
		case "mc_ihtf":
			gtname = "Individual Hold The Flag";
			break;
		
		case "tdm":
		case "mc_tdm":
			gtname = "Team Deathmatch";
			break;

		case "sd":
		case "mc_sd":
			gtname = "Search & Destroy";
			break;

		case "re":
		case "mc_re":
			gtname = "Retrieval";
			break;

		case "hq":
		case "mc_hq":
			gtname = "Headquarters";
			break;

		case "bel":
		case "mc_bel":
			gtname = "Behind Enemy Lines";
			break;
		
		case "cnq":
		case "mc_cnq":
			gtname = "Conquest TDM";
			break;

		case "lts":
		case "mc_lts":
			gtname = "Last Team Standing";
			break;

		case "ctf":
		case "mc_ctf":
			gtname = "Capture The Flag";
			break;

		case "dom":
		case "mc_dom":
			gtname = "Domination";
			break;

		case "ad":
		case "mc_ad":
			gtname = "Attack and Defend";
			break;

		case "bas":
		case "mc_bas":
			gtname = "Base assault";
			break;

		case "actf":
		case "mc_actf":
			gtname = "AWE Capture The Flag";
			break;

		case "htf":
		case "mc_htf":
			gtname = "Hold The Flag";
			break;

		case "ter":
		case "mc_ter":
			gtname = "Territory";
			break;

		case "asn":
		case "mc_asn":
			gtname = "Assassin";
			break;

		case "mc_tdom":
			gtname = "Team Domination";
			break;
		
// La Truffe ->
		case "vip" :
			gtname = "V.I.P.";
			break;
		
		case "ehq" :
			gtname = "Enhanced Headquarters";
			break;
		
		case "ctfb" :
			gtname = "Capture The Flag Back";
			break;
		
		case "ectf" :
			gtname = "Enhanced Capture The Flag";
			break;

		case "hm" :
			gtname = "Hitman";
			break;

		case "esd" :
			gtname = "Enhanced Search and Destroy";
			break;

		case "zom" :
			gtname = "^1Zombie";
			break;
// La Truffe <-

		default:
			gtname = gt;
			break;
	}

	return gtname;
}

getLocMapName(map)
{
	switch(map)
	{
		case "mp_farmhouse":
			mapname = &"Beltot";
			break;

		case "mp_brecourt":
			mapname = &"Brecourt";
			break;

		case "mp_burgundy":
			mapname = &"Burgundy";
			break;
		
		case "mp_trainstation":
			mapname = &"Caen";
			break;

		case "mp_carentan":
			mapname = &"Carentan";
			break;

		case "mp_decoy":
			mapname = &"El Alamein";
			break;

		case "mp_leningrad":
			mapname = &"Leningrad";
			break;
		
		case "mp_matmata":
			mapname = &"Matmata";
			break;
		
		case "mp_downtown":
			mapname = &"Moscow";
			break;
		
		case "mp_harbor":
			mapname = &"Rostov";
			break;
		
		case "mp_dawnville":
			mapname = &"St. Mere Eglise";
			break;

		case "mp_railyard":
			mapname = &"Stalingrad";
			break;

		case "mp_toujane":
			mapname = &"Toujane";
			break;
		
		case "mp_breakout":
			mapname = &"Villers-Bocage";
			break;

		case "mp_rhine":
			mapname = &"Wallendar";
			break;

		case "mp_center":
			mapname = &"Center";
			break;

		case "mp_urban":
			mapname = &"^2Urban ^2City^7";
			break;

		case "mp_bsf_arena":
			mapname = &"^2B^7S^2F ^7Ar^2e^7na^7";
			break;

		case "mp_phantomcemetery":
			mapname = &"^6P^9hantom ^6C^9emetery^7";
			break;

		case "mp_zombiemania":
			mapname = &"^7Zombie^9Mania^7";
			break;

		case "mp_xyzzbeta":
			mapname = &"xyzz BETA";
			break;

		case "mp_zn_snow":
			mapname = &"^7[^4ZN^7] Snow^7";
			break;

		case "mp_zinvade":
			mapname = &"Zombie Invade";
			break;

		case "mp_household":
			mapname = &"Zombie Household";
			break;

		case "mp_zn_house":
			mapname = &"[^4Z^7N] House";
			break;

		case "mp_bodesteinv2":
			mapname = &"Bodestein V2";
			break;

		case "mp_gangzap":
			mapname = &"Gangzap";
			break;

		case "mp_loopbruggenland":
			mapname = &"Loopbruggenland";
			break;

		case "mp_questie_v4":
			mapname = &"Questie v4";
			break;

		case "mp_undertrad":
			mapname = &"Undertrad";
			break;

		case "mp_zombie_doos":
			mapname = &"Zombie Doos";
			break;

		case "mp_zomvladom":
			mapname = &"Zom Vladom";
			break;

		case "mp_govas":
			mapname = &"Govas";
			break;

		case "mp_trofsta":
			mapname = &"Trofsta";
			break;

		case "mp_zombiezone_v3":
			mapname = &"Zombie Zone V3";
			break;

		case "mp_28years":
			mapname = &"28 years";
			break;

		case "mp_spaceexpo_east":
			mapname = &"Space Expo East";
			break;

		case "mp_zn_bunker":
			mapname = &"^4[^7ZN^4] ^7Bunker";
			break;

		case "mp_zn_underground_v2":
			mapname = &"^7[^4ZN^7] ^4U^7nderground ^1V2^7";
			break;

		case "mp_nationbox_v2":
			mapname = &"^4Nation^9B^4o^9X v2^7";
			break;

		case "mp_area_x":
			mapname = &"Area X";
			break;

		case "mp_znhq":
			mapname = &"Zombie Nation HQ";
			break;

		case "mp_zombie_dam":
			mapname = &"Zombie Dam";
			break;

		case "mp_untoten_v2":
			mapname = &"Nacht Der Untoten";
			break;

		case "mp_twin_towers_real":
			mapname = &"Twin Towers";
			break;

		case "mp_supermario":
			mapname = &"^1S^7up^4e^7r^1M^7ari^3o ^23D";
			break;

		case "mp_gob_wtf":
			mapname = &":[GOB]: WTF?!";
			break;

		case "mp_tower":
			mapname = &"The Tower";
			break;

		case "mp_zn_hideout":
			mapname = &"^4[^7ZN^4] ^7Hideout";
			break;

		case "mp_naout":
			mapname = &"North Africa, Outpost";
			break;

		case "mp_box2_v2":
			mapname = &"^3Box2 V2";
			break;

		case "mp_industry":
			mapname = &"Industry";
			break;

		case "mp_zombie_icehockey":
			mapname = &"^1Z^9ombie ^5Ice-hockey";
			break;

		case "mp_zombie_jailv3":
			mapname = &"Zombie JAILV3";	
			break;

		case "mp_zombieprison_v5":
			mapname = &"^1Z^7ombie ^1P^7rison ^5W^7inter";	
			break;

		case "mp_elevation_v2":
			mapname = &"Elevation Version 2";	
			break;

		case "mp_ug_deadbox":
			mapname = &"^9Ug^2.^7Deadbox";	
			break;

		case "mp_tierra_hostil":
			mapname = &"Tierra Hostil";	
			break;

		case "mp_zombox_final":
			mapname = &"^5Z^7ombox ^5F^7inal";
			break;

		case "mp_tcheadquarters":
			mapname = &"Turkish Cyber HQ";
			break;

		case "mp_area50_test":
			mapname = &"^3Area 50";
			break;

		case "mp_zn_ultimate":
			mapname = &"^4[^7ZN^4] ^7Ultimate";
			break;

		case "mp_s_i_m":
			mapname = &"^7S I M";
			break;
	
		case "mp_zomyellow":
			mapname = &"^7Zom^3Yellow";
			break;

		case "mp_juxble":
			mapname = &"^7Jux^9Ble";
			break;

		case "mp_tierra_hostil_v2":
			mapname = &"Tierra Hostil V2";
			break;

		case "mp_jara":
			mapname = &"Jara V2";
			break;

		case "mp_castle":
			mapname = &"The Great Castle";
			break;

		case "mp_ze_poison":
			mapname = &"[Z^5E^7] Poison";
			break;

		case "mp_ze_citystreets":
			mapname = &"[^5Z^7E] City Streets^5.";
			break;

		case "mp_factory":
			mapname = &"Factory";
			break;

		case "mp_v2":
			mapname = &"V2";
			break;

		case "mp_zomhunt":
			mapname = &"Zombie ^3Hunt^7.";
			break;


		case "mp_lionscage":
			mapname = &"Lions Cage";
			break;

		case "mp_powcamp":
			mapname = &"Powcamp";
			break;

		case "mp_zn_armybase":
			mapname = &"^4[^7ZN^4] ^7Army Base";
			break;

		case "mp_zombie_dam_v2":
			mapname = &"Zombie Dam V2";
			break;

		case "mp_zn_arena":
			mapname = &"^4[^7ZN^4]^7Arena";
			break;

		case "mp_hb":
			mapname = &"^1H^9b";
			break;

		case "pyramid_tower":
			mapname = &"^3Pyra^2mid ^7Tower";
			break;

		case "mp_zom_dv":
			mapname = &"Destroyed Village Zombie";
			break;

		case "mp_devilscreek":
			mapname = &"Devils Creek";
			break;

		case "mp_tigertown":
			mapname = &"^0-=|^3Tiger^0|=- ^3T^0own";
			break;

		case "mp_zn_coca":
			mapname = &"^4[^7ZN^4]^7COCA^1<3";
			break;

		case "rnr_murmansk":
			mapname = &"Murmansk";
			break;

		case "mp_pit":
			mapname = &"The ^4P^0it";
			break;

		case "mp_redfeild_v2":
			mapname = &"^1Ruins v2";
			break;
		
		case "mp_zom_arena":
			mapname = &"^3Zombie Arena";
			break;

		case "mp_zom_windmill":
			mapname = &"The Wind Mill beta";
			break;

		case "mp_alienscape_v1":
			mapname = &"Alienscape V1";
			break;

		case "mp_blokus":
			mapname = &"Blokus";
			break;

		case "mp_eno8":
			mapname = &"^4Etape ^5NumérO^18";
			break;

		case "mp_mechanica":
			mapname = &"Mechanica";
			break;

		case "mp_supermarioww":
			mapname = &"^1S^7up^4e^7r^1M^7ari^3o ^23D ^7Winter Wonder";
			break;

		case "mp_zomfortress":
			mapname = &"Zom ^9Fortress";
			break;

		case "mp_zombieprison_west":
			mapname = &"^1Z^7ombie ^1P^7rison ^1W^7est";
			break;

		default:
			mapname = &"Unknown Map";
			break;
	}

	return mapname;
}

getMapName(map)
{
	switch(map)
	{
		case "mp_farmhouse":
			mapname = "Beltot";
			break;

		case "mp_brecourt":
			mapname = "Brecourt";
			break;

		case "mp_burgundy":
			mapname = "Burgundy";
			break;
		
		case "mp_trainstation":
			mapname = "Caen";
			break;

		case "mp_carentan":
			mapname = "Carentan";
			break;

		case "mp_decoy":
			mapname = "El Alamein";
			break;

		case "mp_leningrad":
			mapname = "Leningrad";
			break;
		
		case "mp_matmata":
			mapname = "Matmata";
			break;
		
		case "mp_downtown":
			mapname = "Moscow";
			break;
		
		case "mp_harbor":
			mapname = "Rostov";
			break;
		
		case "mp_dawnville":
			mapname = "St. Mere Eglise";
			break;

		case "mp_railyard":
			mapname = "Stalingrad";
			break;

		case "mp_toujane":
			mapname = "Toujane";
			break;
		
		case "mp_breakout":
			mapname = "Villers-Bocage";
			break;

		case "mp_rhine":
			mapname = "Wallendar";
			break;

		case "mp_center":
			mapname = "Center";
			break;

		case "mp_urban":
			mapname = "^2Urban ^2City^7";
			break;

		case "mp_bsf_arena":
			mapname = "^2B^7S^2F ^7Ar^2e^7na^7";
			break;

		case "mp_phantomcemetery":
			mapname = "^6P^9hantom ^6C^9emetery^7";
			break;

		case "mp_zombiemania":
			mapname = "^7Zombie^9Mania^7";
			break;

		case "mp_xyzzbeta":
			mapname = "xyzz BETA";
			break;

		case "mp_zn_snow":
			mapname = "^7[^4ZN^7] Snow^7";
			break;

		case "mp_zinvade":
			mapname = "Zombie Invade";
			break;

		case "mp_household":
			mapname = "Zombie Household";
			break;

		case "mp_zn_house":
			mapname = "[^4Z^7N] House";
			break;

		case "mp_bodesteinv2":
			mapname = "Bodestein V2";
			break;

		case "mp_gangzap":
			mapname = "Gangzap";
			break;

		case "mp_loopbruggenland":
			mapname = "Loopbruggenland";
			break;

		case "mp_questie_v4":
			mapname = "Questie v4";
			break;

		case "mp_undertrad":
			mapname = "Undertrad";
			break;

		case "mp_zombie_doos":
			mapname = "Zombie Doos";
			break;

		case "mp_zomvladom":
			mapname = "Zom Vladom";
			break;

		case "mp_govas":
			mapname = "Govas";
			break;

		case "mp_trofsta":
			mapname = "Trofsta";
			break;

		case "mp_zombiezone_v3":
			mapname = "Zombie Zone V3";
			break;

		case "mp_28years":
			mapname = "28 years";
			break;

		case "mp_spaceexpo_east":
			mapname = "Space Expo East";
			break;

		case "mp_zn_bunker":
			mapname = "^4[^7ZN^4] ^7Bunker";
			break;

		case "mp_zn_underground_v2":
			mapname = "^7[^4ZN^7] ^4U^7nderground ^1V2^7";
			break;

		case "mp_nationbox_v2":
			mapname = "^4Nation^9B^4o^9X v2^7";
			break;

		case "mp_area_x":
			mapname = "Area X";
			break;

		case "mp_znhq":
			mapname = "Zombie Nation HQ";
			break;

		case "mp_zombie_dam":
			mapname = "Zombie Dam";
			break;

		case "mp_untoten_v2":
			mapname = "Nacht Der Untoten";
			break;

		case "mp_twin_towers_real":
			mapname = "Twin Towers";
			break;

		case "mp_supermario":
			mapname = "^1S^7up^4e^7r^1M^7ari^3o ^23D";
			break;

		case "mp_gob_wtf":
			mapname = ":[GOB]: WTF?!";
			break;

		case "mp_tower":
			mapname = "The Tower";
			break;

		case "mp_zn_hideout":
			mapname = "^4[^7ZN^4] ^7Hideout";
			break;

		case "mp_zn_ultimate":
			mapname = "^4[^7ZN^4] ^7Ultimate";
			break;

		case "mp_s_i_m":
			mapname = "^7S I M";
			break;
	
		case "mp_zomyellow":
			mapname = "^7Zom^3Yellow";
			break;

		case "mp_naout":
			mapname = "North Africa, Outpost";
			break;

		case "mp_box2_v2":
			mapname = "^3Box2 V2";
			break;

		case "mp_industry":
			mapname = "Industry";
			break;

		case "mp_zombie_icehockey":
			mapname = "^1Z^9ombie ^5Ice-hockey";
			break;

		case "mp_zombie_jailv3":
			mapname = "Zombie JAILV3";	
			break;

		case "mp_zombieprison_v5":
			mapname = "^1Z^7ombie ^1P^7rison ^5W^7inter";	
			break;

		case "mp_elevation_v2":
			mapname = "Elevation Version 2";	
			break;

		case "mp_ug_deadbox":
			mapname = "^9Ug^2.^7Deadbox";	
			break;

		case "mp_tierra_hostil":
			mapname = "Tierra Hostil";	
			break;

		case "mp_zombox_final":
			mapname = "^5Z^7ombox ^5F^7inal";
			break;

		case "mp_tcheadquarters":
			mapname = "Turkish Cyber HQ";
			break;

		case "mp_area50_test":
			mapname = "^3Area 50";
			break;

		case "mp_juxble":
			mapname = "^7Jux^9Ble";
			break;

		case "mp_tierra_hostil_v2":
			mapname = "Tierra Hostil V2";
			break;


		case "mp_jara":
			mapname = "Jara V2";
			break;

		case "mp_castle":
			mapname = "The Great Castle";
			break;

		case "mp_ze_poison":
			mapname = "[Z^5E^7] Poison";
			break;

		case "mp_ze_citystreets":
			mapname = "[^5Z^7E] City Streets^5.";
			break;

		case "mp_factory":
			mapname = "Factory";
			break;

		case "mp_v2":
			mapname = "V2";
			break;

		case "mp_zomhunt":
			mapname = "Zombie ^3Hunt^7.";
			break;

		case "mp_lionscage":
			mapname = "Lions Cage";
			break;

		case "mp_powcamp":
			mapname = "Powcamp";
			break;

		case "mp_zn_armybase":
			mapname = "^4[^7ZN^4] ^7Army Base";
			break;

		case "mp_zombie_dam_v2":
			mapname = "Zombie Dam V2";
			break;

		case "mp_zn_arena":
			mapname = "^4[^7ZN^4]^7Arena";
			break;

		case "mp_hb":
			mapname = "^1H^9b";
			break;

		case "pyramid_tower":
			mapname = "^3Pyra^2mid ^7Tower";
			break;

		case "mp_zom_dv":
			mapname = "Destroyed Village Zombie";
			break;

		case "mp_devilscreek":
			mapname = "Devils Creek";
			break;

		case "mp_tigertown":
			mapname = "^0-=|^3Tiger^0|=- ^3T^0own";
			break;

		case "mp_zn_coca":
			mapname = "^4[^7ZN^4]^7COCA^1<3";
			break;

		case "rnr_murmansk":
			mapname = "Murmansk";
			break;

		case "mp_pit":
			mapname = "The ^4P^0it";
			break;

		case "mp_redfeild_v2":
			mapname = "^1Ruins v2";
			break;
		
		case "mp_zom_arena":
			mapname = "^3Zombie Arena";
			break;

		case "mp_zom_windmill":
			mapname = "The Wind Mill beta";
			break;

		case "mp_alienscape_v1":
			mapname = "Alienscape V1";
			break;

		case "mp_blokus":
			mapname = "Blokus";
			break;

		case "mp_eno8":
			mapname = "^4Etape ^5NumérO^18";
			break;

		case "mp_mechanica":
			mapname = "Mechanica";
			break;

		case "mp_supermarioww":
			mapname = "^1S^7up^4e^7r^1M^7ari^3o ^23D ^7Winter Wonder";
			break;

		case "mp_zomfortress":
			mapname = "Zom ^9Fortress";
			break;

		case "mp_zombieprison_west":
			mapname = "^1Z^7ombie ^1P^7rison ^1W^7est";
			break;

		default:
		    // Strip mp_ prefix
		    if(getsubstr(map,0,3) == "mp_")
				mapname = getsubstr(map,3);
			else
				mapname = map;
			// Change underscores to space and make words capitalized
			tmp = "";
			from = "abcdefghijklmnopqrstuvwxyz";
		    to   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		    nextisuppercase = true;
			for(i=0;i<mapname.size;i++)
			{
				if(mapname[i] == "_")
				{
					tmp += " ";
					nextisuppercase = true;
				}
				else if (nextisuppercase)
				{
					found = false;
					for(j = 0; j < from.size; j++)
					{
						if(mapname[i] == from[j])
						{
							tmp += to[j];
							found = true;
							break;
						}
					}
					
					if(!found)
						tmp += mapname[i];
					nextisuppercase = false;
				}
				else
					tmp += mapname[i];
			}
			// Change postfixes like B1 to Beta1
			if((getsubstr(tmp,tmp.size-2)[0] == "B")&&(issubstr("0123456789",getsubstr(tmp,tmp.size-1))))
				mapname = getsubstr(tmp,0,tmp.size-2)+"Beta"+getsubstr(tmp,tmp.size-1);
			else
				mapname = tmp;
			break;
	}

	return mapname;
}

// Strip blanks at start and end of string
strip(s)
{
	if(s=="")
		return "";

	s2="";
	s3="";

	i=0;
	while(i<s.size && s[i]==" ")
		i++;

	// String is just blanks?
	if(i==s.size)
		return "";
	
	for(;i<s.size;i++)
	{
		s2 += s[i];
	}

	i=s2.size-1;
	while(s2[i]==" " && i>0)
		i--;

	for(j=0;j<=i;j++)
	{
		s3 += s2[j];
	}
		
	return s3;
}

explode(s,delimiter)
{
	j=0;
	temparr[j] = "";	

	for(i=0;i<s.size;i++)
	{
		if(s[i]==delimiter)
		{
			j++;
			temparr[j] = "";
		}
		else
			temparr[j] += s[i];
	}
	return temparr;
}

iprintlnFIXED (locstring, player, target)
{
	if (IsLinuxServer ())
	{
		if (isdefined (target))
			target iprintln (locstring, player.name);
		else
			iprintln (locstring, player.name);
	}
	else
	{
		if (isdefined (target))
			target iprintln (locstring, player);
		else
			iprintln (locstring, player);
	}
}

iprintlnboldFIXED (locstring, player, target)
{
	if (IsLinuxServer ())
	{
		if (isdefined (target))
			target iprintlnbold (locstring, player.name);
		else
			iprintlnbold (locstring, player.name);
	}
	else
	{
		if (isdefined (target))
			target iprintlnbold (locstring, player);
		else
			iprintlnbold (locstring, player);
	}
}

IsLinuxServer ()
{
	if (! isdefined (level.IsLinuxServer))
	{
		version = getcvar ("version");
		endstr = "";
		for (i = 0; i < 7; i ++)
			endstr += version[i + version.size - 7];
		level.IsLinuxServer = (endstr != "win-x86");
	}
	
	return (level.IsLinuxServer);
}