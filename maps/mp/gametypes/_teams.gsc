init()
{
	precacheString(&"MP_AMERICAN");
	precacheString(&"MP_BRITISH");
	precacheString(&"MP_RUSSIAN");
	
	switch(game["allies"])
	{
	case "american":
		precacheShader("mpflag_american");
		break;
	
	case "british":
		precacheShader("mpflag_british");
		break;
	
	case "russian":
		precacheShader("mpflag_russian");
		break;
	}

	assert(game["axis"] == "german");
	precacheShader("mpflag_german");
	precacheShader("mpflag_spectator");

	if(getCvar("scr_teambalance") == "")
		setCvar("scr_teambalance", "0");
	level.teambalance = getCvarInt("scr_teambalance");
	level.teambalancetimer = 0;
	
	setPlayerModels();

	if(getcvar("g_gametype") != "dm")
	{
		level thread onPlayerConnect();
		level thread updateTeamBalanceCvar();
		
		wait .15;
	
		if(getcvar("g_gametype") == "sd")
		{
			if(level.teambalance > 0)
			{
		    	if(isdefined(game["BalanceTeamsNextRound"]))
		    		iprintlnbold(&"MP_AUTOBALANCE_NEXT_ROUND");
	
				level waittill("restarting");
	
				if(isdefined(game["BalanceTeamsNextRound"]))
				{
					level balanceTeams();
					game["BalanceTeamsNextRound"] = undefined;
				}
				else if(!getTeamBalance())
					game["BalanceTeamsNextRound"] = true;
			}
		}
		else
		{
			for(;;)
			{
				if(level.teambalance > 0)
				{
					if(!getTeamBalance())
					{
						iprintlnbold(&"MP_AUTOBALANCE_SECONDS", 15);
					    wait 15;
	
						if(!getTeamBalance())
							level balanceTeams();
					}
					
					wait 59;
				}
				
				wait 1;
			}
		}
	}
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		
		player thread onPlayerSpawn();
		player thread onPlayerSpawned();
		player thread onJoinedTeam();
		player thread onJoinedSpectators();
		player thread onPlayerKilled();
		//player thread onPlayerFirstSpawned(); // now done by login system
	}
}

OnPlayerSpawn()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("end_respawn");
		self thread maps\mp\gametypes\_basic::MonitorAfk(); // Comes from Selbie :)
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("spawned_player");
		if(!isDefined(self.gotspawned))
		{
			self.gotspawned = true;
			self thread maps\mp\gametypes\_basic::RankHud();
			self thread maps\mp\gametypes\_basic::Minehud();
			self thread maps\mp\gametypes\_basic::Powerhud();
			self thread maps\mp\gametypes\_basic::Medpackhud();

			if(isDefined(self) && isDefined(self.pers["team"]))
				level.totalplayersalive[self.pers["team"]]++;
		}
	}
}

onPlayerFirstSpawned()
{
	self endon("disconnect");

	if(getcvar("zn_no_auto_admin") == "1") return;
	
	self waittill("spawned_player");
	self thread maps\mp\gametypes\_basic::GetAllAdmins();
}

onPlayerKilled()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("killed_player");
		self thread maps\mp\gametypes\_basic::RemoveHuds( true );
		self.gotspawned = undefined;
	}
}


onJoinedTeam()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("joined_team");
		self updateTeamTime();
           	self thread maps\mp\gametypes\_basic::RemoveHuds( false );	
	}
}

onJoinedSpectators()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("joined_spectators");
		self.pers["teamTime"] = undefined;
           	self thread maps\mp\gametypes\_basic::RemoveHuds( false );
	}
}

updateTeamTime()
{
	if(getcvar("g_gametype") == "sd")
		self.pers["teamTime"] = game["timepassed"] + ((getTime() - level.starttime) / 1000) / 60.0;
	else
		if(isDefined(self)) self.pers["teamTime"] = (gettime() / 1000);
}

updateTeamBalanceCvar()
{
	for(;;)
	{
		teambalance = getCvarInt("scr_teambalance");
		if(level.teambalance != teambalance)
			level.teambalance = getCvarInt("scr_teambalance");

		wait 1;
	}
}

getTeamBalance()
{
	level.team["allies"] = 0;
	level.team["axis"] = 0;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
			level.team["allies"]++;
		else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
			level.team["axis"]++;
	}
	
	if((level.team["allies"] > (level.team["axis"] + level.teambalance)) || (level.team["axis"] > (level.team["allies"] + level.teambalance)))
		return false;
	else
		return true;
}

balanceTeams()
{
	iprintlnbold(&"MP_AUTOBALANCE_NOW");
	//Create/Clear the team arrays
	AlliedPlayers = [];
	AxisPlayers = [];
	
	// Populate the team arrays
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(!isdefined(players[i].pers["teamTime"]))
			continue;
			
		if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
			AlliedPlayers[AlliedPlayers.size] = players[i];
		else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
			AxisPlayers[AxisPlayers.size] = players[i];
	}
	
	MostRecent = undefined;
	
	while((AlliedPlayers.size > (AxisPlayers.size + 1)) || (AxisPlayers.size > (AlliedPlayers.size + 1)))
	{	
		if(AlliedPlayers.size > (AxisPlayers.size + 1))
		{
			// Move the player that's been on the team the shortest ammount of time (highest teamTime value)
			for(j = 0; j < AlliedPlayers.size; j++)
			{
				if(isdefined(AlliedPlayers[j].dont_auto_balance))
					continue;
				
				if(!isdefined(MostRecent))
					MostRecent = AlliedPlayers[j];
				else if(AlliedPlayers[j].pers["teamTime"] > MostRecent.pers["teamTime"])
					MostRecent = AlliedPlayers[j];
			}
			
			if(getcvar("g_gametype") == "sd")
				MostRecent changeTeam_RoundBased("axis");
			else
				MostRecent changeTeam("axis");
		}
		else if(AxisPlayers.size > (AlliedPlayers.size + 1))
		{
			// Move the player that's been on the team the shortest ammount of time (highest teamTime value)
			for(j = 0; j < AxisPlayers.size; j++)
			{
				if(isdefined(AxisPlayers[j].dont_auto_balance))
					continue;

				if(!isdefined(MostRecent))
					MostRecent = AxisPlayers[j];
				else if(AxisPlayers[j].pers["teamTime"] > MostRecent.pers["teamTime"])
					MostRecent = AxisPlayers[j];
			}

			if(getcvar("g_gametype") == "sd")
				MostRecent changeTeam_RoundBased("allies");
			else
				MostRecent changeTeam("allies");
		}

		MostRecent = undefined;
		AlliedPlayers = [];
		AxisPlayers = [];
		
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
				AlliedPlayers[AlliedPlayers.size] = players[i];
			else if((isdefined(players[i].pers["team"])) &&(players[i].pers["team"] == "axis"))
				AxisPlayers[AxisPlayers.size] = players[i];
		}
	}
}

changeTeam(team)
{
	if (self.sessionstate != "dead")
	{
		// Set a flag on the player to they aren't robbed points for dying - the callback will remove the flag
		self.switching_teams = true;
		self.joining_team = team;
		self.leaving_team = self.pers["team"];
		
		// Suicide the player so they can't hit escape and fail the team balance
		self suicide();
	}

	self.pers["team"] = team;
	self.pers["weapon"] = undefined;
	self.pers["weapon1"] = undefined;
	self.pers["weapon2"] = undefined;
	self.pers["spawnweapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	self.sessionteam = self.pers["team"];
	
	// update spectator permissions immediately on change of team
	self maps\mp\gametypes\_spectating::setSpectatePermissions();
	
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
	
	self updateTeamTime();
	
	self notify("end_respawn");
}

changeTeam_RoundBased(team)
{
	self.pers["team"] = team;
	self.pers["weapon"] = undefined;
	self.pers["weapon1"] = undefined;
	self.pers["weapon2"] = undefined;
	self.pers["spawnweapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	
	self updateTeamTime();
}

getJoinTeamPermissions(team)
{
	teamcount = 0;
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if((isdefined(player.pers["team"])) && (player.pers["team"] == team))
			teamcount++;
	}
	
	if(teamcount < level.teamlimit)
		return true;
	else
		return false;
}

/*setPlayerModels()
{
	switch(game["allies"])
	{
		case "british":
			if(isdefined(game["british_soldiertype"]) && game["british_soldiertype"] == "africa")
			{
				mptype\british_africa::precache();
				game["allies_model"] = mptype\british_africa::main;
			}
			else
			{
				mptype\british_normandy::precache();
				game["allies_model"] = mptype\british_normandy::main;
			}
			break;
	
		case "russian":
			if(isdefined(game["russian_soldiertype"]) && game["russian_soldiertype"] == "padded")
			{
				mptype\russian_padded::precache();
				game["allies_model"] = mptype\russian_padded::main;
			}
			else
			{
				mptype\russian_coat::precache();
				game["allies_model"] = mptype\russian_coat::main;
			}
			break;
	
		case "american":
		default:
			mptype\american_normandy::precache();
			game["allies_model"] = mptype\american_normandy::main;
	}
	
	if(isdefined(game["german_soldiertype"]) && game["german_soldiertype"] == "winterdark")
	{
		mptype\german_winterdark::precache();
		game["axis_model"] = mptype\german_winterdark::main;
	}
	else if(isdefined(game["german_soldiertype"]) && game["german_soldiertype"] == "winterlight")
	{
		mptype\german_winterlight::precache();
		game["axis_model"] = mptype\german_winterlight::main;
	}
	else if(isdefined(game["german_soldiertype"]) && game["german_soldiertype"] == "africa")
	{
		mptype\german_africa::precache();
		game["axis_model"] = mptype\german_africa::main;
	}
	else
	{
		mptype\german_normandy::precache();
		game["axis_model"] = mptype\german_normandy::main;	
	}
}*/

setPlayerModels()
{
	mptype\hunter_default::precache();
	game["allies_model"] = mptype\hunter_default::main;	

	mptype\zombie_default::precache();
	game["axis_model"] = mptype\zombie_default::main;	
}

model()
{
	self detachAll();
	
	if(self.pers["team"] == "allies")
		[[game["allies_model"] ]]();
	else if(self.pers["team"] == "axis")
		[[game["axis_model"] ]]();

	self.pers["savedmodel"] = maps\mp\_utility::saveModel();
}
CountPlayers()
{
	//chad
	players = getentarray("player", "classname");
	allies = 0;
	axis = 0;
	for(i = 0; i < players.size; i++)
	{
		if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "allies"))
			allies++;
		else if((isdefined(players[i].pers["team"])) && (players[i].pers["team"] == "axis"))
			axis++;
	}
	players["allies"] = allies;
	players["axis"] = axis;
	return players;
}

addTestClients()
{
	wait 5;

	for(;;)
	{
		if(getCvarInt("scr_testclients") > 0)
			break;
		wait 1;
	}

	ent = [];

	testclients = getCvarInt("scr_testclients");
	for(i = 0; i < testclients; i++)
	{
		ent[i] = addtestclient();
		ent[i].isbot = true;

		if(i & 1)
			team = "axis";
		else
			team = "allies";
		
		if(isDefined(ent[i])) ent[i] thread TestClient(team);
	}
}

TestClient(team)
{
	level endon("intermission");

	self thread TestClientRemoval();

	while(!isdefined(self.pers["team"]))
		wait .05;

	self notify("menuresponse", game["menu_team"], "autoassign");
	wait 0.5;

	self notify("menuresponse", "login", "test|test"); // test login

	for(;;)
	{
		if(isDefined(self) && !isAlive(self) && self.pers["team"] == "allies")
			self notify("menuresponse", game["menu_weapon_allies"], "ak47_mp");
		else if(isDefined(self) && !isAlive(self))
			self notify("menuresponse", game["menu_weapon_axis"], "katana_mp");
		else if(self.pers["team"] == "spectator")
			self notify("menuresponse", game["menu_team"], "autoassign");

		wait(1);
	}
}

TestClientRemoval()
{
	level waittill("intermission");
	kick(self getEntityNumber());
}