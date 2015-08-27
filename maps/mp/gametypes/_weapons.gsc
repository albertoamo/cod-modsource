#include maps\mp\_utility;

init()
{
	// allies
	precacheItem("rpd_mp");
	precacheItem("ak47_mp");
	precacheItem("barret_mp");
	precacheItem("winchester_mp");
	precacheItem("sig_mp");
	precacheItem("tesla_mp");
	precacheItem("ak74_mp");
	precacheItem("g36_mp");
	precacheItem("uzi_mp");
	precacheItem("remington_mp");
	precacheItem("benelli_mp");
	precacheItem("m14_mp");
	precacheItem("m14_scoped_mp");

	// on rank
	precacheItem("p90_mp");
	precacheItem("scout_mp");
	precacheItem("mosberg_mp");
	precacheItem("crossbow_mp");

	// axis
	precacheItem("axe_mp");
	precacheItem("basbat_mp");
	precacheItem("katana_mp");
	precacheItem("bowie_mp");
	precacheItem("crowbar_mp");
     	precacheItem("bodypart_mp");
	precacheItem("zomknife_mp");
	
	precacheItem("binoculars_mp");

	level.weaponnames = [];
	level.weaponnames[0] = "fraggrenade";
	level.weaponnames[1] = "smokegrenade";
     	level.weaponnames[2] = "ak47_mp";
	level.weaponnames[3] = "ak74_mp";
	level.weaponnames[4] = "g36_mp";
	level.weaponnames[5] = "uzi_mp";
	level.weaponnames[6] = "sig_mp";
	level.weaponnames[7] = "m14_mp";
	level.weaponnames[8] = "m14_scoped_mp";
	level.weaponnames[9] = "remington_mp";
	level.weaponnames[10] = "barret_mp";
	level.weaponnames[11] = "benelli_mp";
	level.weaponnames[12] = "winchester_mp";
     	level.weaponnames[13] = "rpd_mp";
     	level.weaponnames[14] = "axe_mp";
	level.weaponnames[15] = "basbat_mp";
	level.weaponnames[16] = "katana_mp";
	level.weaponnames[17] = "bowie_mp";
	level.weaponnames[18] = "crowbar_mp";
	level.weaponnames[19] = "tesla_mp";
	level.weaponnames[20] = "p90_mp";
	level.weaponnames[21] = "scout_mp";
	level.weaponnames[22] = "crossbow_mp";
	level.weaponnames[23] = "mosberg_mp";
	level.weaponnames[24] = "zomknife_mp";

	level.weapons = [];

	level.weapons["ak47_mp"] = spawnstruct();
	level.weapons["ak47_mp"].server_allowcvar = "scr_allow_ak47";
	level.weapons["ak47_mp"].client_allowcvar = "ui_allow_ak47";
	level.weapons["ak47_mp"].allow_default = 1;

	level.weapons["ak74_mp"] = spawnstruct();
	level.weapons["ak74_mp"].server_allowcvar = "scr_allow_ak74";
	level.weapons["ak74_mp"].client_allowcvar = "ui_allow_ak74";
	level.weapons["ak74_mp"].allow_default = 1;

	level.weapons["g36_mp"] = spawnstruct();
	level.weapons["g36_mp"].server_allowcvar = "scr_allow_g36";
	level.weapons["g36_mp"].client_allowcvar = "ui_allow_g36";
	level.weapons["g36_mp"].allow_default = 1;

	level.weapons["uzi_mp"] = spawnstruct();
	level.weapons["uzi_mp"].server_allowcvar = "scr_allow_uzi";
	level.weapons["uzi_mp"].client_allowcvar = "ui_allow_uzi";
	level.weapons["uzi_mp"].allow_default = 1;

	level.weapons["sig_mp"] = spawnstruct();
	level.weapons["sig_mp"].server_allowcvar = "scr_allow_sig";
	level.weapons["sig_mp"].client_allowcvar = "ui_allow_sig";
	level.weapons["sig_mp"].allow_default = 1;

	level.weapons["m14_mp"] = spawnstruct();
	level.weapons["m14_mp"].server_allowcvar = "scr_allow_m14";
	level.weapons["m14_mp"].client_allowcvar = "ui_allow_m14";
	level.weapons["m14_mp"].allow_default = 1;

	level.weapons["m14_scoped_mp"] = spawnstruct();
	level.weapons["m14_scoped_mp"].server_allowcvar = "scr_allow_m14_scoped";
	level.weapons["m14_scoped_mp"].client_allowcvar = "ui_allow_m14_scoped";
	level.weapons["m14_scoped_mp"].allow_default = 1;

	level.weapons["remington_mp"] = spawnstruct();
	level.weapons["remington_mp"].server_allowcvar = "scr_allow_remington";
	level.weapons["remington_mp"].client_allowcvar = "ui_allow_remington";
	level.weapons["remington_mp"].allow_default = 1;

	level.weapons["barret_mp"] = spawnstruct();
	level.weapons["barret_mp"].server_allowcvar = "scr_allow_barret";
	level.weapons["barret_mp"].client_allowcvar = "ui_allow_barret";
	level.weapons["barret_mp"].allow_default = 1;

	level.weapons["benelli_mp"] = spawnstruct();
	level.weapons["benelli_mp"].server_allowcvar = "scr_allow_benelli";
	level.weapons["benelli_mp"].client_allowcvar = "ui_allow_benelli";
	level.weapons["benelli_mp"].allow_default = 1;
	level.weapons["benelli_mp"].maxlimit = 4;
	level.weapons["benelli_mp"].usagecount = 0;

	level.weapons["winchester_mp"] = spawnstruct();
	level.weapons["winchester_mp"].server_allowcvar = "scr_allow_winchester";
	level.weapons["winchester_mp"].client_allowcvar = "ui_allow_winchester";
	level.weapons["winchester_mp"].allow_default = 1;
	level.weapons["winchester_mp"].maxlimit = 3;
	level.weapons["winchester_mp"].usagecount = 0;

	level.weapons["rpd_mp"] = spawnstruct();
	level.weapons["rpd_mp"].server_allowcvar = "scr_allow_rpd";
	level.weapons["rpd_mp"].client_allowcvar = "ui_allow_rpd";
	level.weapons["rpd_mp"].allow_default = 1;

      	level.weapons["axe_mp"] = spawnstruct();
	level.weapons["axe_mp"].server_allowcvar = "scr_allow_axe";
	level.weapons["axe_mp"].client_allowcvar = "ui_allow_axe";
	level.weapons["axe_mp"].allow_default = 1;

	level.weapons["basbat_mp"] = spawnstruct();
	level.weapons["basbat_mp"].server_allowcvar = "scr_allow_basbat";
	level.weapons["basbat_mp"].client_allowcvar = "ui_allow_basbat";
	level.weapons["basbat_mp"].allow_default = 1;

     	level.weapons["katana_mp"] = spawnstruct();
	level.weapons["katana_mp"].server_allowcvar = "scr_allow_katana";
	level.weapons["katana_mp"].client_allowcvar = "ui_allow_katana";
	level.weapons["katana_mp"].allow_default = 1;

	level.weapons["bowie_mp"] = spawnstruct();
	level.weapons["bowie_mp"].server_allowcvar = "scr_allow_bowie";
	level.weapons["bowie_mp"].client_allowcvar = "ui_allow_bowie";
	level.weapons["bowie_mp"].allow_default = 1;

	level.weapons["crowbar_mp"] = spawnstruct();
	level.weapons["crowbar_mp"].server_allowcvar = "scr_allow_crowbar";
	level.weapons["crowbar_mp"].client_allowcvar = "ui_allow_crowbar";
	level.weapons["crowbar_mp"].allow_default = 1;

	level.weapons["shotgun_mp"] = spawnstruct();
	level.weapons["shotgun_mp"].server_allowcvar = "scr_allow_shotgun";
	level.weapons["shotgun_mp"].client_allowcvar = "ui_allow_shotgun";
	level.weapons["shotgun_mp"].allow_default = 1;

	level.weapons["tesla_mp"] = spawnstruct();
	level.weapons["tesla_mp"].server_allowcvar = "scr_allow_tesla";
	level.weapons["tesla_mp"].client_allowcvar = "ui_allow_tesla";
	level.weapons["tesla_mp"].allow_default = 1;
	level.weapons["tesla_mp"].rank = 198;
	level.weapons["tesla_mp"].maxrank = 199;
	level.weapons["tesla_mp"].power = 1000;
	level.weapons["tesla_mp"].maxlimit = 2;
	level.weapons["tesla_mp"].usagecount = 0;

	level.weapons["p90_mp"] = spawnstruct();
	level.weapons["p90_mp"].server_allowcvar = "scr_allow_p90";
	level.weapons["p90_mp"].client_allowcvar = "ui_allow_p90";
	level.weapons["p90_mp"].allow_default = 1;
	level.weapons["p90_mp"].rank = 150;

	level.weapons["scout_mp"] = spawnstruct();
	level.weapons["scout_mp"].server_allowcvar = "scr_allow_scout";
	level.weapons["scout_mp"].client_allowcvar = "ui_allow_scout";
	level.weapons["scout_mp"].allow_default = 1;
	level.weapons["scout_mp"].rank = 75;

	level.weapons["crossbow_mp"] = spawnstruct();
	level.weapons["crossbow_mp"].server_allowcvar = "scr_allow_crossbow";
	level.weapons["crossbow_mp"].client_allowcvar = "ui_allow_crossbow";
	level.weapons["crossbow_mp"].allow_default = 1;
	level.weapons["crossbow_mp"].rank = 100;

	level.weapons["mosberg_mp"] = spawnstruct();
	level.weapons["mosberg_mp"].server_allowcvar = "scr_allow_mosberg";
	level.weapons["mosberg_mp"].client_allowcvar = "ui_allow_mosberg";
	level.weapons["mosberg_mp"].allow_default = 1;
	level.weapons["mosberg_mp"].rank = 25;
	level.weapons["mosberg_mp"].maxlimit = 5;
	level.weapons["mosberg_mp"].usagecount = 0;

	level.weapons["zomknife_mp"] = spawnstruct();
	level.weapons["zomknife_mp"].server_allowcvar = "scr_allow_zomknife";
	level.weapons["zomknife_mp"].client_allowcvar = "ui_allow_zomknife";
	level.weapons["zomknife_mp"].allow_default = 1;
	level.weapons["zomknife_mp"].rank = 25;

	level.weapons["fraggrenade"] = spawnstruct();
	level.weapons["fraggrenade"].server_allowcvar = "scr_allow_fraggrenades";
	level.weapons["fraggrenade"].client_allowcvar = "ui_allow_fraggrenades";
	level.weapons["fraggrenade"].allow_default = 0;

	level.weapons["smokegrenade"] = spawnstruct();
	level.weapons["smokegrenade"].server_allowcvar = "scr_allow_smokegrenades";
	level.weapons["smokegrenade"].client_allowcvar = "ui_allow_smokegrenades";
	level.weapons["smokegrenade"].allow_default = 0;

	for(i = 0; i < level.weaponnames.size; i++)
	{
		weaponname = level.weaponnames[i];

		if(getCvar(level.weapons[weaponname].server_allowcvar) == "")
		{
			level.weapons[weaponname].allow = level.weapons[weaponname].allow_default;
			setCvar(level.weapons[weaponname].server_allowcvar, level.weapons[weaponname].allow);
		}
		else
			level.weapons[weaponname].allow = getCvarInt(level.weapons[weaponname].server_allowcvar);
	}

	level thread deleteRestrictedWeapons();
	level thread onPlayerConnect();

	for(;;)
	{
		updateAllowed();
		wait 5;
	}
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);

		player.usedweapons = false;

		player thread updateAllAllowedSingleClient();
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");

		self thread watchWeaponUsage();
	}
}

deleteRestrictedWeapons()
{
	for(i = 0; i < level.weaponnames.size; i++)
	{
		weaponname = level.weaponnames[i];

		//if(level.weapons[weaponname].allow != 1)
			//deletePlacedEntity(level.weapons[weaponname].radiant_name);
	}

	// Need to not automatically give these to players if I allow restricting them
	// colt_mp
	// webley_mp
	// TT30_mp
	// luger_mp
	// fraggrenade_mp
	// mk1britishfrag_mp
	// rgd-33russianfrag_mp
	// stielhandgranate_mp
}

givePistol()
{
	weapon2 = self getweaponslotweapon("primaryb");
	if(weapon2 == "none")
	{
		if(self.pers["team"] == "allies")
		{
			switch(game["allies"])
			{
			case "american":
				pistoltype = "colt_mp";
				break;

			case "british":
				pistoltype = "webley_mp";
				break;

			default:
				assert(game["allies"] == "russian");
				pistoltype = "TT30_mp";
				break;
			}
		}
		else
		{
			assert(self.pers["team"] == "axis");
			switch(game["axis"])
			{
			default:
				assert(game["axis"] == "german");
				pistoltype = "luger_mp";
				break;
			}
		}

		self takeWeapon("colt_mp");
		self takeWeapon("webley_mp");
		self takeWeapon("TT30_mp");
		self takeWeapon("luger_mp");

		//self giveWeapon(pistoltype);
		self setWeaponSlotWeapon("primaryb", pistoltype);
		self giveMaxAmmo(pistoltype);
	}
}

giveGrenades()
{
	if(self.pers["team"] == "allies")
	{
		switch(game["allies"])
		{
		case "american":
			grenadetype = "frag_grenade_american_mp";
			smokegrenadetype = "smoke_grenade_american_mp";
			break;

		case "british":
			grenadetype = "frag_grenade_british_mp";
			smokegrenadetype = "smoke_grenade_british_mp";
			break;

		default:
			assert(game["allies"] == "russian");
			grenadetype = "frag_grenade_russian_mp";
			smokegrenadetype = "smoke_grenade_russian_mp";
			break;
		}
	}
	else
	{
		assert(self.pers["team"] == "axis");
		switch(game["axis"])
		{
		default:
			assert(game["axis"] == "german");
			grenadetype = "frag_grenade_german_mp";
			smokegrenadetype = "smoke_grenade_german_mp";
			break;
		}
	}

	self takeWeapon("frag_grenade_american_mp");
	self takeWeapon("frag_grenade_british_mp");
	self takeWeapon("frag_grenade_russian_mp");
	self takeWeapon("frag_grenade_german_mp");
	self takeWeapon("smoke_grenade_american_mp");
	self takeWeapon("smoke_grenade_british_mp");
	self takeWeapon("smoke_grenade_russian_mp");
	self takeWeapon("smoke_grenade_german_mp");

	if(getcvarint("scr_allow_fraggrenades"))
	{
		fraggrenadecount = getWeaponBasedGrenadeCount(self.pers["weapon"]);
		if(fraggrenadecount)
		{
			self giveWeapon(grenadetype);
			self setWeaponClipAmmo(grenadetype, fraggrenadecount);
		}
	}

	if(getcvarint("scr_allow_smokegrenades"))
	{
		smokegrenadecount = getWeaponBasedSmokeGrenadeCount(self.pers["weapon"]);
		if(smokegrenadecount)
		{
			self giveWeapon(smokegrenadetype);
			self setWeaponClipAmmo(smokegrenadetype, smokegrenadecount);
		}
	}

	if(getcvarint("scr_allow_fraggrenades"))
		self switchtooffhand(grenadetype);
}

giveBinoculars()
{
	self giveWeapon("binoculars_mp");
}

dropWeapon()
{
	current = self getcurrentweapon();
	if(current != "none")
	{
		weapon1 = self getweaponslotweapon("primary");
		weapon2 = self getweaponslotweapon("primaryb");

		if(current == weapon1)
			currentslot = "primary";
		else
		{
			assert(current == weapon2);
			currentslot = "primaryb";
		}

		clipsize = self getweaponslotclipammo(currentslot);
		reservesize = self getweaponslotammo(currentslot);

		if(clipsize || reservesize)
			self dropItem(current);
	}
}

dropOffhand()
{
	current = self getcurrentoffhand();
	if(current != "none")
	{
		ammosize = self getammocount(current);

		if(ammosize)
			self dropItem(current);
	}
}

getWeaponBasedGrenadeCount(weapon)
{
	switch(weapon)
	{
	case "springfield_mp":
	case "enfield_scope_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	case "enfield_mp":
	case "mosin_nagant_mp":
	case "kar98k_mp":
		return 3;
	case "m1carbine_mp":
	case "m1garand_mp":
	case "SVT40_mp":
	case "g43_mp":
	case "bar_mp":
	case "bren_mp":
	case "mp44_mp":
		return 2;
	default:
	case "thompson_mp":
	case "sten_mp":
	case "ppsh_mp":
	case "mp40_mp":
	case "PPS42_mp":
	case "shotgun_mp":
	case "greasegun_mp":
		return 1;
	}
}

getWeaponBasedSmokeGrenadeCount(weapon)
{
	switch(weapon)
	{
	case "thompson_mp":
	case "sten_mp":
	case "ppsh_mp":
	case "mp40_mp":
	case "PPS42_mp":
	case "shotgun_mp":
	case "greasegun_mp":
		return 1;
	case "m1carbine_mp":
	case "m1garand_mp":
	case "enfield_mp":
	case "mosin_nagant_mp":
	case "SVT40_mp":
	case "kar98k_mp":
	case "g43_mp":
	case "bar_mp":
	case "bren_mp":
	case "mp44_mp":
	case "springfield_mp":
	case "enfield_scope_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	default:
		return 0;
	}
}

getFragGrenadeCount()
{
	if(self.pers["team"] == "allies")
		grenadetype = "frag_grenade_" + game["allies"] + "_mp";
	else
	{
		assert(self.pers["team"] == "axis");
		grenadetype = "frag_grenade_" + game["axis"] + "_mp";
	}

	count = self getammocount(grenadetype);
	return count;
}

getSmokeGrenadeCount()
{
	if(self.pers["team"] == "allies")
		grenadetype = "smoke_grenade_" + game["allies"] + "_mp";
	else
	{
		assert(self.pers["team"] == "axis");
		grenadetype = "smoke_grenade_" + game["axis"] + "_mp";
	}

	count = self getammocount(grenadetype);
	return count;
}

isPistol(weapon)
{
	switch(weapon)
	{
	case "colt_mp":
	case "webley_mp":
	case "luger_mp":
	case "TT30_mp":
	case "glock_mp":
		return true;
	default:
		return false;
	}
}

isMainWeapon(weapon)
{
	// Include any main weapons that can be picked up

	switch(weapon)
	{
	case "greasegun_mp":
	case "m1carbine_mp":
	case "m1garand_mp":
	case "thompson_mp":
	case "bar_mp":
	case "springfield_mp":
	case "sten_mp":
	case "enfield_mp":
	case "bren_mp":
	case "enfield_scope_mp":
	case "mosin_nagant_mp":
	case "SVT40_mp":
	case "PPS42_mp":
	case "ppsh_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_mp":
	case "g43_mp":
	case "mp40_mp":
	case "mp44_mp":
	case "kar98k_sniper_mp":
	case "shotgun_mp":
		return true;
	default:
		return false;
	}
}

restrictWeaponByServerCvars(response)
{
	if(isDefined(level.weapons[response]) && isDefined(level.weapons[response].allow) && level.weapons[response].allow == 1 && !reachedWepLimit(response))
	{
		return response;
	}

	return "restricted";
}

reachedWepLimit(response)
{
	if(!isDefined(level.weapons[response].maxlimit) || !isDefined(level.weapons[response].usagecount))
		return false;
	else if(isDefined(level.weapons[response].maxlimit) && isDefined(level.weapons[response].usagecount) && level.weapons[response].usagecount >= level.weapons[response].maxlimit)
		return true;
	else
		return false;
}

// TODO: This doesn't handle offhands
watchWeaponUsage()
{
	self endon("spawned_player");
	self endon("disconnect");

	self.usedweapons = false;

	while(self attackButtonPressed())
		wait .05;

	while(!(self attackButtonPressed()))
		wait .05;

	self.usedweapons = true;
}

getWeaponName2(weapon)
{
	switch(weapon)
	{
	case "ak47_mp":
		weaponname = "^2AK^9-47";
		break;

     	case "ak74_mp":
		weaponname = "^2AK^9-74";
		break;

	case "g36_mp":
		weaponname = "^2G^9-36";
		break;

	case "uzi_mp":
		weaponname = "^2U^9zi";
		break;

	case "sig_mp":
		weaponname = "^2S^9ig";
		break;

	case "m14_mp":
		weaponname = "^2M^914";
		break;

	case "m14_scoped_mp":
		weaponname = "^2M^914 ^2S^9coped";
		break;

      	case "remington_mp":
		weaponname = "^2R^9emington";
		break;

     	case "barret_mp":
		weaponname = "^2B^9arret 50^2.^9Cal";
		break;

	case "benelli_mp":
		weaponname = "^2B^9enelli ^2M^94";
		break;

	case "winchester_mp":
		weaponname = "^2W^9inchester";
		break;

	case "rpd_mp":
		weaponname = "^2R^9pd";
		break;

	case "tesla_mp":
		weaponname = "^2T^9esla";
		break;

	case "p90_mp":
		weaponname = "^2P^990";
		break;

	case "scout_mp":
		weaponname = "^2S^9cout";
		break;

	case "mosberg_mp":
		weaponname = "^2M^9osberg";
		break;

	case "crossbow_mp":
		weaponname = "^2C^9rossbow";
		break;

     	case "axe_mp":
		weaponname = "^2A^9xe";
		break;

	case "basbat_mp":
		weaponname = "^2B^9aseball ^2B^9at";
		break;

	case "katana_mp":
		weaponname = "^2K^9atana";
		break;

	case "bowie_mp":
		weaponname = "^2B^9owie ^2K^9nife";
		break;

	case "crowbar_mp":
		weaponname = "^2C^9rowbar";
		break;

	case "zomknife_mp":
		weaponname = "^2K^9nife";
		break;

	default:
		weaponname = "Unknown Weapon";
		break;
	}

	return weaponname;
}

getWeaponName(weapon)
{
	switch(weapon)
	{
	// American
	case "m1carbine_mp":
		weaponname = &"WEAPON_M1A1CARBINE";
		break;

	case "m1garand_mp":
		weaponname = &"WEAPON_M1GARAND";
		break;

	case "thompson_mp":
		weaponname = &"WEAPON_THOMPSON";
		break;

	case "bar_mp":
		weaponname = &"WEAPON_BAR";
		break;

	case "springfield_mp":
		weaponname = &"WEAPON_SPRINGFIELD";
		break;

	case "greasegun_mp":
		weaponname = &"WEAPON_GREASEGUN";
		break;

	case "ak47_mp":
		weaponname = &"ZWEAPON_AK47";
		break;

     case "ak74_mp":
		weaponname = &"ZWEAPON_AK74";
		break;

	case "g36_mp":
		weaponname = &"ZWEAPON_G36";
		break;

	case "uzi_mp":
		weaponname = &"ZWEAPON_UZI";
		break;

	case "sig_mp":
		weaponname = &"ZWEAPON_SIG";
		break;

	case "m14_mp":
		weaponname = &"ZWEAPON_M14";
		break;

	case "m14_scoped_mp":
		weaponname = &"ZWEAPON_M14_SCOPED";
		break;

      case "remington_mp":
		weaponname = &"ZWEAPON_REMINGTON";
		break;

     case "barret_mp":
		weaponname = &"ZWEAPON_BARRET";
		break;

	case "benelli_mp":
		weaponname = &"ZWEAPON_BENELLI";
		break;

	case "winchester_mp":
		weaponname = &"ZWEAPON_WINCHESTER";
		break;

	case "rpd_mp":
		weaponname = &"ZWEAPON_RPD";
		break;

	case "tesla_mp":
		weaponname = &"ZWEAPON_TESLA";
		break;

	case "p90_mp":
		weaponname = &"ZWEAPON_P90";
		break;

	case "scout_mp":
		weaponname = &"ZWEAPON_SCOUT";
		break;

	case "mosberg_mp":
		weaponname = &"ZWEAPON_MOSBERG";
		break;

	case "crossbow_mp":
		weaponname = &"ZWEAPON_CROSSBOW";
		break;

	case "shotgun_mp":
		weaponname = &"WEAPON_SHOTGUN";
		break;

//	case "30cal_mp":
//		weaponname = &"PI_WEAPON_MP_30CAL";
//		break;

//	case "M9_Bazooka":
//		weaponname = &"PI_WEAPON_MP_BAZOOKA";
//		break;

	// British
	case "enfield_mp":
		weaponname = &"WEAPON_LEEENFIELD";
		break;

	case "sten_mp":
		weaponname = &"WEAPON_STEN";
		break;

	case "bren_mp":
		weaponname = &"WEAPON_BREN";
		break;

	case "enfield_scope_mp":
		weaponname = &"WEAPON_SCOPEDLEEENFIELD";
		break;

	// Russian
	case "mosin_nagant_mp":
		weaponname = &"WEAPON_MOSINNAGANT";
		break;

	case "SVT40_mp":
		weaponname = &"WEAPON_SVT40";
		break;

	case "PPS42_mp":
		weaponname = &"WEAPON_PPS42";
		break;

	case "ppsh_mp":
		weaponname = &"WEAPON_PPSH";
		break;

	case "mosin_nagant_sniper_mp":
		weaponname = &"WEAPON_SCOPEDMOSINNAGANT";
		break;

	//German
	case "kar98k_mp":
		weaponname = &"WEAPON_KAR98K";
		break;

	case "g43_mp":
		weaponname = &"WEAPON_G43";
		break;

	case "mp40_mp":
		weaponname = &"WEAPON_MP40";
		break;

	case "mp44_mp":
		weaponname = &"WEAPON_MP44";
		break;

	case "kar98k_sniper_mp":
		weaponname = &"WEAPON_SCOPEDKAR98K";
		break;

     case "axe_mp":
		weaponname = &"ZWEAPON_AXE";
		break;

	case "basbat_mp":
		weaponname = &"ZWEAPON_BASBAT";
		break;

	case "katana_mp":
		weaponname = &"ZWEAPON_KATANA";
		break;

	case "bowie_mp":
		weaponname = &"ZWEAPON_BOWIE";
		break;

	case "crowbar_mp":
		weaponname = &"ZWEAPON_CROWBAR";
		break;

	case "zomknife_mp":
		weaponname = &"ZWEAPON_ZOMKNIFE";
		break;

//	case "panzerfaust_mp":
//		weaponname = &"WEAPON_PANZERFAUST";
//		break;
//
//	case "panzerschreck_mp":
//		weaponname = &"PI_WEAPON_MP_PANZERSCHRECK";
//		break;
//
//	case "dp28_mp":
//		weaponname = &"PI_WEAPON_MP_DP28";
//		break;

	default:
		weaponname = &"WEAPON_UNKNOWNWEAPON";
		break;
	}

	return weaponname;
}

useAn(weapon)
{
	switch(weapon)
	{
	case "m1carbine_mp":
	case "m1garand_mp":
	case "mp40_mp":
	case "mp44_mp":
	case "shotgun_mp":
	case "axe_mp":
	case "ak47_mp":
	case "ak74_mp":
		result = true;
		break;

	default:
		result = false;
		break;
	}

	return result;
}

updateAllowed()
{
	for(i = 0; i < level.weaponnames.size; i++)
	{
		weaponname = level.weaponnames[i];

		cvarvalue = getCvarInt(level.weapons[weaponname].server_allowcvar);
		if(level.weapons[weaponname].allow != cvarvalue)
		{
			level.weapons[weaponname].allow = cvarvalue;

			thread updateAllowedAllClients(weaponname);
		}
	}
}

updateAllowedAllClients(weaponname)
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		players[i] updateAllowedSingleClient(weaponname);
}

updateAllowedSingleClient(weaponname)
{
	if(isUnlockedWep(weaponname))
	{
		if(reachedWepLimit(weaponname))
		{
			if(isDefined(level.weapons[weaponname].rank))
				self setClientCvar(level.weapons[weaponname].client_allowcvar, 0);
			else
				self setClientCvar(level.weapons[weaponname].client_allowcvar, 2);	
		}
		else
			self setClientCvar(level.weapons[weaponname].client_allowcvar, level.weapons[weaponname].allow);
	}
	else
		self setClientCvar(level.weapons[weaponname].client_allowcvar, 0);		
}

isUnlockedWep(wep)
{
	if(!isDefined(level.weapons[wep]) || !isDefined(level.weapons[wep].rank) || (maps\mp\gametypes\_commanders::isCommander(self) && wep != "tesla_mp")) // || maps\mp\gametypes\_basic::debugModeOn(self))
		return true;

	if(!isDefined(self.rank) || isDefined(self.rank) && self.rank < level.weapons[wep].rank)
		return false;

	if(isDefined(level.weapons[wep].maxrank) && self.rank > level.weapons[wep].maxrank)
	{
		if(!isDefined(level.weapons[wep].power) || isDefined(level.weapons[wep].power) && self.power < level.weapons[wep].power)
			return false;
	}

	return true;
}


setMenuCvars()
{
	self setWepLockMsg("p90_mp", "ui_wepmsg_p90", "M. P90");
	self setWepLockMsg("tesla_mp", "ui_wepmsg_tesla", "N. Tesla");
	self setWepLockMsg("scout_mp", "ui_wepmsg_scout", "O. Scout");
	self setWepLockMsg("crossbow_mp", "ui_wepmsg_crossbow", "P. Crossbow");
	self setWepLockMsg("mosberg_mp", "ui_wepmsg_mosberg", "Q. Mosberg");
	self setWepLockMsg("zomknife_mp", "ui_wepmsg_zomknife", "F. Knife");
}

setWepLockMsg(wep, cvar, text)
{
	if(isDefined(level.weapons[wep]) && isDefined(level.weapons[wep].rank) && level.weapons[wep].rank > 0)
	{
		if(isDefined(level.weapons[wep].maxrank) && level.weapons[wep].maxrank > 0 && !isDefined(level.weapons[wep].power))
			text += " (" + level.weapons[wep].rank + "-" + level.weapons[wep].maxrank + ")";
		else if(!isDefined(self.rank) || isDefined(self.rank) && self.rank < level.weapons[wep].rank && !maps\mp\gametypes\_commanders::isCommander(self))
			text += " (" + level.weapons[wep].rank +  ")";
	}

	self setClientCvar(cvar, text);
}

updateAllAllowedSingleClient()
{
	self thread setMenuCvars();

	for(i = 0; i < level.weaponnames.size; i++)
	{
		weaponname = level.weaponnames[i];
		self updateAllowedSingleClient(weaponname);
	}
}

isZombieWep(wep)
{
	result = false;

	switch(wep)
	{
		case "axe_mp":
		case "basbat_mp":
		case "bowie_mp":
		case "katana_mp":
		case "crowbar_mp":
		case "zomknife_mp":		
		result = true;
		break;		

		default:
		break;
	}

	return result;
}