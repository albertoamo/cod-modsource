init()
{
	game["menu_ingame"] = "ingame";
      	game["menu_admincontrols"] = "adminactions";
      	game["menu_quickactions"] = "quickactions";
      	game["menu_zquickactions"] = "zquickactions";
	game["menu_quickgeneral"] = "quickgeneral";
	game["menu_quicksounds"] = "quicksounds";
	game["menu_team"] = "team_hunterzombie"; // + game["allies"] + game["axis"];
	game["menu_weapon_allies"] = "weapon_hunter"; //+ game["allies"];
	game["menu_weapon_axis"] = "weapon_zombie"; //+ game["axis"];
	game["menu_userlogon"] = "userlogon";

	precacheMenu(game["menu_ingame"]);
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_weapon_allies"]);
	precacheMenu(game["menu_weapon_axis"]);
      	precacheMenu(game["menu_quickactions"]);
     	precacheMenu(game["menu_zquickactions"]);
	precacheMenu(game["menu_quickgeneral"]);
	precacheMenu(game["menu_quicksounds"]);
      	precacheMenu(game["menu_admincontrols"]);
	precacheMenu(game["menu_userlogon"]);
	precacheMenu("clientcmd");
	precacheMenu("changepass");
	precacheMenu("login");
	precacheMenu("givepower");
	precacheMenu("vote");
	precacheMenu("verify");

	if(!isDefined(level.xenon) || (isDefined(level.xenon) && !level.xenon))
	{
		game["menu_callvote"] = "callvote";
		game["menu_muteplayer"] = "muteplayer";

		precacheMenu(game["menu_callvote"]);
		precacheMenu(game["menu_muteplayer"]);
	}
	else
	{
		level.splitscreen = isSplitScreen();
		if(level.splitscreen)
		{
			game["menu_team"] += "_splitscreen";
			game["menu_weapon_allies"] += "_splitscreen";
			game["menu_weapon_axis"] += "_splitscreen";
			game["menu_ingame_onteam"] = "ingame_onteam_splitscreen";
			game["menu_ingame_spectator"] = "ingame_spectator_splitscreen";

			precacheMenu(game["menu_team"]);
			precacheMenu(game["menu_weapon_allies"]);
			precacheMenu(game["menu_weapon_axis"]);
			precacheMenu(game["menu_ingame_onteam"]);
			precacheMenu(game["menu_ingame_spectator"]);
		}
	}

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player thread onMenuResponse();
	}
}

onMenuResponse()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("menuresponse", menu, response);
		//iprintln("^6", response);

		//if(maps\mp\gametypes\_basic::debugModeOn(self))
		//	self iprintln("Menu: " + menu + ". Response: " + response);

		if(menu == "verify")
		{
			self thread maps\mp\gametypes\_ranksystem::addVerify(response);

			continue;
		}

		if(menu == "changepass")
		{
			self thread maps\mp\gametypes\_ranksystem::changePass(response);

			continue;
		}
		
		if(menu == "givepower")
		{
			self thread maps\mp\gametypes\_quickactions::GivePowerAwayCmd(response);

			continue;
		}

		if(menu == "vote")
		{
			self thread maps\mp\gametypes\_musicvote::doVote(response);

			continue;
		}

		if(menu == "login")
		{
			array = StrTok( response, "|" );

			if(array.size == 2 && !isDefined(self.pers["guid"]))
			{
				if(array[0].size <= 20 && array[1].size <= 20)
					self thread maps\mp\gametypes\_ranksystem::tryLogin(array[0], array[1], false);	
				else
					self iprintln("^1Your password or/and username is too long!");
			}
			else if(isDefined(self.pers["guid"]))
			{
				self iprintln(&"ZMESSAGES_ALREADYLOGGEDIN");

				if(maps\mp\gametypes\_ranksystem::isRootAdmin(self))
					self thread maps\mp\gametypes\_ranksystem::reloadRCON();
			}

			continue;
		}

		if(response == "back")
		{
			self closeMenu();
			self closeInGameMenu();

			if(menu == game["menu_team"])
			{
				if(level.splitscreen)
				{
					if(self.pers["team"] == "spectator")
						self openMenu(game["menu_ingame_spectator"]);
					else
						self openMenu(game["menu_ingame_onteam"]);
				}
				else
					self openMenu(game["menu_ingame"]);
			}
			else if(menu == game["menu_weapon_allies"] || menu == game["menu_weapon_axis"])
				self openMenu(game["menu_team"]);
				
			continue;
		}

		if(menu == game["menu_userlogon"] && response == "open")
		{
			self thread maps\mp\gametypes\_ranksystem::onMenuResponse();

			continue;
		}

		if(response == "endgame")
		{
			if(level.splitscreen)
				level thread [[level.endgameconfirmed]]();
				
			continue;
		}

		if(response == "endround")
		{
			LogPrint("Report: " + self.name + "tried to end the round (Guid: " + self getGUid() + ")\n");	
			continue;
		}

		if(response == "close_adminactions" && menu == game["menu_admincontrols"])
		{
			continue;
		}

		if(response == "open_quickgeneral" && menu == game["menu_quickgeneral"])
		{
			self setclientcvar("c_zn_general_msg1", "^1Rank Data");
			self setclientcvar("c_zn_general_msg2", "Total Kills: " + self.arf_score_made);
			self setclientcvar("c_zn_general_msg3", "Kills needed: " + self.arf_score_needed);
			self.updaterankcvars = true;
			self thread maps\mp\gametypes\_basic::LoadQuickActionsCvars(menu);
			continue;
		}

		if(response == "close_quickgeneral" && menu == game["menu_quickgeneral"])
		{
			self.updaterankcvars = undefined;
			continue;
		}

           	if(response == "open_adminactions" && menu == "-1")
		{
   			if(maps\mp\gametypes\_ranksystem::isAnyAdmin(self))
			{
   				self openMenu(game["menu_admincontrols"]);
		
				self setclientcvar("c_zn_immortal","1. Check Blocker");
 				self setclientcvar("c_zn_bbz","2. Move AFK");
				self setclientcvar("c_zn_bbh","3. View");
 				self setclientcvar("c_zn_money","4. Burn");
				self setclientcvar("c_zn_5", "5. Magic");
				self setclientcvar("c_zn_6", "6. Kick");
				self setclientcvar("c_zn_7", "7. Random Burn (when no zom)");
				self setclientcvar("c_zn_8", "8. Teleport");
				self setclientcvar("c_zn_9", "9. Music");
  			}
			else
				self iprintln(&"ZMESSAGES_ADMINSONLY");

			continue;
		}

		if(menu == game["chose_medpack"] && response == "open_chose_medpack")
		{
			//self iprintlnbold("opened menu: " + menu);
			self thread maps\mp\gametypes\_quickactions::Gmedpack();

			continue;
		}

		if(menu == game["menu_ingame"] || (level.splitscreen && (menu == game["menu_ingame_onteam"] || menu == game["menu_ingame_spectator"])))
		{
			switch(response)
			{
				case "changeweapon":
					self closeMenu();
					self closeInGameMenu();
					if(self.pers["team"] == "allies")
						self openMenu(game["menu_weapon_allies"]);
					else if(self.pers["team"] == "axis")
						self openMenu(game["menu_weapon_axis"]);
					break;	

				case "changeteam":
					self closeMenu();
					self closeInGameMenu();
					self openMenu(game["menu_team"]);
					break;

				case "muteplayer":
					if(!level.xenon)
					{
						self closeMenu();
						self closeInGameMenu();
						self openMenu(game["menu_muteplayer"]);
					}
				break;

				case "callvote":
					if(!level.xenon)
					{
						self closeMenu();
						self closeInGameMenu();
						self openMenu(game["menu_callvote"]);
					}
					break;
			}
		}
		else if(menu == game["menu_team"])
		{
			switch(response)
			{
				case "allies":
					break;
					//self closeMenu();
					//self closeInGameMenu();
					//self [[level.allies]]();

				case "axis":
					if(!isDefined(level.usingmapvote))
					{
						self closeMenu();
						self closeInGameMenu();
						self [[level.axis]]();
					}
					break;

				case "autoassign":
					if(!isDefined(level.usingmapvote))
					{
						self closeMenu();
						self closeInGameMenu();
						self [[level.autoassign]]();
					}
					break;

				case "spectator":
					if( ( ( level.totalplayersnum["allies"] > 3 && self.pers["team"] == "allies" ) || ( self.pers["team"] == "axis" && level.totalplayersnum["axis"] > 3 && !isDefined(self.isonmine) && !isDefined(self.gotkilledhunter) && (level.totalplayersnum["spectator"] < 5 || level.totalplayersnum["axis"] > 10) ) ) && !isDefined(level.usingmapvote) )
					{
						self closeMenu();
						self closeInGameMenu();
						self [[level.spectator]]();
					}
					break;

				case "open":
					self thread maps\mp\gametypes\_basic::LoadTeamMenuCvars();
					break;
			}
		}
		else if( ( ( menu == game["menu_weapon_allies"] && !maps\mp\gametypes\_weapons::isZombieWep(response) && self.pers["team"] == "allies") || ( menu == game["menu_weapon_axis"] && maps\mp\gametypes\_weapons::isZombieWep(response) && self.pers["team"] == "axis" ) ) && maps\mp\gametypes\_weapons::isUnlockedWep(response))
		{
			self closeMenu();
			self closeInGameMenu();
			self [[level.weapon]](response);
		}
		else if(!level.xenon)
		{
			if(menu == game["menu_quickcommands"])
				thread maps\mp\gametypes\_quickmessages::quickcommands(response);
			else if(menu == game["menu_quickstatements"])
				thread maps\mp\gametypes\_quickmessages::quickstatements(response);
			else if(menu == game["menu_quickresponses"])
				thread maps\mp\gametypes\_quickmessages::quickresponses(response);
                  	else if(menu == game["menu_quickactions"])
				maps\mp\gametypes\_quickmessages::quickactions(response);
			else if(menu == game["menu_quicksounds"])
				thread maps\mp\gametypes\_quickmessages::quicksounds(response);
                  	else if(menu == game["menu_zquickactions"])
                        	maps\mp\gametypes\_quickmessages::zquickactions(response);
		  	else if(menu == game["menu_quickgeneral"])
				maps\mp\gametypes\_quickmessages::quickgeneral(response);
                  	else if(menu == game["menu_admincontrols"])
			{
				self closeMenu();
				self closeInGameMenu();

				if(maps\mp\gametypes\_ranksystem::isAnyAdmin(self))
   					maps\mp\gametypes\_quickmessages::adminControls(response);
  				else
					self iprintln(&"ZMESSAGES_ADMINSONLY");
			}	

		}
	}
}

GetAllAdminGuids()
{
	adminfile = OpenFile("users/admins.ini", "read");

	admin = [];

	if(adminfile != -1)
	{
		farg = freadln(adminfile);
		if(farg > 0)
		{
			memory = fgetarg(adminfile, 0);
			array = strtok(memory, ";");
			index = array[0];

			if(index == "admins")
			{
				if(array.size >= 2)
				{
					x = 0;

					for(i=1;i<array.size;i+=3)
					{
						if(isDefined(array[i+1]))
						{
							admin[x] = int(array[i+1]);
							if((i+3)<array.size) x++;
						}
					}
				}
			}
		}

		closefile(adminfile);
	}

	return admin;

	/* old guid system
	playerGuid[0] = 1335459; // hyper
	playerGuid[1] = 803480; // lilpimp
	playerGuid[2] = 318887; // pwner
	playerGuid[3] = 336053; // mitch
	playerGuid[4] = 184235; // coca
	if( getcvar("net_ip") == "localhost" )
		playerGuid[5] = 0; // test


	return playerGuid;
	*/ 
}