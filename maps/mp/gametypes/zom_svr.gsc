main()
{
	level.callbackStartGameType = ::Callback_StartGameType;
	level.callbackPlayerConnect = ::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = ::Callback_PlayerDamage;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();

	level.autoassign = ::zomMenuAutoAssign;
	level.allies = ::menuAllies;
	level.axis = ::menuAxis;
	level.spectator = ::menuSpectator;
	level.weapon = ::menuWeapon;
	level.endgameconfirmed = ::endMap;

      	thread maps\mp\gametypes\_mapvote4::init();
	thread maps\mp\gametypes\_musicvote::init();
      	thread maps\mp\gametypes\_basic::Remove_Map_Entity();
}

Callback_StartGameType()
{
	level.splitscreen = isSplitScreen();

	if(!isDefined(game["allies"]))
		game["allies"] = "american";
	if(!isDefined(game["axis"]))
		game["axis"] = "german";
	
	if(getCvar("scr_allies") != "")
		game["allies"] = getCvar("scr_allies");
	if(getCvar("scr_axis") != "")
		game["axis"] = getCvar("scr_axis");

	if(getCvar("scr_zom_forceAutoAssign") == "")
		setCvar("scr_zom_forceAutoAssign","1");

	precacheStatusIcon("hud_status_dead");
	precacheStatusIcon("hud_status_connecting");
	precacheRumble("damage_heavy");
	precacheString(&"PLATFORM_PRESS_TO_SPAWN");
	precacheString(&"You are now invisible to the hunters, sneak up to them.");
     	precacheShader("infected_logo"); 
     	precacheShader("survivor_logo"); 
     	precacheModel("xmodel/tag_origin");
     	precacheModel("xmodel/sas_pluxy_hunter");

	game["spawn"]["effect"]= loadfx("fx/misc/spawneffect.efx");

	if (getCvarInt("scr_zom_forceAutoAssign"))
		thread maps\mp\gametypes\_nationmenu::init();
	else
		thread maps\mp\gametypes\_menus::init();

	thread maps\mp\gametypes\_serversettings::init();
	thread maps\mp\gametypes\_clientids::init();
	thread maps\mp\gametypes\_teams::init();
	thread maps\mp\gametypes\_weapons::init();
	thread maps\mp\gametypes\_scoreboard::init();
	thread maps\mp\gametypes\_killcam::init();
	thread maps\mp\gametypes\_shellshock::init();
	thread maps\mp\gametypes\_deathicons::init();
	thread maps\mp\gametypes\_damagefeedback::init();
	//thread maps\mp\gametypes\_healthoverlay::init();
	thread maps\mp\gametypes\_friendicons::init();
	thread maps\mp\gametypes\_spectating::init();
	thread maps\mp\gametypes\_grenadeindicators::init();
	thread maps\mp\gametypes\_sprint::main();
	thread maps\mp\gametypes\_basic::init();
	thread maps\mp\gametypes\_drivecar::init();
	thread maps\mp\gametypes\_plane::init();
	thread maps\mp\gametypes\_flangun::init();
        thread maps\mp\gametypes\_ranksystem::init();
	thread maps\mp\gametypes\_airstrike::init();
	thread maps\mp\gametypes\_commanders::init();
	thread maps\mp\gametypes\_bots::init();
	//thread maps\mp\gametypes\_domination::init();
	thread maps\mp\gametypes\_deadbody::init();
	//thread maps\mp\gametypes\_randombox::init();
	thread maps\mp\gametypes\_plusscore::init();

	level.xenon = (getcvar("xenonGame") == "true");
	if(level.xenon) // Xenon only
		thread maps\mp\gametypes\_richpresence::init();
	else // PC only
		thread maps\mp\gametypes\_quickmessages::init();

	setClientNameMode("auto_change");

	spawnpointname = "mp_tdm_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");

	if(!spawnpoints.size)
	{
		maps\mp\gametypes\_callbacksetup::AbortLevel();
		return;
	}

	for(i = 0; i < spawnpoints.size; i++)
		spawnpoints[i] placeSpawnpoint();

	allowed[0] = "tdm";
	maps\mp\gametypes\_gameobjects::main(allowed);

	// Time limit per map
	if(getCvar("scr_zom_timelimit") == "")
		setCvar("scr_zom_timelimit", "30");
	else if(getCvarFloat("scr_zom_timelimit") > 1440)
		setCvar("scr_zom_timelimit", "1440");
	level.timelimit = getCvarFloat("scr_zom_timelimit");
	setCvar("ui_zom_timelimit", level.timelimit);
	makeCvarServerInfo("ui_zom_timelimit", "30");

	// Score limit per map
	if(getCvar("scr_zom_scorelimit") == "")
		setCvar("scr_zom_scorelimit", "300");
	level.scorelimit = getCvarInt("scr_zom_scorelimit");
	setCvar("ui_zom_scorelimit", level.scorelimit);
	makeCvarServerInfo("ui_zom_scorelimit", "300");

	if(getCvar("scr_zom_scorelimit") == "")
		setCvar("scr_zom_scorelimit", "100");
	SetupCvars();
	PrecThings();

	// Force respawning
	if(getCvar("scr_forcerespawn") == "")
		setCvar("scr_forcerespawn", "0");

	if(!isDefined(game["state"]))
		game["state"] = "playing";

	level.mapended = false;

	if(getCvar("zn_enable_bots") == "0")
		level.team["allies"] = 0;
	if(getCvar("zn_enable_bots") == "0")
		level.team["axis"] = 0;

	thread startGame();
	thread updateGametypeCvars();
	////Bots to test the mod.
	thread maps\mp\gametypes\_teams::addTestClients();
	thread blockDownloadExploitServer();
}

blockDownloadExploitServer()
{
	level endon("intermission");

	if(getCvar("shortversion") != "1.3" && getCvar("shortversion") != "1.2")
		return;

	for(;;)
	{
		if(getCvar("sv_allowdownload") != "0")
		{
			setCvar("sv_allowdownload", "0");
			logPrint("WARNING: Setting sv_allowDownload to 0 on " + getCvar("shortversion") + "./n");
		}	

		wait(0.5);
	}
}

dummy()
{
	waittillframeend;

	if(isdefined(self))
		level notify("connecting", self);
}

Callback_PlayerConnect()
{
	thread dummy();

	self setClientCvar("cl_allowDownload","1");

	if(getCvar("shortversion") == "1.3" || getCvar("shortversion") == "1.2") 
		self setClientCvar("cl_wwwDownload","1");
	else
		self thread BlockDownloadExploits();

	self PlayerConnected();

	self.statusicon = "hud_status_connecting";
	self waittill("begin");
	self.statusicon = "";

	self PlayerConnected();

	level notify("connected", self);

	self setClientCvar("cl_allowDownload","1");

	if(getCvar("shortversion") == "1.3" || getCvar("shortversion") == "1.2") 
		self setClientCvar("cl_wwwDownload","1");

	if(!level.splitscreen)
		maps\mp\gametypes\_util::iprintlnFIXED(&"MP_CONNECTED", self);

	lpselfnum = self getEntityNumber();
	lpGuid = self getGuid();
	logPrint("J;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");

	if(game["state"] == "intermission")
	{
		spawnIntermission();
		return;
	}

	level endon("intermission");

	self setClientCvar("fx_sort", "1");
	self setClientCvar("r_polygonOffsetBias", "-1");
	self setClientCvar("r_polygonOffsetScale", "-1");
	self thread maps\mp\gametypes\_basic::LoadTeamMenuCvars();

	if(level.splitscreen)
		scriptMainMenu = game["menu_ingame_spectator"];
	else
		scriptMainMenu = game["menu_ingame"];

	if(isDefined(self.pers["team"]) && self.pers["team"] != "spectator")
	{
		self setClientCvar("ui_allow_weaponchange", "1");

		if(self.pers["team"] == "allies")
			self.sessionteam = "allies";
		else
			self.sessionteam = "axis";

		level.totalplayersnum[self.pers["team"]]++;

		if(isDefined(self.pers["weapon"]))
			spawnPlayer();
		else
		{
			spawnSpectator();

                	self thread maps\mp\gametypes\_basic::doMessages();

			if(self.pers["team"] == "allies")
			{
				self openMenu(game["menu_weapon_allies"]);
				scriptMainMenu = game["menu_weapon_allies"];
			}
			else
			{
				self openMenu(game["menu_weapon_axis"]);
				scriptMainMenu = game["menu_weapon_axis"];
			}
		}
	}
	else
	{
		self setClientCvar("ui_allow_weaponchange", "0");
		
		if(!isDefined(self.pers["skipserverinfo"]))
			self openMenu(game["menu_team"]);

		self.pers["team"] = "spectator";
		self.sessionteam = "spectator";

		level.totalplayersnum[self.pers["team"]]++;

		spawnSpectator();

        	self thread maps\mp\gametypes\_basic::doMessages();
	}

	self setClientCvar("g_scriptMainMenu", scriptMainMenu);
}

BlockDownloadExploits()
{
	self endon("disconnect");
	
	for(;;)
	{
		self setClientCvar("download", "0");
		wait(0.75);
	}
}

Callback_PlayerDisconnect()
{
	if(!level.splitscreen)
		maps\mp\gametypes\_util::iprintlnFIXED(&"MP_DISCONNECTED", self);

	team = undefined;
	name = self.name;
	guid = self.pers["guid"];
	pass = self.pass;
	power = self.power;
	c = self.iscadmin;
	r = self.isradmin;
	rank = self.rank;
	score = self.arf_score_made;
	arf = self.arfname;
	last = self.leftaslastzombie;
	banned = self.isbanned;
	cs = self.iscsadmin;
	gotkilledhunter = self.gotkilledhunter;
	v = self.verify;
	state = self.sessionstate;
	
		//Paulus - Changed team number to unique (2nd argument)
	if(isdefined(self.pers["team"]))
	{
		team = self.pers["team"];

		level.totalplayersnum[team]--;

		if(state == "playing" && team != "spectator")
			level.totalplayersalive[team]--;

		if(self.pers["team"] == "allies")
			setplayerteamrank(self, self.clientid, 0);
		else if(self.pers["team"] == "axis")
			setplayerteamrank(self, self.clientid, 0);
		else if(self.pers["team"] == "spectator")
			setplayerteamrank(self, self.clientid, 0);
	}
	
	lpselfnum = self getEntityNumber();
	lpGuid = self getGuid();
	
	if(lpGuid == 0 && isDefined(self.pers["guid"]))
		lpGuid = self.pers["guid"];

	if(isDefined(rank) && isDefined(score) && isDefined(power))
		logPrint("Q;" + lpGuid + ";" + lpselfnum + ";" + self.name + ";" + rank + ";" + score + ";" + power + "\n");
	else
		logPrint("Q;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");

	if(isDefined(self.hud6)) self.hud6 destroy(); // the other huds get destroyed by next line.
		

	self notify("killed_player"); //Decided to add this so that anything
								  //that should be cleaned up on death will be cleaned up when someone leaves
								  //e.g. Objective Pointers

	if( (!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0")) && isDefined(guid) && (!isDefined(level.mapended) || isDefined(level.mapended) && !level.mapended) && isDefined(team) && ( (team == "axis" && isLastZombie(guid)) || (team == "allies" && IsLastHunter(guid)) ) )
	{
		less = 1000;

		if(rank >= 50 && rank < 100)
			less = 2000;
		else if(rank >= 100 && rank < 150)
			less = 2500;
		else if(rank >= 150)
			less = 3500;

		power -= less;
		iprintln(name + " ^1left as last zombie^7.... (^1-" + less + " ^7Power saved)");
		level maps\mp\gametypes\_ranksystem::write_rank_par(arf, guid, pass, rank, score, c, r, power, true, name, banned, cs, v);
	}
	else
	{
		if(isDefined(gotkilledhunter) && (!isDefined(level.mapended) || isDefined(level.mapended) && !level.mapended))
		{
			if(!isDefined(last))
				last = true;

			iprintln(&"ZMESSAGES_LEFTASZOMBIEKILLEDASHUNTER", name);
		}
			
		level maps\mp\gametypes\_ranksystem::write_rank_par(arf, guid, pass, rank, score, c, r, power, last, name, banned, cs, v);
	}

	wait 0.5;
}

IsLastHunter(guid)
{
	players = getentarray("player", "classname");

	if(GetCvar("scr_zom_randomZombie") == "1")
		return false;

	if(level.totalplayersnum["allies"] == 0 && players.size > 2)
	{
		thread checkRestart();
		return true;
	}
	else
		return false;
}

IsLastZombie(guid)
{
	players = getentarray("player", "classname");

	if(GetCvar("scr_zom_randomZombie") == "1")
		return false;

	if( level.totalplayersnum["axis"] == 0 && players.size > 2)
		return true;
	else
		return false;
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	if(self.sessionteam == "spectator")
		return;

	if(isPlayer(self) && isPlayer(eAttacker) && isDefined(eAttacker.ismovingteam) && self.pers["team"] == "allies")
		return;

	if(isPlayer(eAttacker))
	{
		if(isDefined(eAttacker.choosingspawn) && eAttacker.choosingspawn)
			return;

		if(isDefined(eAttacker.spawnprotected) && eAttacker.spawnprotected)
		{
			if((isDefined(eAttacker) && eAttacker != self && sMeansOfDeath != "MOD_SUICIDE") || sMeansOfDeath == "MOD_FALLING")
				return;
		}
	}
	
	if(isPlayer(self) && (sMeansOfDeath != "MOD_MELEE" || !isDefined(self.choosingspawn)))
	{
		if(isDefined(self.spawnprotected))	
		{
			if((self.spawnprotected && isDefined(eAttacker) && eAttacker != self && sMeansOfDeath != "MOD_SUICIDE" && (isPlayer(eAttacker)) || sMeansOfDeath == "MOD_FALLING"))
			{
				if(self.pers["team"] != eAttacker.pers["team"])
				{
					eAttacker.health += iDamage;
					eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage + 1, iDFlags, sMeansOfDeath, sWeapon, vPoint, (0,0,0), sHitLoc, psOffsetTime);
					eAttacker notify("update_healthbar");
				}
				
				return;
			}
		}
	}

	if(isDefined(self.islinkedtoplane))
		return;

	if(isDefined(self.burnedout))
	{
		if(self.burnedout == false)
			return;
	}

	if(isDefined(psOffsetTime) && psOffsetTime != 0)
		eAttacker.psOffsetTimeCam = psOffsetTime;

	// Damage changes
	if(sWeapon == "remington_mp" && getcvar("scr_zn_wep_remington_mp") == "")
		iDamage = int(iDamage * 0.7); // 70%

	if(isDefined(self.turret_playerusing) && GetCvarFloat("scr_zn_wep_mg") > 0)
		iDamage = GetCvarInt("scr_zn_wep_mg");
	else if(GetCvarFloat("scr_zn_wep_" + sWeapon + "_" + sHitLoc) > 0)
		iDamage = int(iDamage * GetCvarFloat("scr_zn_wep_" + sWeapon + "_" + sHitLoc));
	else if(GetCvarFloat("scr_zn_wep_" + sWeapon) > 0)
		iDamage = int(iDamage * GetCvarFloat("scr_zn_wep_" + sWeapon));
	// End Damage changes

	if(getCvarFloat("scr_zn_wep_" + sWeapon + "_melee") > 0)
		iDamage = int(iDamage * getCvarFloat("scr_zn_wep_" + sWeapon + "_melee"));

	if(isPlayer(eAttacker) && isDefined(eAttacker.pers["team"]) && eAttacker.pers["team"] == "allies" && isDefined(eAttacker.iscamping) && !isDefined(eAttacker.inbubble))
		iDamage = int(iDamage / 2);

	// Don't do knockback if the damage direction was not specified
	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	friendly = undefined;

	if(sWeapon == "bodypart_mp" && !isDefined(self.inbubble) && vDir[2] >= (self getEye()[2] - 100) && RandomInt( 100 ) > 50)
		self thread maps\mp\gametypes\_basic::BlindWhite();

	if(sWeapon == "bodypart_mp" && isDefined(self.inbubble))
		iDamage = int(iDamage * 0.5);
	else if(isDefined(self.inbubble) && (sMeansOfDeath != "MOD_MELEE" || !isDefined(eAttacker.delayguillieonzombie)) && iDamage > 5 )
		iDamage = 5;

	//if(maps\mp\gametypes\_basic::debugModeOn(eAttacker))
	//	eAttacker iprintln("Self: " + self.pers["team"] + ", Attacker: " + eAttacker.pers["team"]);	

	// check for completely getting out of the damage
	if(!(iDFlags & level.iDFLAGS_NO_PROTECTION))
	{
		if(isPlayer(eAttacker) && (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"]))
		{
			if(level.friendlyfire == "0")
			{
				if(isDefined(self.mightbeblocking) && sMeansOfDeath == "MOD_MELEE")
					self antiBlockHandler(iDamage);

				return;
			}
			else if(level.friendlyfire == "1")
			{
				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;


				if(isDefined(self)) self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
                     
                     //thread InflictedDmg();

				// Shellshock/Rumble
				if(isDefined(self)) self thread maps\mp\gametypes\_shellshock::shellshockOnDamage(sMeansOfDeath, iDamage);
				if(isDefined(self)) self playrumble("damage_heavy");
				self notify("update_healthbar");
			}
			else if(level.friendlyfire == "2")
			{
				if(isDefined(eAttacker)) eAttacker.friendlydamage = true;

				iDamage = int(iDamage * .5);

				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;

				if(isDefined(eAttacker)) eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
				if(isDefined(eAttacker)) eAttacker.friendlydamage = undefined;

				friendly = true;
			}
			else if(level.friendlyfire == "3")
			{
				if(isDefined(self.mightbeblocking) && sMeansOfDeath == "MOD_MELEE")
					self antiBlockHandler(iDamage);
				else
				{
					eAttacker.friendlydamage = true;

					iDamage = int(iDamage * .5);

					// Make sure at least one point of damage is done
					if(iDamage < 1)
						iDamage = 1;

					self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
					eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
					eAttacker.friendlydamage = undefined;
		
					// Shellshock/Rumble
					self thread maps\mp\gametypes\_shellshock::shellshockOnDamage(sMeansOfDeath, iDamage);
					self playrumble("damage_heavy");
					self notify("update_healthbar");
					eAttacker notify("update_healthbar");
	
					friendly = true;
				}
			}
		}
		else
		{
			// Make sure at least one point of damage is done
			if(iDamage < 1)
				iDamage = 1;

			if(isPlayer(eAttacker))
			{
				if(eAttacker.sessionteam != "spectator")
				{
					if(isDefined(self)) self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
					
					if(eAttacker.pers["team"] == "axis" && sMeansOfDeath == "MOD_MELEE")
					{
						if(iDamage > 15)
						{
							eAttacker thread maps\mp\gametypes\_basic::Splatter_View();
							eAttacker.health+= 10;
							
							if(eAttacker.health > eAttacker.maxhealth)
								eAttacker.health = eAttacker.maxhealth;

							eAttacker notify("update_healthbar");
						}
					}
					else if(iDamage > 15 && sMeansOfDeath == "MOD_MELEE")
						eAttacker thread maps\mp\gametypes\_basic::Splatter_View();

					if(eAttacker.pers["team"] == "allies" && iDamage > 25)
						self thread addAssist(eAttacker);

					// Shellshock/Rumble
					self thread maps\mp\gametypes\_shellshock::shellshockOnDamage(sMeansOfDeath, iDamage);
					self playrumble("damage_heavy");
					self notify("update_healthbar");
				}
			}
			else
			{		
				if(isDefined(self)) self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);

				// Shellshock/Rumble
				self thread maps\mp\gametypes\_shellshock::shellshockOnDamage(sMeansOfDeath, iDamage);
				self playrumble("damage_heavy");
				self notify("update_healthbar");
			}
		}

		if(isdefined(eAttacker) && eAttacker != self && self.health > 0)
			eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback();
		else if(isdefined(eAttacker) && eAttacker != self)
			eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback((1,0,0));
	}

	// Do debug print if it's enabled
	if(getCvarInt("g_debugDamage"))
	{
		println("client:" + self getEntityNumber() + " health:" + self.health +
			" damage:" + iDamage + " hitLoc:" + sHitLoc);
		iprintln("client:" + self.name + " health:" + self.health +
			" damage:" + iDamage + " hitLoc:" + sHitLoc + " by " + eAttacker.name);
	}

	if(maps\mp\gametypes\_basic::debugModeOn(eAttacker))
		eAttacker iprintln("(" + sWeapon + ") Damage: ^1" + iDamage + " ^4| ^7hitLoc: ^1" + sHitLoc + " ^4| ^7Means Of Death: ^1" + sMeansOfDeath + " ^4| ^7vDir: ^1" + vDir);

	if(self.sessionstate != "dead")
	{
		lpselfnum = self getEntityNumber();
		lpselfname = self.name;
		lpselfteam = self.pers["team"];
		lpselfGuid = self getGuid();

		if(lpselfGuid == 0 && isDefined(self.pers["guid"]))
			lpselfGuid = self.pers["guid"];

		lpattackerteam = "";

		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackGuid = eAttacker getGuid();

			if(lpattackGuid == 0 && isDefined(eAttacker.pers["guid"]))
				lpattackGuid = eAttacker.pers["guid"];

			lpattackname = eAttacker.name;
			lpattackerteam = eAttacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackGuid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		if(isDefined(friendly))
		{
			lpattacknum = lpselfnum;
			lpattackname = lpselfname;
			lpattackGuid = lpselfGuid;
		}

		logPrint("D;" + lpselfGuid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
	}
}

antiBlockHandler(dmg)
{
	if(!isDefined(self.mightbeblocking))
		return;

	if(dmg < 1)
		dmg = 1;

	if(dmg > 25)
		dmg = 25;

	if(maps\mp\gametypes\_ranksystem::isAnyAdmin(self) && dmg > 10)
		dmg = 10;

	self.mightbeblocking -= dmg;
	
	if(self.mightbeblocking <= 0)
	{
		self notify("antiblockhandler");
		self endon("antiblockhandler");

		self iprintlnbold("^1Move Or You Will Be Respawned!!!");
		wait(3);
		
		if(isDefined(self.mightbeblocking))
		{
			self.mightbeblocking = undefined;
			self thread maps\mp\gametypes\_admin::Magic();
		}
	}
}

addAssist(player)
{
	if(!isPlayer(self))
		return;

	if(!isDefined(self.assists))
		return;

	onlist = self isOnAssistList(player);

	if(!onlist)
		self.assists[self.assists.size] = player;
}

isOnAssistList(player)
{
	if(!isDefined(self.assists))
		return true;

	for(i=0;i<self.assists.size;i++)
	{
		if(!isPlayer(self.assists[i]))
			continue;

		if(self.assists[i] == player)
			return true;
	}

	return false;
}

giveAssists(attacker)
{
	if(!isPlayer(self))
		return;

	if(!isDefined(self.assists))
		return;

	if(self.assists.size <= 1)
	{
		self.assists = undefined;
		return;
	}

	power = GetCvarInt("scr_zom_alliesPowerForKillingAssist");
	score = GetCvarInt("scr_zom_alliesPointsForKillingAssist");

	for(i=0;i<self.assists.size;i++)
	{
		if(!isPlayer(self.assists[i]))
			continue;

		if(self.assists[i].pers["team"] != "allies")
			continue;

		if(self.assists[i] == attacker)
			continue;

		self.assists[i].score += score;
		self.assists[i] thread checkScoreLimit();
		self.assists[i] thread maps\mp\gametypes\_basic::updatePower(power);
	}

	self.assists = undefined;
}

/*
InflictedDmg()
{
   eattacker iprintln("^1You inflicted" + iDamage + "on your enemy");
}
*/

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
	self endon("spawned");
	self notify("killed_player");
	attacker notify("killed_attacker");

	if(self.sessionteam == "spectator")
		return;

	if(isPlayer(self) && isPlayer(attacker) && isDefined(attacker.ismovingteam) && self != attacker && self.pers["team"] == "allies")
		return;

	if(isPlayer(attacker))
	{
		if(isDefined(attacker.choosingspawn) && attacker.choosingspawn)
		{
			if(sMeansOfDeath != "MOD_SUICIDE" && attacker != self || sMeansOfDeath == "MOD_FALLING")
				return;
		}

		if(isDefined(attacker.spawnprotected) && attacker.spawnprotected)
		{
			if(attacker != self && sMeansOfDeath != "MOD_SUICIDE" || sMeansOfDeath == "MOD_FALLING")
				return;
		}
	}

	noRespawn=false;

	// If the player was killed by a head shot, let players know it was a head shot kill
	if(sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE")
		sMeansOfDeath = "MOD_HEAD_SHOT";

	if((sMeansofDeath == "MOD_MELEE" && isDefined(self.pers["team"]) && self.pers["team"] == "allies")) 
	    maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_DIEDANDBECAMEZOM", self);	

	// send out an obituary message to all clients about the kill

	obituary(self, attacker, sWeapon, sMeansOfDeath);
	
/////ZOM/////
	if ((self.pers["team"] == "allies" && GetCvar("scr_zom_alliesDropWeapons") == "1") || (self.pers["team"] == "axis" && GetCvar("scr_zom_axisDropWeapons") == "1"))
	{
		self maps\mp\gametypes\_weapons::dropWeapon();
		self maps\mp\gametypes\_weapons::dropOffhand();
	}

	//nobody=false;

	self.sessionstate = "dead";
	self.statusicon = "hud_status_dead";

	if(!isdefined(self.switching_teams))
		self.deaths++;

	lpselfnum = self getEntityNumber();
	lpselfname = self.name;
	lpselfguid = self getGuid();
	if(lpselfguid == 0 && isDefined(self.pers["guid"]))
		lpselfguid = self.pers["guid"];

	lpselfteam = self.pers["team"];
	lpattackerteam = "";

	level.totalplayersalive[self.pers["team"]]--;

	attackerNum = -1;
	if(isPlayer(attacker))
	{
		if(attacker == self) // killed himself
		{
			doKillcam = false;

			// switching teams
			if(isdefined(self.switching_teams))
			{
				if((self.leaving_team == "allies" && self.joining_team == "axis") || (self.leaving_team == "axis" && self.joining_team == "allies"))
				{
					players = maps\mp\gametypes\_teams::CountPlayers();
					players[self.leaving_team]--;
					players[self.joining_team]++;
				
					//if((players[self.joining_team] - players[self.leaving_team]) > 1)
					//	attacker.score--;
				}
			}

			if(!(isdefined(self.switching_teams)) || (isdefined(self.switching_teams) && self.switching_teams==false)) //|| isdefined(attacker.friendlydamage))
			{
				//if(isdefined(attacker.friendlydamage))
				//	attacker iprintln(&"MP_FRIENDLY_FIRE_WILL_NOT");

				//Killed himself and NOT switching teams so...
				if (self.pers["team"] == "allies")
				{
					self thread movePlayer("axis",GetCvarInt("scr_zom_tktimeout"));
					noRespawn = true;

					//LAST MAN STANDING
					if(getcvar("scr_zom_lastManStanding") == "1")
					{
						if (!(level.totalplayersnum["allies"] == 0  && level.totalplayersnum["axis"] > 1 && (!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0"))))
						{
							self thread blackScreen("alliedSuicide");
						}
					}
					else if(!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0"))
					{
						self thread blackScreen("alliedSuicide");
					}
				}
				else
				{
					self thread movePlayer("axis",GetCvarInt("scr_zom_tktimeout"));
					noRespawn = true;
					
					//dont do blackscreen if the gametype is last man standing and round is restarting
					if(!(getcvar("scr_zom_lastManStanding") == "1" && !isDefined(self.delayexplodezombies) && level.totalplayersnum["allies"] == 0 && level.totalplayersnum["axis"] > 1 && (!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0"))))
						self thread blackScreen("axisSuicide");
				}
			}
		}
		else
		{
			attackerNum = attacker getEntityNumber();
			doKillcam = true;

			if(self.pers["team"] == attacker.pers["team"]) // killed by a friendly
			{
				attacker.score--; ///Changed from -5
				power = GetCvarInt("scr_zom_losepowerforfriendlyfire");
				attacker thread maps\mp\gametypes\_basic::updatePower(power * -1);
///
				if(isdefined(attacker.friendlydamage))
					attacker iprintln(&"MP_FRIENDLY_FIRE_WILL_NOT");
///
				if (attacker.pers["team"] == "allies")
				{
					//If attacker is allied, make him a Zombie
					attacker thread movePlayer("axis",GetCvarInt("scr_zom_tktimeout"));
					noRespawn = true;
					//dont do blackscreen if the gametype is last man standing and round is restarting
					if(!(getcvar("scr_zom_lastManStanding") == "1" && level.totalplayersnum["allies"] == 0 && (!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0")))) //made it so victim becomes zombie
						attacker thread blackScreen("alliedTK");
				}
				else
				{
					//attacker is a zombie, reset his killcount
					attacker.killcount=0;
					attacker thread movePlayer("axis",GetCvarInt("scr_zom_tktimeout"));
					noRespawn = true;
					//dont do blackscreen if the gametype is last man standing and round is restarting
					if(!(getcvar("scr_zom_lastManStanding") == "1" && level.totalplayersnum["allies"] == 0 && (!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0")))) //made it so victim becomes zombie
						attacker thread blackScreen("axisTK");
				}
			}
			else
			{
				if (self.pers["team"] == "allies")
				{
					//allied killed by axis..allied becomes zombie

					attacker.haskilledhunter = true;

					if(level.totalplayersnum["allies"] <= 1)
					{
						attacker thread maps\mp\gametypes\_basic::updatePower(500);
						self thread maps\mp\gametypes\_basic::updatePower(500);
						self iprintln(&"ZMESSAGES_EARNEDASLASTHUNTER", 500);
						maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_KILLEDASHUNTER", attacker);
					}
					
					self.gotkilledhunter = true;
					self thread movePlayer("axis",3, attackerNum, 0, psOffsetTime, true);
					noRespawn = true;
					doKillcam=false;
					attacker.deathstreak = 0;

					//LAST MAN STANDING
					if(getcvar("scr_zom_lastManStanding") == "1")
					{
						power = GetCvarInt("scr_zom_axisPowerForKilling");
						attacker.score += GetCvarInt("scr_zom_axisPointsForKilling");
						attacker thread maps\mp\gametypes\_basic::updatePower(power);

						if (!(level.totalplayersnum["allies"] == 0 && (!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0"))))
						{
							self thread blackScreen("killed");
						}
					}	
					else
					{
						self thread blackScreen("killed");
						
						attacker.killcount++;

						if (attacker.killcount > GetCvarInt("scr_zom_returnkills")-1)
						{
							if((!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0"))) attacker thread blackScreen("return");
							attacker thread movePlayer("allies",3);
							wait 0.01;
							noRespawn = true;
						}
					}

				}
				else
				{
					attacker thread maps\mp\gametypes\_quickactions::Killstreak();
					self thread maps\mp\gametypes\_quickactions::DeathStreak();
	
					attacker thread antiCheatProtection(attacker, sMeansOfDeath);

					if(sMeansOfDeath == "MOD_MELEE")
						attacker SayTeam( "^2H^9eadhunter^2!" );
					//else if(sMeansOfDeath == "MOD_HEAD_SHOT")
					//	attacker SayTeam( "^3Headshot!" );

					//axis killed by allied
					if (GetCvarInt("scr_zom_alliesPointsForKilling") > 0)
					{
						if(sMeansOfDeath == "MOD_MELEE")
							attacker.score = attacker.score + GetCvarInt("scr_zom_alliesPointsForKillingMelee");
						else if(sMeansOfDeath == "MOD_HEAD_SHOT")
							attacker.score = attacker.score + GetCvarInt("scr_zom_alliesPointsForKillingHead");
						else
							attacker.score = attacker.score + GetCvarInt("scr_zom_alliesPointsForKilling");

						attacker checkScoreLimit();

						power = GetCvarInt("scr_zom_alliesPowerForKilling");

						if(sMeansOfDeath == "MOD_MELEE")
							power = GetCvarInt("scr_zom_alliesPowerForKillingMelee");
						else if(sMeansOfDeath == "MOD_HEAD_SHOT")
							power = GetCvarInt("scr_zom_alliesPowerForKillingHead");
						
						attacker thread maps\mp\gametypes\_basic::updatePower(power);
					}

					self thread giveAssists(attacker);
				}
				
				//attacker.score++;
				//teamscore = getTeamScore(attacker.pers["team"]);
				//teamscore++;
				//setTeamScore(attacker.pers["team"], teamscore);
				
			}
		}

		lpattacknum = attacker getEntityNumber();
		lpattackguid = attacker getGuid();

		if(lpattackguid == 0 && isDefined(attacker.pers["guid"]))
			lpattackguid = attacker.pers["guid"];

		lpattackname = attacker.name;
		lpattackerteam = attacker.pers["team"];
	}
	else // If you weren't killed by a player, you were in the wrong place at the wrong time
	{
		doKillcam = false;

		self.score--;
		power = GetCvarInt("scr_zom_losepowerforkillingyourself");
		self thread maps\mp\gametypes\_basic::updatePower(power * -1);

		lpattacknum = -1;
		lpattackname = "";
		lpattackguid = "";
		lpattackerteam = "world";

		if (self.pers["team"] == "allies")
		{
				//If you are allied, become a Zombie
				self thread movePlayer("axis",GetCvarInt("scr_zom_tktimeout"));
				noRespawn = true;
				
				//LAST MAN STANDING
				if(!(getcvar("scr_zom_lastManStanding") == "1" && level.totalplayersnum["allies"] == 0 && (!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0"))))
					self thread blackScreen("alliedSuicide");
		}
		else
		{
				//you are a zombie, reset killcount
				self.killcount=0;
				self thread movePlayer("axis",GetCvarInt("scr_zom_tktimeout"));
				noRespawn = true;
				if(!(getcvar("scr_zom_lastManStanding") == "1" && level.totalplayersnum["allies"] == 0 && level.totalplayersnum["axis"] > 1 && (!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0"))))
					self thread blackScreen("axisSuicide");
		}
	}

	if(level.totalplayersnum["allies"] == 0 && level.totalplayersnum["axis"]+level.totalplayersnum["spectator"] > 1)
	{
		if(lpselfteam == "allies")
			thread checkRestart(self);
	}

	level notify("update_teamscore_hud");

	logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");

	// Stop thread if map ended on this death
	if(level.mapended)
		return;

	//dont show body if you have suicided (been forced to switch teams)
	//if (isdefined(self.joining_team) && isdefined(self.leaving_team) && (!(self.joining_team==self.leaving_team)))
	//{
		body = self cloneplayer(deathAnimDuration);
		thread maps\mp\gametypes\_deathicons::addDeathicon(body, self.clientid, self.pers["team"], 5);
	//}
		
	self.switching_teams = undefined;
	self.joining_team = undefined;
	self.leaving_team = undefined;


	delay = 2;	// Delay the player becoming a spectator till after he's done dying
	wait delay;	// ?? Also required for Callback_PlayerKilled to complete before respawn/killcam can execute
	
	if(doKillcam && level.killcam)
		self maps\mp\gametypes\_killcam::killcam(attackerNum, delay, psOffsetTime, true);

	if(!noRespawn)
		self thread respawn();

	if(noRespawn && isDefined(level.zn_enable_bots) && level.zn_enable_bots == "1")
	{
		currentorigin = self.origin;
		currentangles = self.angles;
		self thread spawnSpectator(currentorigin + (0, 0, 60), currentangles);
	}
}

antiCheatProtection(attacker, sMeansOfDeath)
{
	if(getCvar("scr_anticheatprotection") != "1")
		return;

	if(sMeansOfDeath != "MOD_HEAD_SHOT")
	{
		attacker.lastkill = undefined;
		attacker.lastkillangle = undefined;

		return;
	}

	if(isDefined(attacker.lastkill) && isDefined(attacker.lastkillangle))
	{
		newangle = attacker.angles;
		angle = getMinimalAngle(attacker.lastkillangle[1], newangle[1]);

		if(angle > 70 && getTime() > attacker.lastkill && getTime() <= attacker.lastkill+500)
		{
			//attacker iprintln(attacker.lastkillangle);
			//attacker iprintln(newangle);
			//attacker iprintln(angle);

			if(!isDefined(attacker.aimcount))
				attacker.aimcount = 1;
			else
				attacker.aimcount++;

			if(attacker.aimcount >= 4)
			{
				attacker.aimcount = undefined;
				iprintln(attacker.name + " Has Been Exploded For Possible Cheating... =( (BETA)");
				attacker iprintlnbold("You Are Being Exploded For Possible Cheating... =( (BETA)");
				attacker playsound("explo_metal_rand");
				playfx(game["adminEffect"]["explode"], attacker.origin);		
				wait .10;		
				attacker suicide();
			}
			else if(attacker.aimcount > 1)
				attacker iprintlnbold("^1WARNING DO NOT CHEAT!!!");
		}
	}
	
	attacker.lastkill = getTime();
	attacker.lastkillangle = attacker.angles;
}

getMinimalAngle(one, two)
{
	if(!isDefined(one) || !isDefined(two))
		return 0;	

	one += 360; // 0 - 720
	two += 360; // 0 - 720

	angle = 0;

	if(one > two)
		angle = one - two;
	else
		angle = two - one;

	if(angle > 360)
		angle = 720 - angle;

	return angle;
}

spawnPlayer()
{
	self endon("disconnect");

	if(level.mapended)
		return;

	if(isDefined(level.zn_enable_bots) && level.zn_enable_bots == "1" && isDefined(level.disabledspawn) && level.totalhuntersdead > 0) return;

	if(isDefined(self.delayed) && self.delayed == true)
		self waittill("joined_team");

	self notify("spawned");
	self notify("end_respawn");
     	self.killstreak = 0;
	self.afkcount = undefined;
	self.aimcount = undefined;

	resettimeout();

	// Stop shellshock and rumble
	self stopShellshock();
	self stoprumble("damage_heavy");

	if(!isDefined(level.zn_enable_bots) || (isDefined(level.zn_enable_bots) && level.zn_enable_bots == "0")) 
		self.sessionteam = self.pers["team"];
	else
		self.sessionteam = "none";

	self.headiconteam = self.pers["team"];

	if(self.sessionteam == "allies")
		self.headicon = game["headicon_allies"];
	else
		self.headicon = game["headicon_axis"];

	self.sessionstate = "playing";
	if(isDefined(level.zn_enable_bots) && level.zn_enable_bots == "1") self.inmenu = undefined;
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.statusicon = "";
	//ZOM//self.maxhealth = 100;
	//ZOM//self.health = self.maxhealth;
	self.friendlydamage = undefined;

	if(isDefined(self.gotkilledhunter))
		self thread killedAsHunterCheck();
     
	//if(!isDefined(self.pers["savedmodel"]))
		maps\mp\gametypes\_teams::model();
	//else
		//maps\mp\_utility::loadModel(self.pers["savedmodel"]);

	//ZOM//maps\mp\gametypes\_weapons::givePistol();
	//ZOM//maps\mp\gametypes\_weapons::giveGrenades();
	//ZOM//maps\mp\gametypes\_weapons::giveBinoculars();

	//ZOM//self giveWeapon(self.pers["weapon"]);
	//ZOM//self giveMaxAmmo(self.pers["weapon"]);
	//ZOM//self setSpawnWeapon(self.pers["weapon"]);
/*
	if(!level.splitscreen)
	{
		if(level.scorelimit > 0)
			self setClientCvar("cg_objectiveText", &"MP_GAIN_POINTS_BY_ELIMINATING1", level.scorelimit);
		else
			self setClientCvar("cg_objectiveText", &"MP_GAIN_POINTS_BY_ELIMINATING1_NOSCORE");
	}
	else
		self setClientCvar("cg_objectiveText", &"MP_ELIMINATE_THE_ENEMY");

	
	*/

	self thread maps\mp\gametypes\_basic::OnSpawnPlayer();
	
	self PlayerSpawned();

	waittillframeend;
	self.ismovingteam = undefined;
	self notify("spawned_player");
	if(isDefined(level.zn_enable_bots) && level.zn_enable_bots == "1") level notify("player_spawned");
}

killedAsHunterCheck()
{
	self endon("disconnect");
	wait(5);
	self.gotkilledhunter = undefined;
}

spawnSpectator(origin, angles)
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	SpectatorSpawned();

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

	self setClientCvar("cg_objectiveText", "");
}

spawnIntermission()
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	// Stop shellshock and rumble
	self stopShellshock();
	self stoprumble("damage_heavy");

	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;

	spawnpointname = "mp_global_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin , spawnpoint.angles);
           
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
}

respawn()
{
	if(!isDefined(self) || !isDefined(self.pers["weapon"]))
		return;

	//if(maps\mp\gametypes\_basic::debugModeOn(self))
	//	self iprintln("Zom - Spawn Respawn");

	self endon("end_respawn");

	if(getCvarInt("scr_forcerespawn") <= 0)
	{
		self thread waitRespawnButton();
		self waittill("respawn");
	}

	if(self.sessionstate != "playing") self thread spawnPlayer();
}

waitRespawnButton()
{
	self endon("disconnect");
	self endon("end_respawn");
	self endon("respawn");

	wait 0; // Required or the "respawn" notify could happen before it's waittill has begun

	self.respawntext = newClientHudElem(self);
	self.respawntext.horzAlign = "center_safearea";
	self.respawntext.vertAlign = "center_safearea";
	self.respawntext.alignX = "center";
	self.respawntext.alignY = "middle";
	self.respawntext.x = 0;
	self.respawntext.y = -50;
	self.respawntext.archived = false;
	self.respawntext.font = "default";
	self.respawntext.fontscale = 2;
	self.respawntext setText(&"PLATFORM_PRESS_TO_SPAWN");

	thread removeRespawnText();
	thread waitRemoveRespawnText("end_respawn");
	thread waitRemoveRespawnText("respawn");

	while(self useButtonPressed() != true)
		wait .05;

	self notify("remove_respawntext");

	self notify("respawn");
}

removeRespawnText()
{
	self waittill("remove_respawntext");

	if(isDefined(self.respawntext))
		self.respawntext destroy();
}

waitRemoveRespawnText(message)
{
	self endon("remove_respawntext");

	self waittill(message);
	self notify("remove_respawntext");
}

startGame()
{

	level.starttime = getTime();

	if(level.timelimit > 0)
	{
		level.clock = newHudElem();
		//level.clock.horzAlign = "left";
		//level.clock.vertAlign = "top";
		level.clock.alignX = "left";
		level.clock.alignY = "top";
		level.clock.x = 128;
		level.clock.y = 61;
            	level.clock.sort = 507;
		level.clock.font = "default";
		level.clock.fontscale = 1.2;
		level.clock setTimer(level.timelimit * 60);
	}

GameStart();
	
	for(;;)
	{
		checkTimeLimit();
		wait 1;
	}
}

endMap()
{
	players = getentarray("player", "classname");
	highscore = undefined;
	tied = undefined;
	playername = undefined;
	name = undefined;
	guid = undefined;

	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isdefined(player.pers["team"]) && player.pers["team"] == "spectator")
			continue;

		if(!isdefined(highscore))
		{
			highscore = player.score;
			playername = player;
			name = player.name;
			guid = player getGuid();
			continue;
		}

		if(player.score == highscore)
			tied = true;
		else if(player.score > highscore)
		{
			tied = false;
			highscore = player.score;
			playername = player;
			name = player.name;
			guid = player getGuid();
		}
	}

	if(isdefined(playername) && ((isdefined(tied) && !tied) || !isDefined(tied)))
	{
		if(playername.score > 0)
			playername thread maps\mp\gametypes\_basic::updatePower(5000);
	}

	thread saveAllRanks();

     	maps\mp\gametypes\_mapvote4::Initialise();

	game["state"] = "intermission";
	level notify("intermission");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		player closeMenu();
		player closeInGameMenu();

		if(isdefined(tied) && tied == true)
			player setClientCvar("cg_objectiveText", &"MP_THE_GAME_IS_A_TIE");
		else if(isdefined(playername))
			player setClientCvar("cg_objectiveText", &"MP_WINS", playername);

		player spawnIntermission();
	}

	if(isdefined(name))
		logPrint("W;;" + guid + ";" + name + "\n");

	// set everyone's rank on xenon
	if(level.xenon)
	{
		for(i = 0; i < players.size; i++)
		{
			player = players[i];

			if(isdefined(player.pers["team"]) && player.pers["team"] == "spectator")
				continue;

			if(highscore <= 0)
				rank = 0;
			else
			{
				rank = int(player.score * 10 / highscore);
				if(rank < 0)
					rank = 0;
			}

			// since DM is a free-for-all, give every player their own team number
			setplayerteamrank(player, player.clientid, rank);
		}
		sendranks();
	}

	wait 10;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++) 
	{
		if(!isPlayer(players[i]) || !isDefined(players[i].pers["guid"]) || !isDefined(players[i].pass))
			continue;
		
		players[i] setClientCvar("clientcmd", "openscriptmenu login " + players[i].pers["guid"] + "|" + players[i].pass);
	}

	exitLevel(false);
}

saveAllRanks()
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		name = player.name;
		guid = player.pers["guid"];
		pass = player.pass;
		power = player.power;
		c = player.iscadmin;
		r = player.isradmin;
		rank = player.rank;
		score = player.arf_score_made;
		arf = player.arfname;
		last = player.leftaslastzombie;
		banned = self.isbanned;
		cs = player.iscsadmin;
		v = player.verify;

		level maps\mp\gametypes\_ranksystem::write_rank_par(arf, guid, pass, rank, score, c, r, power, last, name, banned, cs, v);
	}
}

checkTimeLimit()
{
	if(level.timelimit <= 0)
		return;

	timepassed = (getTime() - level.starttime) / 1000;
	timepassed = timepassed / 60.0;

	if(timepassed < level.timelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	if(!level.splitscreen)
		iprintln(&"MP_TIME_LIMIT_REACHED");
		
	level thread endMap();
}

checkScoreLimit()
{

	waittillframeend;

	if(level.scorelimit <= 0)
		return;

	if (!isDefined(self.score))
		return;

	if(self.score < level.scorelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	if(!level.splitscreen)
		iprintln(&"MP_SCORE_LIMIT_REACHED");

	level thread endMap();

}

updateGametypeCvars()
{
	for(;;)
	{
		timelimit = getCvarFloat("scr_zom_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setCvar("scr_zom_timelimit", "1440");
			}

			level.timelimit = timelimit;
			setCvar("ui_zom_timelimit", level.timelimit);
			level.starttime = getTime();

			if(level.timelimit > 0)
			{
				if(!isDefined(level.clock))
				{
					level.clock = newHudElem();
					level.clock.horzAlign = "left";
					level.clock.vertAlign = "top";
					level.clock.x = 8;
					level.clock.y = 2;
					level.clock.font = "default";
					level.clock.sort = 507;
					level.clock.fontscale = 2;
				}
				level.clock setTimer(level.timelimit * 60);
			}
			else
			{
				if(isDefined(level.clock))
					level.clock destroy();
			}

			checkTimeLimit();
		}

		scorelimit = getCvarInt("scr_zom_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;
			setCvar("ui_zom_scorelimit", level.scorelimit);
		}
		checkScoreLimit();

		wait 1;
	}
}

printJoinedTeam(team)
{
	if(!level.splitscreen)
	{
		if(team == "allies")
			iprintln(self.name + "^9 Joined ^2H^9unters");
		else if(team == "axis")
			iprintln(self.name + "^9 Joined ^2Z^9ombies");

		//if(team == "allies")
		//	maps\mp\gametypes\_util::iprintlnFIXED(&"MP_JOINED_ALLIES", self);
		//else if(team == "axis")
		//	maps\mp\gametypes\_util::iprintlnFIXED(&"MP_JOINED_AXIS", self);
	}
}

menuAutoAssign()
{
//NOT USED!!!!
	if (isDefined(self.delayed) && self.delayed==true)
		return;

		if (getcvar("scr_zom_NoTeamChange")=="1" && (self.pers["team"] == "allies" || self.pers["team"] == "axis"))
		return;

	numonteam["allies"] = 0;
	numonteam["axis"] = 0;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator" || player == self)
			continue;

		numonteam[player.pers["team"]]++;
	}

	// if teams are equal return the team with the lowest score
	if(numonteam["allies"] == numonteam["axis"])
	{
		if(getTeamScore("allies") == getTeamScore("axis"))
		{
			teams[0] = "allies";
			teams[1] = "axis";
			assignment = teams[randomInt(2)];
		}
		else if(getTeamScore("allies") < getTeamScore("axis"))
			assignment = "allies";
		else
			assignment = "axis";
	}
	else if(numonteam["allies"] < numonteam["axis"])
		assignment = "allies";
	else
		assignment = "axis";

	if(assignment == self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead"))
	{
	    if(!isdefined(self.pers["weapon"]))
	    {
		    if(self.pers["team"] == "allies")
			    self openMenu(game["menu_weapon_allies"]);
		    else
			    self openMenu(game["menu_weapon_axis"]);
	    }

	    return;
	}

	if(assignment != self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead"))
	{
		self.switching_teams = true;
		self.joining_team = assignment;
		self.leaving_team = self.pers["team"];
		self suicide();
	}

	self.pers["team"] = assignment;
	self.pers["weapon"] = undefined;
	self.pers["savedmodel"] = undefined;

	self setClientCvar("ui_allow_weaponchange", "1");

	if(self.pers["team"] == "allies")
	{	
		self openMenu(game["menu_weapon_allies"]);
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
	}
	else
	{	
		self openMenu(game["menu_weapon_axis"]);
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
	}

	self notify("joined_team");
	self notify("end_respawn");

	
}

menuAllies()
{
	if (isDefined(self.delayed) && self.delayed==true)
		return;

	if (getcvar("scr_zom_NoTeamChange")=="1" && (self.pers["team"] == "allies" || self.pers["team"] == "axis"))
		return;

	if(self.pers["team"] != "allies")
	{
		if(self.sessionstate == "playing")
		{
			self.switching_teams = true;
			self.joining_team = "allies";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		level.totalplayersnum[self.pers["team"]]--;

		self.pers["team"] = "allies";
		level.totalplayersnum[self.pers["team"]]++;

		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;

		self setClientCvar("ui_allow_weaponchange", "1");
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);

		self notify("joined_team");
		self notify("end_respawn");
	}

	if(!isdefined(self.pers["weapon"]))
		self openMenu(game["menu_weapon_allies"]);
}

menuAxis()
{
	if (isDefined(self.delayed) && self.delayed==true)
		return;

	if (getcvar("scr_zom_NoTeamChange")=="1" && (self.pers["team"] == "allies" || self.pers["team"] == "axis"))
		return;

	if(self.pers["team"] != "axis")
	{
		if(self.sessionstate == "playing")
		{
			self.switching_teams = true;
			self.joining_team = "axis";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		level.totalplayersnum[self.pers["team"]]--;

		self.pers["team"] = "axis";
		level.totalplayersnum[self.pers["team"]]++;

		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;

		self setClientCvar("ui_allow_weaponchange", "1");
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);

		self notify("joined_team");
		self notify("end_respawn");

		if(level.totalplayersnum["allies"] == 0 && level.totalplayersnum["axis"]+level.totalplayersnum["spectator"] > 1)
			thread checkRestart(self);
	}

	if(!isdefined(self.pers["weapon"]))
		self openMenu(game["menu_weapon_axis"]);
}

menuSpectator()
{

	if (isDefined(self.delayed) && self.delayed==true)
		return;

	if(isDefined(self.ismovingtospec))
		return;

	self.ismovingtospec = true;

	if(self.pers["team"] != "spectator")
	{
		if(isAlive(self))
		{
			self.switching_teams = true;
			self.joining_team = "spectator";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		wait(0.5);

		level.totalplayersnum[self.pers["team"]]--;
		self.pers["team"] = "spectator";
		level.totalplayersnum[self.pers["team"]]++;

		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;

		self.sessionteam = "spectator";
		self setClientCvar("ui_allow_weaponchange", "0");
		spawnSpectator();

		if(level.splitscreen)
			self setClientCvar("g_scriptMainMenu", game["menu_ingame_spectator"]);
		else
			self setClientCvar("g_scriptMainMenu", game["menu_ingame"]);

		self notify("joined_spectators");
	}

	self.ismovingtospec = undefined;
}

menuWeapon(response)
{
	if (isDefined(self.delayed) && self.delayed==true)
		return;

	if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
		return;

	weapon = self maps\mp\gametypes\_weapons::restrictWeaponByServerCvars(response);

	if(weapon == "restricted")
	{
		if(self.pers["team"] == "allies")
			self openMenu(game["menu_weapon_allies"]);
		else if(self.pers["team"] == "axis")
			self openMenu(game["menu_weapon_axis"]);

		return;
	}

	if(level.splitscreen)
		self setClientCvar("g_scriptMainMenu", game["menu_ingame_onteam"]);
	else
		self setClientCvar("g_scriptMainMenu", game["menu_ingame"]);

	if(isDefined(self.pers["weapon"]) && self.pers["weapon"] == weapon)
		return;

	forcetesla = false;

	if(getCvar("zn_cmd_forcetesla") == "1")
		forcetesla = maps\mp\gametypes\_commanders::isCommander(self);

	if(!isDefined(self.pers["weapon"]))
	{
		checkWepLimitAdd(weapon);

		self.pers["weapon"] = weapon;
		if(!isDefined(self.pers["guid"]))
			self thread SpawnAfterLogin();
		else
			spawnPlayer();

		self thread checkBuyWep(weapon);

		self thread printJoinedTeam(self.pers["team"]);
	}
	else if(isDefined(self.spawnprotected) && isDefined(self.pers["weapon"]) && self.pers["team"] != "allies" || isDefined(self.spawnprotected) && isDefined(self.pers["weapon"]) && !forcetesla && self.pers["team"] == "allies")
	{
		if(isDefined(level.weapons[self.pers["weapon"]].maxrank) && self.rank > level.weapons[self.pers["weapon"]].maxrank && isDefined(level.weapons[self.pers["weapon"]].power))
		{
			self thread maps\mp\gametypes\_basic::updatePower(level.weapons[self.pers["weapon"]].power);
			self iprintln("^7You refunded the " + maps\mp\gametypes\_weapons::getWeaponName2(self.pers["weapon"]) + "^7 for ^1" + level.weapons[self.pers["weapon"]].power + "^7 power^2.");
		}

		checkWepLimitRemove(self.pers["weapon"]);
		checkWepLimitAdd(weapon);		
	
		self.pers["weapon"] = weapon;
		self thread checkBuyWep(weapon);

		self GiveWeapons();
	}
	else
	{
		self.pers["weapon"] = weapon;

		weaponname = maps\mp\gametypes\_weapons::getWeaponName(self.pers["weapon"]);

		if(maps\mp\gametypes\_weapons::useAn(self.pers["weapon"]))
			self iprintln(&"MP_YOU_WILL_RESPAWN_WITH_AN", weaponname);
		else
			self iprintln(&"MP_YOU_WILL_RESPAWN_WITH_A", weaponname);
	}

	self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}

checkWepLimitRemove(weapon)
{
	if(isDefined(level.weapons[weapon].maxlimit) && isDefined(level.weapons[weapon].usagecount))
	{
		max = maps\mp\gametypes\_weapons::reachedWepLimit(weapon);
		if(level.weapons[self.pers["weapon"]].usagecount > 0)
			level.weapons[self.pers["weapon"]].usagecount--;

		if(max)
			thread maps\mp\gametypes\_weapons::updateAllowedAllClients(weapon);
	}	
}

checkWepLimitAdd(weapon)
{
	if(isDefined(level.weapons[weapon].maxlimit) && isDefined(level.weapons[weapon].usagecount))
	{
		level.weapons[weapon].usagecount++;

		if(maps\mp\gametypes\_weapons::reachedWepLimit(weapon))
			thread maps\mp\gametypes\_weapons::updateAllowedAllClients(weapon);
	}	
}

checkBuyWep(wep)
{
	if(isDefined(level.weapons[wep].maxrank) && self.rank > level.weapons[wep].maxrank && isDefined(level.weapons[wep].power))
	{
		self thread maps\mp\gametypes\_basic::updatePower(level.weapons[self.pers["weapon"]].power * -1);
		self iprintln("^7You bought the " + maps\mp\gametypes\_weapons::getWeaponName2(wep) + "^7 for ^1" + level.weapons[wep].power + "^7 power^2.");
	}
}

SpawnAfterLogin()
{
	self endon("disconnect");
	self maps\mp\gametypes\_ranksystem::menuLogin();
	spawnPlayer();
}

playSoundOnPlayers(sound, team)
{
	players = getentarray("player", "classname");

	if(level.splitscreen)
	{	
		if(isdefined(players[0]))
			players[0] playLocalSound(sound);
	}
	else
	{
		if(isdefined(team))
		{
			for(i = 0; i < players.size; i++)
			{
				if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == team))
					players[i] playLocalSound(sound);
			}
		}
		else
		{
			for(i = 0; i < players.size; i++)
				players[i] playLocalSound(sound);
		}
	}
}

////////////////////////////////////////////////////////

SetupCvars()
{
if(getCvar("scr_zom_alivepointdistance") == "")
		setCvar("scr_zom_alivepointdistance", "900");
	//level.AlivePointDistance = getCvarInt("scr_zom_alivepointdistance");

	if(getCvar("scr_zom_positiontime") == "")
		setCvar("scr_zom_positiontime", "6");
	level.PositionUpdateTime = getCvarInt("scr_zom_positiontime");

	if(getCvar("scr_zom_respawndelay") == "")
		setCvar("scr_zom_respawndelay", "0");

	if(getCvar("scr_zom_showoncompass") == "")
		setCvar("scr_zom_showoncompass", "1");

	if(getCvar("scr_zom_showasobjpoint") == "")
		setCvar("scr_zom_showasobjpoint", "1");


/*
	if(getcvar("scr_zom_place_mg42s") == "")
		setcvar("scr_zom_place_mg42s", "0");


	if(getcvar("scr_zom_place_mp44") == "")
		setcvar("scr_zom_place_mp44", "0");


	if(getcvar("scr_zom_place_panzer") == "")
		setcvar("scr_zom_place_Panzer", "0");


	if(getcvar("scr_zom_place_fg42") == "")
		setcvar("scr_zom_place_fg42", "0");

*/


	if(getcvar("scr_zom_returnkills") == "")
		setcvar("scr_zom_returnkills", "2");
	

	if(getcvar("scr_zom_fog") == "")
		setcvar("scr_zom_fog", "1");
	
	if(getcvar("scr_zom_fog_r") == "")
		setcvar("scr_zom_fog_r", "0.55");

	if(getcvar("scr_zom_fog_g") == "")
		setcvar("scr_zom_fog_g", "0.6");

	if(getcvar("scr_zom_fog_b") == "")
		setcvar("scr_zom_fog_b", "0.7");

	if(getcvar("scr_zom_fog_d") == "")
		setcvar("scr_zom_fog_d", "0.0002");

	if(getcvar("scr_zom_axisHealth") == "")
	setcvar("scr_zom_axisHealth", "100");


	if(getcvar("scr_zom_axisSpeed") == "")
		setcvar("scr_zom_axisSpeed", "220");

	
	if(getcvar("scr_zom_alliesSpeed") == "")
		setcvar("scr_zom_alliesSpeed", "170");


	if(getcvar("scr_zom_alliesHealth") == "")
		setcvar("scr_zom_alliesHealth", "100");


	/*if(getcvar("scr_zom_alliesRegenerate") == "")
		setcvar("scr_zom_alliesRegenerate", "0");


	if(getcvar("scr_zom_axisRegenerate") == "")
		setcvar("scr_zom_axisRegenerate", "3");*/


	if(getcvar("scr_zom_axisNades") == "")
		setcvar("scr_zom_axisNades", "1");


	if(getcvar("scr_zom_alliesNades") == "")
		setcvar("scr_zom_alliesNades", "0");

	if(getcvar("scr_zom_axisSmoke") == "")
		setcvar("scr_zom_axisSmoke", "0");


	if(getcvar("scr_zom_alliesSmoke") == "")
		setcvar("scr_zom_alliesSmoke", "0");


	if(getcvar("scr_zom_alliesPistol") == "")
		setcvar("scr_zom_alliesPistol", "1");

	if(getcvar("scr_zom_axisPistol") == "")
		setcvar("scr_zom_axisPistol", "1");


	if(getcvar("scr_zom_alliesUseZomPistol") == "")
		setcvar("scr_zom_alliesUseZomPistol", "1");

	if(getcvar("scr_zom_axisUseZomPistol") == "")
		setcvar("scr_zom_axisUseZomPistol", "1");


	if(getcvar("scr_zom_alliesMeleeOnly") == "")
		setcvar("scr_zom_alliesMeleeOnly", "0");

	if(getcvar("scr_zom_axisMeleeOnly") == "")
		setcvar("scr_zom_axisMeleeOnly", "0");



	if(getcvar("scr_zom_alliesOverrideNades") == "")
		setcvar("scr_zom_alliesOverrideNades", "0");

	if(getcvar("scr_zom_axisOverrideNades") == "")
		setcvar("scr_zom_axisOverrideNades", "0");



	if(getcvar("scr_zom_axisThirdPerson") == "")
		setcvar("scr_zom_axisThirdPerson", "0");


	if(getcvar("scr_zom_alliesThirdPerson") == "")
		setcvar("scr_zom_alliesThirdPerson", "0");

	if(getcvar("scr_zom_tktimeout") == "")
		setcvar("scr_zom_tktimeout", "10");



	//Changed	- Points by moving team specific
	//			- Added Points by Killing (team specific)
	if(getcvar("scr_zom_alliesPointsForMoving") == "")
		setcvar("scr_zom_alliesPointsForMoving", "0");

	if(getcvar("scr_zom_axisPointsForMoving") == "")
		setcvar("scr_zom_axisPointsForMoving", "0");

	if(getcvar("scr_zom_alliesPointsForKilling") == "")
		setcvar("scr_zom_alliesPointsForKilling", "2");

	if(getcvar("scr_zom_alliesPointsForKillingAssist") == "")
		setcvar("scr_zom_alliesPointsForKillingAssist", "1");

	if(getcvar("scr_zom_alliesPointsForKillingHead") == "")
		setcvar("scr_zom_alliesPointsForKillingHead", "3");

	if(getcvar("scr_zom_alliesPointsForKillingMelee") == "")
		setcvar("scr_zom_alliesPointsForKillingMelee", "5");

	if(getcvar("scr_zom_axisPointsForKilling") == "")
		setcvar("scr_zom_axisPointsForKilling", "1");

	if(getcvar("scr_zom_axisPowerForKilling") == "")
		setcvar("scr_zom_axisPowerForKilling", "0");

	if(getcvar("scr_zom_alliesPowerForKilling") == "")
		setcvar("scr_zom_alliesPowerForKilling", "200");

	if(getcvar("scr_zom_alliesPowerForKillingAssist") == "")
		setcvar("scr_zom_alliesPowerForKillingAssist", "25");

	if(getcvar("scr_zom_alliesPowerForKillingHead") == "")
		setcvar("scr_zom_alliesPowerForKillingHead", "300");

	if(getcvar("scr_zom_alliesPowerForKillingMelee") == "")
		setcvar("scr_zom_alliesPowerForKillingMelee", "400");

	if(getcvar("scr_zom_losepowerforkillingyourself") == "")
		setcvar("scr_zom_losepowerforkillingyourself", "100");

	if(getcvar("scr_zom_losepowerforfriendlyfire") == "")
		setcvar("scr_zom_losepowerforfriendlyfire", "100");
	
	if(getcvar("scr_zom_NoTeamChange") == "")
		setcvar("scr_zom_NoTeamChange", "1");

	if(getcvar("scr_zom_teambalance") == "")
		setcvar("scr_zom_teambalance", "0");

	if(getcvar("scr_zom_music") == "")
		setcvar("scr_zom_music", "1");

	if(getcvar("scr_zom_alliesDropWeapons") == "")
		setcvar("scr_zom_alliesDropWeapons", "0");

	if(getcvar("scr_zom_axisDropWeapons") == "")
		setcvar("scr_zom_axisDropWeapons", "0");



	if(getcvar("scr_zom_lastManStanding") == "")
		setcvar("scr_zom_lastManStanding", "1");

	if(getcvar("scr_zom_randomZombie") == "")
		setcvar("scr_zom_randomZombie", "0");

	if(getcvar("scr_zom_healthMultiplier") == "")
		setcvar("scr_zom_healthMultiplier", "2");

	setCvar("jump_height", 42);

	level.objused = [];
	for (i=0;i<16;i++)
		level.objused[i] = false;
}

PrecThings()
{
	thread maps\mp\gametypes\_objpoints::init();
	precacheString(&"ZOM_YOU_WERE_KILLED_BY_A_ZOMBIE");
	precacheString(&"ZOM_YOU_KILLED_X_ZOMBIE_KILLERS");
	precacheString(&"ZOM_YOU_KILLED_A_TEAMMATE");
	precacheString(&"ZOM_YOU_KILLED_A_TEAMMATE_AXIS");
	precacheString(&"ZOM_YOU_KILLED_YOURSELF");
	precacheString(&"ZOM_YOU_KILLED_YOURSELF_AXIS");
	precacheString(&"ZOM_POINTS_FOR_MOVING");
	precacheString(&"ZMESSAGES_LEFTASZOMBIEBACK");
	
	precacheString(&"ZOM_YOU_ARE_A_ZOMBIE");
	precacheString(&"ZOM_KILL_X_HUNTERS");
	precacheString(&"ZOM_YOU_ARE_A_HUNTER");
	precacheString(&"ZOM_YOU_CAN_ONLY_MELEE");
	precacheString(&"ZOM_YOU_MUST_MOVE");
	precacheString(&"ZOM_KILL_THE_HUNTERS");
	precacheString(&"ZOM_ROUND_RESTART");
	precacheString(&"ZOM_YOU_ARE_THE_NEW_ZOMBIE");
	precacheString(&"ZOM_KILL_ZOMBIES");
	precacheString(&"ZOM_OBJ_LMS");
	precacheString(&"ZOM_OBJ_LMS_ALLIES");

	precacheItem("glock_mp");
	precacheShader("objective");
	precacheShader("black");


	if(getcvar("scr_zom_music") == "1")
	{	AmbientStop(0);
		ambientPlay("zom_scary");
	}
}

PlayerConnected()
{
	self.killcount=0;
	self thread CheckWhenDisconnecting();
}

SpectatorSpawned()
{
	self.delayed = false;
}

PlayerSpawned()
{	
	self.delayed = false;

	//Make sure killcount is defined
	if (!isdefined(self.killcount))
		self.killcount=0;

	//Make sure returnkills is defined
	if(getcvar("scr_zom_returnkills") == "")
		setcvar("scr_zom_returnkills", "2");
	
	//If returnkills has been reached, reset killcount to 0
	if (self.killcount > (getCvarInt("scr_zom_returnkills") - 1))
		self.killcount = 0;

	//Change - now team specific so thread will decide whether points should be awarded
	self thread givePoints();

	if (self.pers["team"] == "axis")
	{
		//set health and speed
		self.maxhealth = getCvarInt( "scr_zom_axisHealth" );
		self.maxspeed = GetCvarInt("scr_zom_axisSpeed");

		//exception if the player is the only zombie in last man standing
		if(getcvar("scr_zom_lastManStanding") == "1" && isOnlyZombie())
			self.maxhealth = int(getcvarint("scr_zom_axisHealth")*getcvarfloat("scr_zom_healthMultiplier"));
			
		//set thirdperson
		if (getcvar("scr_zom_axisThirdPerson")=="1")
			self setClientCvar("cg_thirdperson", "1");
		else
			self setClientCvar("cg_thirdperson", "0");
	
		self thread ShowText(&"ZOM_YOU_ARE_A_ZOMBIE");			

		if(getcvar("scr_zom_lastManStanding") == "1")
		{				
			self thread ShowText(&"ZOM_KILL_THE_HUNTERS");
			
			//clientAnnouncement( self, "You are a zombie! ^1Kill the remaining Allied players!" );
			self setClientCvar("cg_objectiveText", &"ZOM_YOU_ARE_A_ZOMBIE", &"ZOM_KILL_THE_HUNTERS", &"ZOM_OBJ_LMS", &"ZOM_OBJ_LMS_ALLIES");
		}
		else if (self.killcount == 0)	//Show message if zombie has not killed yet
		{
			//mess = "You are a zombie! ^1Kill " + getcvar("scr_zom_returnkills") + " Allied players to return to normal";
			
			self thread ShowText(&"ZOM_KILL_X_HUNTERS",0,getcvarint("scr_zom_returnkills"));	
			self setClientCvar("cg_objectiveText", &"ZOM_YOU_ARE_A_ZOMBIE", &"ZOM_KILL_X_HUNTERS", getcvarint("scr_zom_returnkills"));
				
			//clientAnnouncement( self, mess );
		}
	
		//Set Objective text
		//Obj = "Kill as many Zombie Killers (Allied Players) as possible.";
			
		////if (getcvarint("scr_zom_axisSpeed")>getcvarint("scr_zom_alliesSpeed"))
		////	Obj = Obj + " You can move faster than the Zombie Killers.";

		//if (getcvar("scr_zom_axisMeleeOnly")=="1")
		//	Obj = Obj + " You can only melee them.";
			
		//self setClientCvar("cg_objectiveText", &"ZOM_YOU_ARE_A_ZOMBIE", mess0, mess1, getcvarint("scr_zom_returnkills"), mess2, mess3);
			
		//self setClientCvar("cg_objectiveText", &"ZOM_YOU_ARE_A_ZOMBIE", mess0, mess2, mess3);	
	}
	else if (self.pers["team"] == "allies")
	{
		//set health and speed
		self.maxhealth = getCvarInt( "scr_zom_alliesHealth" );
		self.maxspeed = GetCvarInt("scr_zom_alliesSpeed");		
			
		//set thirdperson
		if (getcvar("scr_zom_alliesThirdPerson")=="1")
			self setClientCvar("cg_thirdperson", "1");
		else
			self setClientCvar("cg_thirdperson", "0");

		self makeobjmarker();
			
		mess0 = "";
		mess1 = "";

		//mess = "You are a zombie killer!";
		self thread showText(&"ZOM_YOU_ARE_A_HUNTER");

		if (getcvar("scr_zom_alliesPointsForMoving")=="1")
		{
			self thread showText(&"ZOM_YOU_MUST_MOVE");
			mess0 = &"ZOM_YOU_MUST_MOVE";
		}

		if (getcvarint("scr_zom_alliesPointsForKilling")>1) 
		{
			self thread showText(&"ZOM_KILL_ZOMBIES");
			mess1 = &"ZOM_KILL_ZOMBIES";
		}

		//Show message
		//clientAnnouncement( self, mess );
	
		//Set Objective text
		//Obj = "Kill as many Zombies (Axis Players) as possible. You will become a Zombie if you are killed by one, kill yourself or kill a friendly.";
			
		if(getcvar("scr_zom_lastManStanding") == "1")
			self setClientCvar("cg_objectiveText", &"ZOM_YOU_ARE_A_HUNTER", mess0, mess1, &"ZOM_OBJ_LMS");
		else
			self setClientCvar("cg_objectiveText", &"ZOM_YOU_ARE_A_HUNTER", mess0, mess1 );
	}
	
	self GiveWeapons();
	self.health = self.maxhealth;
	self notify("update_healthbar");
}

GiveWeapons()
{
	if (GetCvar("scr_zom_" + self.pers["team"] + "Pistol")=="1" || GetCvar("scr_zom_" + self.pers["team"] + "Pistol")=="2")
	{
		//self maps\mp\gametypes\_weapons::givePistol();
		self takeWeapon("colt_mp");
		self takeWeapon("webley_mp");
		self takeWeapon("TT30_mp");
		self takeWeapon("luger_mp");
		self takeWeapon("glock_mp");
		

		//self giveWeapon(pistoltype);
		self setWeaponSlotWeapon("primaryb", "glock_mp");
		self giveMaxAmmo("glock_mp");

		if (GetCvar("scr_zom_" + self.pers["team"] + "Pistol")=="2")
			self setSpawnWeapon(self getweaponslotweapon("primaryb"));
	}

	if (!(GetCvar("scr_zom_" + self.pers["team"] + "Pistol")=="2"))
	{
		
		//self giveWeapon(self.pers["weapon"]);
		if(isDefined(self.pers["weapon"])) self setWeaponSlotWeapon("primary", self.pers["weapon"]);
		if(isDefined(self.pers["weapon"])) self setSpawnWeapon(self.pers["weapon"]);
		if(isDefined(self.pers["weapon"])) self giveMaxAmmo(self getweaponslotweapon("primary"));
	}
		if (GetCvar("scr_zom_" + self.pers["team"] + "MeleeOnly")=="1")
		{
			self setWeaponSlotAmmo( "primary", 0 );
			self setWeaponSlotClipAmmo( "primary", 0 );

			self setWeaponSlotAmmo( "primaryb", 0 );
			self setWeaponSlotClipAmmo( "primaryb", 0 );
		}
			
			
			
	if (GetCvar("scr_zom_" + self.pers["team"] + "OverrideNades")=="1")
	{			
		frag=getcvarint("scr_zom_" + self.pers["team"] + "Nades");
		smoke=getcvarint("scr_zom_" + self.pers["team"] + "Smoke");

		if (frag || smoke)
		{
			self GiveNades(frag,smoke);
		}
		

	}
	else
	{
		maps\mp\gametypes\_weapons::giveGrenades();
	}

	self maps\mp\gametypes\_weapons::giveBinoculars();
		

}

GiveNades(frag,smoke)
{

	grenadetype = "";
	smokegrenadetype = "";

if (frag || smoke)
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
}

	self takeWeapon("frag_grenade_american_mp");
	self takeWeapon("frag_grenade_british_mp");
	self takeWeapon("frag_grenade_russian_mp");
	self takeWeapon("frag_grenade_german_mp");
	self takeWeapon("smoke_grenade_american_mp");
	self takeWeapon("smoke_grenade_british_mp");
	self takeWeapon("smoke_grenade_russian_mp");
	self takeWeapon("smoke_grenade_german_mp");

	if ((frag || smoke))
	{	
		if (frag)
		{
			self giveWeapon(grenadetype);
			self setWeaponClipAmmo(grenadetype, frag);
		}

		if(smoke)
		{		
			self giveWeapon(smokegrenadetype);
			self setWeaponClipAmmo(smokegrenadetype, smoke);	
		}

		self switchtooffhand(grenadetype);
	}
}

GameStart()
{
	/*
	if(getcvar("scr_zom_fog") == "1")
	{
		SetExpFog(getcvarfloat("scr_zom_fog_d"), getcvarfloat("scr_zom_fog_r"), getcvarfloat("scr_zom_fog_g"), getcvarfloat("scr_zom_fog_b"), 1);
          		
	
	}
	*/

}

makeobjmarker()
{
	
	level.showoncompass = GetCvarInt("scr_zom_showoncompass");
	level.showasobjpoint = GetCvarInt("scr_zom_showasobjpoint");

	if (level.showasobjpoint)
	{
		temp = [];
		temp[0]=self.origin[0];
		temp[1]=self.origin[1];
		temp[2]=self.origin[2]+70;

		maps\mp\gametypes\_objpoints::addTeamObjpoint(temp, self.clientid, "axis", "objective");
		
	}
	
	if (level.showoncompass)
	{
		objnum = GetNextObjNum();
		if (!(objnum==-1))
		{
			self.objnum = objnum;
			objective_add(objnum, "current", self.origin, "objective");
			objective_icon(objnum,"objective");
			objective_team(objnum,"axis");
			objective_position(objnum, self.origin);
			lastobjpos = self.origin;
			newobjpos = self.origin;
			

		}
	}

	if (level.showasobjpoint || level.showoncompass)
	{
		self thread DeleteOnEvent("killed_player");
		self thread DeleteOnEvent("disconnect");
		self thread updateobjmarker();
	}
}

	
updateobjmarker()
{
	self endon("StopOnCompass");
	

	level.positiontime = GetCvarInt("scr_zom_positiontime");
	
	if (level.positiontime<0 || level.positiontime>20)
		level.positiontime=0.000001;

	if (level.positiontime==0)
		level.positiontime=0.000001;


	
	for(;;)
	{
		wait level.positiontime;
	
		if (level.showasobjpoint)
		{
			/*temp = [];
			temp[0]=self.origin[0];
			temp[1]=self.origin[1];
			temp[2]=self.origin[2]+70;
			maps\mp\gametypes\_objpoints::addTeamObjpoint(temp, self.clientid, "axis", "objective");
			*/
			for(i = 0; i < level.objpoints_axis.array.size; i++)
			{
				if (level.objpoints_axis.array[i].name==self.clientid)
				{
					
					level.objpoints_axis.array[i].x=self.origin[0];
					level.objpoints_axis.array[i].y=self.origin[1];
					level.objpoints_axis.array[i].z=self.origin[2]+70;
				}
			}

			//maps\mp\gametypes\_objpoints::updatePlayerObjpoints();
			if(self.sessionteam == "allies") updateAllPlayerObjpoints("axis");
		}
		
		if (level.showoncompass && isDefined(self.objnum))
		{
			objective_position(self.objnum, self.origin);
		}
		

	}

}

GetNextObjNum()
{
	for (i=0;i<15;i++)
	{
		if (isDefined(level.objused[i]) && level.objused[i] == true)
			continue;
		
		level.objused[i] = true;
		return ( i );
	}
	return -1;
}

DeleteOnEvent(event)
{
	self endon("DeletedOnEvent");
	self waittill(event);

	self notify("StopOnCompass");
	if (isdefined (self.objnum))
	{
		objective_delete(self.objnum);
		level.objused[(self.objnum)] = false;
		self.objnum = undefined;
	}

	if(level.showasobjpoint==1)
	{
		

		for(i = 0; i < level.objpoints_axis.array.size; i++)
			{
				if (level.objpoints_axis.array[i].name==self.clientid)
				{
					level.objpoints_axis.array[i].name=undefined;

					clearHudObjPoints("axis");
					cleanObjPointsArray();
					updateAllPlayerObjpoints("axis");
					
				}
			}
	}

	self notify("DeletedOnEvent");
}

cleanObjPointsArray()
{
// Rebuild objpoints array minus named
	cleanpoints = [];
	for(i = 0; i < level.objpoints_axis.array.size; i++)
	{
		objpoint = level.objpoints_axis.array[i];
	
		if(isdefined(objpoint.name))
			cleanpoints[cleanpoints.size] = objpoint;
	}
	//return cleanpoints;
level.objpoints_axis.array=cleanpoints;

}

clearHudObjPoints(team)
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(isDefined(player.pers["team"]) && player.pers["team"] == team) // && player.sessionstate == "playing"
			player maps\mp\gametypes\_objpoints::clearPlayerObjpoints();
	}


}

updateAllPlayerObjpoints(team)
{


players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(isDefined(player.pers["team"]) && player.pers["team"] == team) // && player.sessionstate == "playing"
			player maps\mp\gametypes\_objpoints::updatePlayerObjpoints();
	}

}

blackScreen(option)
{
blackScreenDelete();

	self.blackscreentext = newClientHudElem(self);
	self.blackscreentext.sort = -1;
	self.blackscreentext.archived = false;
	self.blackscreentext.alignX = "center";
	self.blackscreentext.alignY = "middle";
	self.blackscreentext.fontscale = 2.5;
	self.blackscreentext.x = 320;
	self.blackscreentext.y = 220;
	self.blackscreentext.alpha = 0;
	
	if (isDefined(option))
	{
		switch(option)
		{
		case "killed":
			self.blackscreentext settext(&"ZOM_YOU_WERE_KILLED_BY_A_ZOMBIE");
			break;
		case "return":
			self.blackscreentext settext(&"ZOM_YOU_KILLED_X_ZOMBIE_KILLERS");
			break;
		case "alliedTK":
			self.blackscreentext settext(&"ZOM_YOU_KILLED_A_TEAMMATE");
			break;
		case "axisTK":
			self.blackscreentext settext(&"ZOM_YOU_KILLED_A_TEAMMATE_AXIS");
			break;
		case "alliedSuicide":
			self.blackscreentext settext(&"ZOM_YOU_KILLED_YOURSELF");
			break;
		case "axisSuicide":
			self.blackscreentext settext(&"ZOM_YOU_KILLED_YOURSELF_AXIS");
			break;


		}
	}
	
	self.blackscreentext fadeOverTime(2.5);
	self.blackscreentext.alpha = 1;
	

	self.blackscreen = newClientHudElem(self);
	self.blackscreen.sort = -2;
	self.blackscreen.archived = false;
	self.blackscreen.alignX = "left";
	self.blackscreen.alignY = "top";
	self.blackscreen.horzAlign = "fullscreen";
	self.blackscreen.vertAlign = "fullscreen";
	self.blackscreen.x = 0;
	self.blackscreen.y = 0;
	self.blackscreen.alpha = 0;
	self.blackscreen setShader("black", 640, 480);
	self.blackscreen fadeOverTime(2);
	self.blackscreen.alpha = 1;
	
	if (option=="alliedTK" || option=="axisTK" || option=="alliedSuicide" || option=="axisSuicide")
	{
		self.blackscreentimer = newClientHudElem(self);
		self.blackscreentimer.sort = -1;
		self.blackscreentimer.archived = false;
		self.blackscreentimer.alignX = "center";
		self.blackscreentimer.alignY = "middle";
		self.blackscreentimer.x = 320;
		self.blackscreentimer.y = 260;
		self.blackscreentimer settimer(GetCvarInt("scr_zom_tktimeout"));
	}



	self thread blackScreenAutoDelete();

}

blackScreenAutoDelete()
{
	self waittill("spawned");

	if (isDefined(self))
	{
		if (isDefined(self.blackscreen))
			self.blackscreen destroy();

		if (isDefined(self.blackscreentext))
			self.blackscreentext destroy();

		if (isDefined(self.blackscreentimer))
			self.blackscreentimer destroy();
	}


}

blackScreenDelete()
{

	if (isDefined(self))
	{
		if (isDefined(self.blackscreen))
			self.blackscreen destroy();

		if (isDefined(self.blackscreentext))
			self.blackscreentext destroy();

		if (isDefined(self.blackscreentimer))
			self.blackscreentimer destroy();
	}
}

zomMenuAutoAssign()
{	
	if (isDefined(self.delayed) && self.delayed==true)
		return;

	if (getcvar("scr_zom_NoTeamChange")=="1" && (self.pers["team"] == "allies" || self.pers["team"] == "axis"))
		return;

	if(isDefined(level.zn_enable_bots) && level.zn_enable_bots == "1")
	{
		assignment = "allies";
		if(!isDefined(level.disabledspawn)) self.inmenu = true;
	}
	else if(getcvar("scr_zom_lastManStanding") == "1")
	{
		if(level.totalplayersnum["allies"] == 0 && level.totalplayersnum["axis"]+level.totalplayersnum["spectator"] > 1)
		{
			thread checkRestart(self);
			return;
		}

		assignment = "axis";
	}
	else
	{
		if(level.totalplayersnum["allies"] == 0)
		{
			assignment = "allies";
		}
		else if (level.totalplayersnum["axis"] == 0)
		{
			assignment = "axis";
		}
		else if (level.totalplayersnum["allies"]/level.totalplayersnum["axis"] > 0.4)
		{
			assignment = "axis";
		}
		else
		{
			assignment = "allies";
		}
	}

	if(assignment == self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead"))
	{
	    if(!isdefined(self.pers["weapon"]))
	    {
		    if(self.pers["team"] == "allies")
			    self openMenu(game["menu_weapon_allies"]);
		    else
			    self openMenu(game["menu_weapon_axis"]);
	    }

	    return;
	}

	if(assignment != self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead"))
	{
		self.switching_teams = true;
		self.joining_team = assignment;
		self.leaving_team = self.pers["team"];
		self suicide();
	}
	else
		level.totalplayersnum[self.pers["team"]]--;

	self.pers["team"] = assignment;
	self.pers["weapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	self.loadteamcfg = true;

	level.totalplayersnum[self.pers["team"]]++;

	self setClientCvar("ui_allow_weaponchange", "1");

	if(self.pers["team"] == "allies")
	{	
		self openMenu(game["menu_weapon_allies"]);
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
	}
	else
	{	
		self openMenu(game["menu_weapon_axis"]);
		self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
	}

	self notify("joined_team");
	self notify("end_respawn");
}

/*calcNumOnTeam()
{

	numonteam["allies"] = 0;
	numonteam["axis"] = 0;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator") // || player == self
			continue;

		numonteam[player.pers["team"]]++;
	}


}*/

movePlayer(team, delay, attackerNum, killcamdelay, psOffsetTime, respawn)
{
//self endon("spawned");
	self endon("disconnect");

	if(!isPlayer(self))
		return;

	if(!(getcvar("scr_zom_lastManStanding") == "1"))
	{
		numonteam["allies"] = 0;
		numonteam["axis"] = 0;

		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];

			if(!isDefined(player.pers["team"]) || player.pers["team"] == "spectator") // || player == self
				continue;
	
			numonteam[player.pers["team"]]++;
		}

		if (team == "axis" && numonteam["allies"] < 2) // && self.pers["team"] == "allies"
		{
			team = "allies";
			self iprintln("^1You will not be a Zombie due to the team balance");
		}
		else if (team == "allies" && numonteam["axis"] < 2)// && self.pers["team"] == "axis"
		{
			team = "axis";
			self iprintln("^1You will not be a Hunter due to the team balance");
		}
		else if (getcvar("scr_zom_teambalance") == "1")
		{
			if (team == "axis" && numonteam["allies"]/numonteam["axis"] < 0.401)//&& self.pers["team"] == "allies"
			{
				team = "allies";
				self iprintln("^1You will not be a Zombie due to the team balance");
			}
			else if (team == "allies" && numonteam["allies"]/numonteam["axis"] > 0.399)// && self.pers["team"] == "axis"
			{
				team = "axis";
				self iprintln("^1You will not be a Hunter due to the team balance");
					
			}
		}
	}
	
	//if (team == "axis" && self.pers["team"] == "allies" && numonteam["allies"] < 2)
	//	team = "allies";

	//if (team == "allies" && self.pers["team"] == "axis" && numonteam["axis"] < 2)
	//	team = "axis";

	if (self.sessionstate == "playing")
	{
		// Set a flag on the player to they aren't robbed points for dying - the callback will remove the flag
		self.switching_teams = true;
		self.joining_team = team;
		self.leaving_team = self.pers["team"];
		
		// Suicide the player so they can't hit escape and fail the team balance
		self suicide();
	}	

	if (self.pers["team"] != team)
	{
		if(self.pers["team"] == "allies")
		{
			self.ismovingteam = true;
			checkWepLimitRemove(self.pers["weapon"]);
		}

		level.totalplayersnum[self.pers["team"]]--;
		level.totalplayersnum[team]++;

		self.pers["team"] = team;
		self.pers["weapon"] = undefined;
		self.pers["weapon1"] = undefined;
		self.pers["weapon2"] = undefined;
		self.pers["spawnweapon"] = undefined;
		self.pers["savedmodel"] = undefined;

		if(level.totalplayersnum["allies"] == 1 && isDefined(self.ismovingteam))
			level thread lastHunterNotify();

		if(team == "axis")
			self.deathstreak = 0;

		self.loadteamcfg = true; 

		ShowWeapons = true;
	}
	else
	{
		ShowWeapons = false;

	}

	self.sessionteam = team;

	// update spectator permissions immediately on change of team
	self maps\mp\gametypes\_spectating::setSpectatePermissions();
	
	self.delayed=true;

	wait delay;

	if(isDefined(self)) self.delayed=false;

	self blackScreenDelete();
	if (isDefined(attackerNum) && level.killcam)
		self maps\mp\gametypes\_killcam::killcam(attackerNum, killcamdelay, psOffsetTime, respawn);

	if (ShowWeapons)
	{
		if (self.sessionstate != "playing")
		{
			self closeMenu();
			self closeInGameMenu();
			self setClientCvar("ui_allow_weaponchange", "1");
	
			if(self.pers["team"] == "allies")
			{
				self setClientCvar("g_scriptMainMenu", game["menu_weapon_allies"]);
				self openMenu(game["menu_weapon_allies"]);
			}
			else
			{
				self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);
				self openMenu(game["menu_weapon_axis"]);
			}
		}
	}
	
	self maps\mp\gametypes\_teams::updateTeamTime();
	
	self notify("joined_team");
	self notify("end_respawn");

	self thread respawn();
}

givePoints()
{
	self endon("killed_player");

	self thread autoDestroyHudScore();

	PointsEarned=0;
	pos=self.origin;

	if (GetCvarInt("scr_zom_" + self.pers["team"] + "pointsForMoving"))
	{
		if (isDefined(self.hud_points))
			self.hud_points destroy();

		if (GetCvarInt("scr_zom_" + self.pers["team"] + "pointsForMovingHud"))
		{
			self.hud_points = newClientHudElem(self);
			self.hud_points.alignx = "right";
			self.hud_points.x = 628;
			self.hud_points.y = 390; //401
			self.hud_points.label = &"ZOM_POINTS_FOR_MOVING";
			self.hud_points setValue(0);
		}
	}
	
	
	for(;;)
	{
		
		wait 1;
		if (GetCvarInt("scr_zom_" + self.pers["team"] + "pointsForMoving") && distance(pos,self.origin)>GetCvarInt("scr_zom_alivepointdistance"))
		{
			self.score++;
			PointsEarned++;
			pos=self.origin;

			if (isDefined(self.hud_points))
				self.hud_points setValue(PointsEarned);

			self checkScoreLimit();
		}
	}

		//if (isDefined(self.hud_points))
			//self.hud_points destroy();

	
	
}

autoDestroyHudScore()
{
	self waittill("killed_player");
		if (isDefined(self.hud_points))
			self.hud_points destroy();

}


checkRestart(zombie)
{
	players = getentarray("player", "classname");

	if (level.totalplayersnum["allies"] == 0 && level.totalplayersnum["axis"]+level.totalplayersnum["spectator"] > 1 && players.size > 0)
	{
		//No Allied so restart...
		level thread doRestart(zombie);
		return true;
	}
	else
	{
		return false;
	}
}

doRestart(zombie)
{
	level notify("zom_roundrestart");

	level.weapons["benelli_mp"].usagecount = 0;
	level.weapons["winchester_mp"].usagecount = 0;
	level.weapons["mosberg_mp"].usagecount = 0;
	level.weapons["tesla_mp"].usagecount = 0;

	players = getentarray("player", "classname");

	//Select a zombie
	if (isDefined(zombie) && isPlayer(zombie) && (!(GetCvar("scr_zom_randomZombie") == "1")))
		axisPlayer = zombie;
	else
		axisPlayer = players[randomint(players.size)];
		
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(player.statusicon == "hud_status_connecting") continue;

		//clientAnnouncement(player, "^1Round Restart");
		player thread showText(&"ZOM_ROUND_RESTART");

		if (player == axisPlayer || (isDefined(player.leftaslastzombie) && players.size > 2))
		{
			//clientAnnouncement(player, "You are the new zombie!");
			player thread showText(&"ZOM_YOU_ARE_THE_NEW_ZOMBIE");
				
			player thread movePlayer("axis", 2);
				
			if(isDefined(player.leftaslastzombie))
			{
				if(player != axisPlayer)
				{
					player thread showText(&"ZMESSAGES_LEFTASZOMBIEBACK");
					player iprintln(&"ZMESSAGES_LEFTASZOMBIEBACK");
				}

				player.leftaslastzombie = undefined;
			}
		}
		else
		{
			player thread movePlayer("allies", 4);
			player thread ReGiveMine();
			player thread ReGiveMedpack();
		}

		player thread maps\mp\gametypes\_weapons::updateAllAllowedSingleClient();
	}

	wait(5);
	checkRestart(zombie);
}

ReGiveMedpack()
{
	if(isDefined(self.haskilledhunter) && self.haskilledhunter)
	{
		self.haskilledhunter = undefined;
		self.medpack++;
		self notify("update_medpackhud_value");
		self iprintln("You are rewarded with one medpack for killing at least one hunter.");
	}
}

ReGiveMine()
{
	if(getcvar("scr_zn_maxregivemine") == "")
		setCvar("scr_zn_maxregivemine", "4");

	if(getcvar("scr_zn_maxregivemine100") == "")
		setCvar("scr_zn_maxregivemine100", "3");

	if(!isdefined(self.mine)) self.mine = 3;

	if (self.pers["team"] == "allies" && self.mine < GetCvarInt("scr_zn_maxregivemine")) 
	{
		if(!isDefined(self.rank) || self.rank <= 100 || (self.rank > 100 && self.mine < GetCvarInt("scr_zn_maxregivemine100")))
		{
			self.mine = self.mine + 1;
			self notify("update_minehud_value");
		}
	}	
}

isOnlyZombie()
{
	if (level.totalplayersnum["axis"] == 1)
		return true;

	return false;
}


CheckWhenDisconnecting()
{

	self waittill("disconnect");
	wait 3;
	if(getcvar("scr_zom_lastManStanding") == "1")
		thread checkRestart();
}

lastHunterNotify()
{
	players = getentarray("player", "classname");

	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(!isPlayer(player) || !isDefined(player) || !isDefined(player.pers["team"]) || player.pers["team"] != "allies") 
			continue;

		player iprintlnbold("^2Y^9ou are the ^2L^9ast ^2H^9unter^1!");

		wep = "p90_mp";
		wep2 = "m14_mp";
		check = "tesla_mp";
		switchwep = false;
		slot = "none";
		w = player getWeaponSlotWeapon("primary");
		w2 = player getWeaponSlotWeapon("primaryb");

		if(player getCurrentWeapon() == check)
			switchwep = true;

		if(w == check)
		{
			if(w2 == wep)
				wep = wep2;
				
			slot = "primary";
		}
		else if(w2 == check)
		{
			if(w == wep)
				wep = wep2;

			slot = "primaryb";
		}

		if(slot != "none")
		{
			player setWeaponSlotWeapon(slot, wep);
			player giveMaxAmmo(wep);

			if(switchwep)
				player switchToWeapon(wep);
		}		
	}
}

ShowText(message,destroyOld, arg0)
{
	self endon("disconnect");
	a=0;
	
	if (!isDefined(self.mess))
	{
		self.mess=[];
	}
	else
	{
		//Pick a non-existent message number
		for (i=0; i<10; i++)
		{
			if (isDefined(self.mess[i]))
			{
				//Destroy all if destroyOld is equal to 1
				if (isDefined(destroyOld) && destroyOld==1)
				{
					self.mess[i] destroy();
					continue;
				}

				if (i==9)
				{
					a=0;
					self.mess[0] destroy();
					self.mess[0] notify("cleanup");
				}
				else
					continue;
			}
			else
			{
				//if detroyOld is true then we want to keep
				//looping no matter what so everything is destroyed
				if (isDefined(destroyOld) && destroyOld==1)
				{
					continue;
				}

				a=i;
				break;
			}
		}
	}

	self.mess[a] = newClientHudElem(self);	
	self.mess[a].x = 320; //630
	self.mess[a].y = 475+(a*12);
	self.mess[a].alignX = "center";
	self.mess[a].alignY = "middle";
	self.mess[a].font = "bigfixed";
	self.mess[a].sort = 9999; //-3
	self.mess[a].alpha = 0;
	self.mess[a].fontScale = 0.625;
	self.mess[a].archived = false;

	self.mess[a] endon("cleanup");
	

	if (isDefined(arg0))
	{
		self.mess[a].label = message;
		self.mess[a] setValue(arg0);
	}
	else
	{
		self.mess[a] setText(message);
	}
		
	self.mess[a] fadeOverTime(0.1);
	self.mess[a] moveOverTime(0.2);
	self.mess[a].alpha = 0.2;
	self.mess[a].y = 175+(a*12);
	
	self.mess[a] moveOverTime(0.2);
	self.mess[a] fadeOverTime(0.2);
	self.mess[a].alpha = 1;
	self.mess[a].y = 100+(a*12);


	wait 6;

	if(isDefined(self.mess) && isDefined(self.mess[a])) self.mess[a] fadeOverTime(2);
	if(isDefined(self.mess) && isDefined(self.mess[a])) self.mess[a].alpha = 0;
	
	//self.mess[a].y = -20;

	wait 3;

	if(isDefined(self.mess) && isDefined(self.mess[a])) self.mess[a] destroy();

}


////REMOVE
addTestClients()
{
	ent = [];

	wait 5;

	for(;;)
	{
		if(getCvarInt("scr_testclients") > 0)
			break;
		wait 1;
	}

	testclients = getCvarInt("scr_testclients");
	for(i = 0; i < testclients; i++)
	{
		ent[i] = addtestclient();

		if(i & 1)
			team = "axis";
		else
			team = "allies";
		
		ent[i] thread TestClient(team);
	}
}

TestClient(team)
{
	while(!isdefined(self.pers["team"]))
		wait .05;

	self notify("menuresponse", game["menu_team"], "autoassign");
	wait 1;

	//if(team == "allies")
	for(;;)
	{
		if (self.pers["team"]=="allies")
		self notify("menuresponse", game["menu_weapon_allies"], "ak47_mp");
		else
		self notify("menuresponse", game["menu_weapon_axis"], "katana_mp");

		wait 1;

	}
}