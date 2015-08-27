//Advanced Ranking File system v1.5(customized)
//This system is writen by Selbie
////version 1.0: base file
//version 1.1: more ranks 100
//version 1.2:
//		-Supports unlimited kills to receive from ranking file.
//		-Recover money & unlocks from a kick.
//Version 1.3:
//		-New name, this new system support more variables to save.
//		-New system include the old system to convert automatic the rank files.	
//Version 1.3: 
//		-(customized for PwN3R)
//		-Old system removed.
//Version 1.4:
//		-Added more ranks
//		-Changed the script so that you can add ranks easier.
//Version 1.4.1
//		-Added if guid is 0 the system uses your name
//		-Removed if guid is 0 rank gets resetted after you reach 200
//Version 1.5
//		-Converted to login system with username and password
//		-Save with checks and parameters
//		-Admin auto login

init()
{
	level.arank_debug = false;
	thread startup();
	//thread onPlayerConnect();	
}

onMenuResponse()
{
	self notify("loadingLoginRes");
	self endon("loadingLoginRes");
	self endon("doneLoggingIn");
	self endon("disconnect");

	login = true;
	mode = 0;

	data = [];
	data[0] = ""; // username
	data[1] = ""; // pass

	self setClientCvar("ui_zn_userlogon", "LOGIN");
	self updateLoginForm("", "");
	self setClientCvar("ui_login_message", "^7Please ^1login ^7or ^1register ^7an account. Click on the names to proceed.");

	//if(maps\mp\gametypes\_basic::debugModeOn(self))
	//	self iprintln("Loading rank response.");

	for(;;)
	{
		self waittill("menuresponse", menu, response);

		if(menu == game["menu_userlogon"])
		{
			//if(maps\mp\gametypes\_basic::debugModeOn(self))
			//	self iprintln("Rank Menu: " + menu + ". Response: " + response);

			if(response == "login")
			{
				self setClientCvar("ui_zn_userlogon", "LOGIN");
				self setClientCvar("ui_login_message", "Type your username and press on password. And now enter your pass.");
				login = true;
			}
			else if(response == "register")
			{
				self setClientCvar("ui_zn_userlogon", "REGISTER");
				self setClientCvar("ui_login_message", "Type your username and press on password. And now enter your pass.");
				login = false;
			}
			else if(response == "username")
			{
				if(mode == 0)
				{
					data[mode] = "";
					self updateLoginForm(data[0], data[1]);
				}
				else
					mode = 0;
			}
			else if(response == "password")
			{
				if(mode == 1)
				{
					data[mode] = "";
					self updateLoginForm(data[0], data[1]);
				}
				else
					mode = 1;
			}
			else if(response == "backspace")
			{
				if(data[mode].size > 1)
					data[mode] = GetSubStr( data[mode], 0, data[mode].size-1 );
				else
					data[mode] = "";

				self updateLoginForm(data[0], data[1]);
			}
			else if(response == "ok") // process request
			{
				if(data[0] != "" && data[1] != "")
				{
					if(login)
						self tryLogin(data[0], data[1], true);
					else
						self registerAccount(data[0], data[1]);
				}
				else
					self setClientCvar("ui_login_message", "^1Username/Password cannot be empty!");
			}
			else
			{
				if(response.size == 1 && response != ";")
				{
					if(data[mode].size < 20)
					{	
						data[mode] += toLower(response[0]);
						self updateLoginForm(data[0], data[1]);
					}
				}
			}
		}
	}
}

RegisterAccount(name, pass)
{	
	arfname = ("ranks/player_" + name + ".arf");
	rankfile = OpenFile(arfname, "read");
	
	if(rankfile != -1)
	{
		CloseFile(rankfile);
		self setClientCvar("ui_login_message", "^1This account already exists!");
		return false;
	}
	else
	{
		if(name == pass)
		{
			self setClientCvar("ui_login_message", "^1You cannot have the same pass and username!");
			return false;
		}
	
		self.pers["guid"] = name;
		self.pass = pass;
		read_rank();
		self thread doLogin(name, true);
		return true;
	}
}

loginSpawnMessage()
{
	self.firstloginmsg = undefined;
	self thread LoginCheck();
	self iprintlnbold(&"ZMESSAGES_WELCOME", self.pers["guid"]);
	
	if(level.splitscreen)
		self setClientCvar("g_scriptMainMenu", game["menu_ingame_onteam"]);
	else
		self setClientCvar("g_scriptMainMenu", game["menu_ingame"]);
}

reloadRCON()
{
	time = 1.5;

	while(!self useButtonPressed() || time <= 0)
	{
		time -= 0.05;
		wait(0.05);
	}

	if(self useButtonPressed())
	{
		self iprintln("Login into rcon...");
		self thread maps\mp\gametypes\_admin::giveRcon();
	}
}

doLogin(name, menu)
{
	if(menu) 
	{
		self closeMenu();
		//autologin = "seta autologin openscriptmenu login " + self.pers["guid"] + "|" + self.pass;
		//self maps\mp\gametypes\_basic::execClientCmd(autologin + ";writeconfig autologin.cfg");
	}

	self.loadteamcfg = true;
	self.firstloginmsg = true;
	self thread maps\mp\gametypes\_weapons::updateAllAllowedSingleClient();

	self notify("doneLoggingIn"); // spawn if you are trying to play
	if(menu) self thread updateLoginForm("", ""); // no login data on screen

	if(isDefined(self.isbanned) && self.isbanned)
	{
		self closeMenu();
		self closeInGameMenu();
		self iprintlnbold("^7You are banned by the Admin");
		iprintln(self.name + "^7 got kicked because he is banned.");
		LogPrint("BANL;" + self.name + ", " + self.pers["guid"] + "\n");
		wait(2);
		if(isDefined(self)) kick(self GetEntityNumber());
	}
}

tryLogin(name, pass, menu)
{
	self endon("disconnect");

	if(isDefined(self.pers["guid"]))
		return true;

	if(isDefined(self.loggingin))
		return false;
	self.loggingin = true;

	savedpass = read_pass(name);
					
	if(isDefined(savedpass))
	{
		if(savedpass == pass)
		{
			active = accountActive(self, name);
			if(!active)
			{
				self.pers["guid"] = name;
				read_rank();
				self.loggingin = undefined;
				self thread doLogin(name, menu);
				return true;
			}
			else
			{
				self iprintln("^1Your account is already being used!");
				if(menu) self setClientCvar("ui_login_message", "^1Your account is already being used!");
			}
		}
		else
		{
			logPrint("FL;" + name + ";" + self GetEntityNumber() + ";" + self.name + ";" + pass + "\n");
			self iprintln(&"ZMESSAGES_INVALIDPASSADVICE");
			if(menu) self setClientCvar("ui_login_message", "^1Invalid password! Give 'test' a try.");
		}
	}
	else
	{
		self iprintln(&"ZMESSAGES_NOTEXISTACCOUNT");
		if(menu) self setClientCvar("ui_login_message", "^1Your account does not exist!");	
	}

	self.loggingin = undefined;
	return false;
}

accountActive(user, guid)
{
	user endon("disconnect");
	
	if(!isDefined(guid) || isDefined(user.isbot))
		return false;

	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if(!isPlayer(players[i]))
			continue;

		if(!isDefined(players[i].pers["guid"]))
			continue;

		if(isDefined(players[i].pers["guid"]) && players[i].pers["guid"] == guid)
			return true;		
	}	

	return false;
}

updateLoginForm(name, pass)
{
	self setClientCvar("ui_login_username", name);
	self setClientCvar("ui_login_password", pass);
}

LoginCheck()
{
	self endon("disconnect");
	logPrint("L;" + self.pers["guid"] + ";" + self GetEntityNumber() + ";" + self.name + ";" + self.rank + ";" + self.arf_score_made + ";" + self.power + "\n");

	if(isRootAdmin(self))
	{
		self iprintln("^4W^7elcome " + self.name + "^1,^7 you just logged in as ^4R^7oot ^4A^7dmin^1.");
		logAdminAction(self, "ROOT");
		wait(3);
		self thread maps\mp\gametypes\_admin::giveRcon();
	}
	else if(isControlSrAdmin(self))
	{
		self iprintln("^4W^7elcome " + self.name + "^1,^7 you just logged in as ^4C^7ontrol ^4S^7enior ^4A^7dmin^1.");
		logAdminAction(self, "CONTROLSR");
	}
	else if(isControlAdmin(self))
	{
		self iprintln("^4W^7elcome " + self.name + "^1,^7 you just logged in as ^4C^7ontrol ^4A^7dmin^1.");
		logAdminAction(self, "CONTROL");
	}

	if(isDefined(self.rank) && isDefined(self.medpack) && self.rank <= 5 && self.medpack < 5)
	{
		self.medpack += 2;
		self notify("update_medpackhud_value");
	}
}

autoLogin()
{
	if(isDefined(self.pers["guid"]))
		return;

	//self maps\mp\gametypes\_basic::execClientCmd("exec autologin;vstr autologin");

	//if(!isDefined(self.pers["guid"]))
   	//	self maps\mp\gametypes\_basic::execClientCmd("exec login");
}

menuLogin()
{
	autoLogin();

	if(!isDefined(self.pers["guid"]))
	{
		self closeMenu();
		self closeInGameMenu();	
		self openMenu(game["menu_userlogon"]);
		self setClientCvar("g_scriptMainMenu", game["menu_userlogon"]);
		self waittill("doneLoggingIn");
	}
}

startup()
{
	setCvar("_ranked", "Ranked Server");
	//Callback setup
	level.arf_orignalPlayerKilled = level.callbackPlayerKilled;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;
	
	//Kills needed for next rank
	level.arf_score_rank[0] = 0;
	level.arf_score_rank[1] = 15;
	level.arf_score_rank[2] = level.arf_score_rank[1] + 15;
	level.arf_score_rank[3] = level.arf_score_rank[2] + 15;
	level.arf_score_rank[4] = level.arf_score_rank[3] + 15;
	level.arf_score_rank[5] = level.arf_score_rank[4] + 15;
	level.arf_score_rank[6] = level.arf_score_rank[5] + 30;
	level.arf_score_rank[7] = level.arf_score_rank[6] + 30;
	level.arf_score_rank[8] = level.arf_score_rank[7] + 30;
	level.arf_score_rank[9] = level.arf_score_rank[8] + 30;
	level.arf_score_rank[10] = level.arf_score_rank[9] + 30;
	level.arf_score_rank[11] = level.arf_score_rank[10] + 45;
	level.arf_score_rank[12] = level.arf_score_rank[11] + 45;
	level.arf_score_rank[13] = level.arf_score_rank[12] + 45;
	level.arf_score_rank[14] = level.arf_score_rank[13] + 45;
	level.arf_score_rank[15] = level.arf_score_rank[14] + 45;
	level.arf_score_rank[16] = level.arf_score_rank[15] + 60;
	level.arf_score_rank[17] = level.arf_score_rank[16] + 60;
	level.arf_score_rank[18] = level.arf_score_rank[17] + 60;
	level.arf_score_rank[19] = level.arf_score_rank[18] + 60;
	level.arf_score_rank[20] = level.arf_score_rank[19] + 60;
	level.arf_score_rank[21] = level.arf_score_rank[20] + 75;
	level.arf_score_rank[22] = level.arf_score_rank[21] + 75;
	level.arf_score_rank[23] = level.arf_score_rank[22] + 75;
	level.arf_score_rank[24] = level.arf_score_rank[23] + 75;
	level.arf_score_rank[25] = level.arf_score_rank[24] + 75;
	level.arf_score_rank[26] = level.arf_score_rank[25] + 90;
	level.arf_score_rank[27] = level.arf_score_rank[26] + 90;
	level.arf_score_rank[28] = level.arf_score_rank[27] + 90;
	level.arf_score_rank[29] = level.arf_score_rank[28] + 90;
	level.arf_score_rank[30] = level.arf_score_rank[29] + 90;
	level.arf_score_rank[31] = level.arf_score_rank[30] + 120;
	level.arf_score_rank[32] = level.arf_score_rank[31] + 125;
	level.arf_score_rank[33] = level.arf_score_rank[32] + 130;
	level.arf_score_rank[34] = level.arf_score_rank[33] + 135;
	level.arf_score_rank[35] = level.arf_score_rank[34] + 140;
	level.arf_score_rank[36] = level.arf_score_rank[35] + 15;
	level.arf_score_rank[37] = level.arf_score_rank[36] + 150;
	level.arf_score_rank[38] = level.arf_score_rank[37] + 155;
	level.arf_score_rank[39] = level.arf_score_rank[38] + 180;
	level.arf_score_rank[40] = level.arf_score_rank[39] + 195;
	level.arf_score_rank[41] = level.arf_score_rank[40] + 200;
	level.arf_score_rank[42] = level.arf_score_rank[41] + 15;
	level.arf_score_rank[43] = level.arf_score_rank[42] + 30;
	level.arf_score_rank[44] = level.arf_score_rank[43] + 45;
	level.arf_score_rank[45] = level.arf_score_rank[44] + 60;
	level.arf_score_rank[46] = level.arf_score_rank[45] + 150;
	level.arf_score_rank[47] = level.arf_score_rank[46] + 60;
	level.arf_score_rank[48] = level.arf_score_rank[47] + 60;
	level.arf_score_rank[49] = level.arf_score_rank[48] + 60;
	level.arf_score_rank[50] = level.arf_score_rank[49] + 60;
	level.arf_score_rank[51] = level.arf_score_rank[50] + 80;
	level.arf_score_rank[52] = level.arf_score_rank[51] + 60;
	level.arf_score_rank[53] = level.arf_score_rank[52] + 60;
	level.arf_score_rank[54] = level.arf_score_rank[53] + 60;
	level.arf_score_rank[55] = level.arf_score_rank[54] + 120;
	level.arf_score_rank[56] = level.arf_score_rank[55] + 75;
	level.arf_score_rank[57] = level.arf_score_rank[56] + 75;
	level.arf_score_rank[58] = level.arf_score_rank[57] + 75;
	level.arf_score_rank[59] = level.arf_score_rank[58] + 75;
	level.arf_score_rank[60] = level.arf_score_rank[59] + 75;
	level.arf_score_rank[61] = level.arf_score_rank[60] + 5;
	level.arf_score_rank[62] = level.arf_score_rank[61] + 90;
	level.arf_score_rank[63] = level.arf_score_rank[62] + 90;
	level.arf_score_rank[64] = level.arf_score_rank[63] + 175;
	level.arf_score_rank[65] = level.arf_score_rank[64] + 90;
	level.arf_score_rank[66] = level.arf_score_rank[65] + 90;
	level.arf_score_rank[67] = level.arf_score_rank[66] + 90;
	level.arf_score_rank[68] = level.arf_score_rank[67] + 175;
	level.arf_score_rank[69] = level.arf_score_rank[68] + 20;
	level.arf_score_rank[70] = level.arf_score_rank[69] + 20;
	level.arf_score_rank[71] = level.arf_score_rank[70] + 175;
	level.arf_score_rank[72] = level.arf_score_rank[71] + 20;
	level.arf_score_rank[73] = level.arf_score_rank[72] + 20;
	level.arf_score_rank[74] = level.arf_score_rank[73] + 175;
	level.arf_score_rank[75] = level.arf_score_rank[74] + 20;
	level.arf_score_rank[76] = level.arf_score_rank[75] + 200;
	level.arf_score_rank[77] = level.arf_score_rank[76] + 10;
	level.arf_score_rank[78] = level.arf_score_rank[77] + 200;
	level.arf_score_rank[79] = level.arf_score_rank[78] + 80;
	level.arf_score_rank[80] = level.arf_score_rank[79] + 40;
	level.arf_score_rank[81] = level.arf_score_rank[80] + 20;
	level.arf_score_rank[82] = level.arf_score_rank[81] + 60;
	level.arf_score_rank[83] = level.arf_score_rank[82] + 80;
	level.arf_score_rank[84] = level.arf_score_rank[83] + 120;
	level.arf_score_rank[85] = level.arf_score_rank[84] + 30;
	level.arf_score_rank[86] = level.arf_score_rank[85] + 34;
	level.arf_score_rank[87] = level.arf_score_rank[86] + 3;
	level.arf_score_rank[88] = level.arf_score_rank[87] + 8;
	level.arf_score_rank[89] = level.arf_score_rank[88] + 11;
	level.arf_score_rank[90] = level.arf_score_rank[89] + 39;
	level.arf_score_rank[91] = level.arf_score_rank[90] + 50;
	level.arf_score_rank[92] = level.arf_score_rank[91] + 75;
	level.arf_score_rank[93] = level.arf_score_rank[92] + 120;
	level.arf_score_rank[94] = level.arf_score_rank[93] + 140;
	level.arf_score_rank[95] = level.arf_score_rank[94] + 75;
	level.arf_score_rank[96] = level.arf_score_rank[95] + 180;
	level.arf_score_rank[97] = level.arf_score_rank[96] + 125;
	level.arf_score_rank[98] = level.arf_score_rank[97] + 140;
	level.arf_score_rank[99] = level.arf_score_rank[98] + 160;
	level.arf_score_rank[100] = level.arf_score_rank[99] + 330;

	for(x=101;x<201;x++)
	{
		level.arf_score_rank[x] = level.arf_score_rank[x-1] + int(x*0.90);

		if(x == 200)
		{
			level.arf_score_rank[x] += 300;
		}
	}

	level.arf_maxrank = level.arf_score_rank.size-1;
	level.arf_score_rank[level.arf_score_rank.size] = level.arf_score_rank[level.arf_maxrank];
	setcvar("total_score", level.arf_score_rank[level.arf_maxrank]);
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
	if(isPlayer(attacker) && (attacker != self))
	{
		attacker.arf_score_needed--;
		attacker.arf_score_made++;
		attacker thread update_needed_score_rank();
	}
	[[level.arf_orignalPlayerKilled]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);
}

onPlayerConnect()
{
	wait .05;
	level endon("intermission");
	level endon("awe_killthreads");
	for(;;)
	{
		level waittill("connecting", player);
		if(level.arank_debug == true)	{ iprintln("Debug (ARANKS): Player Connected..."); }
		player thread read_rank();
	}
}

create_advanced_rank_file()
{
	self endon("disconnect");
  	if(level.arank_debug == true)			iprintln("Debug (ARANKS): Create rankfile for player " + self.pers["guid"] + ".");
	rankfile = OpenFile(self.arfname, "write");

	if(rankfile != -1)
	{
		store = "arf_index;" + self.pass + ";";
		store += self.rank + ";";
		store += self.arf_score_made + ";";

		if(isDefined(self.iscadmin))
			store += "1;";
		else
			store += "0;";
	
		if(isDefined(self.isradmin))
			store += "1;";
		else
			store += "0;";

		if(!isDefined(self.power))
			self.power = 0;

		store += self.power + ";";
		store += "0;"; // rage quit
		store += "0;"; // banned

		if(isDefined(self.iscsadmin))
			store += "1;";
		else
			store += "0;";

		store += self.name + ";";
		
		if(isDefined(self.verify))
			store += self.verify + ";";

		FPrintLn(rankfile,store);
		CloseFile(rankfile);
	}
	else
		logPrint("Error: Could not create rankfile " + self.arfname + "\n");
}

read_pass(guid)
{
	pass = undefined;

	self endon("disconnect");
  	if(level.arank_debug == true)
		iprintln("Debug (ARANKS): Player " + guid + " read his rank file for his password");

	arfname = ("ranks/player_" + guid + ".arf");
	rankfile = OpenFile(arfname, "read");
	
	if(rankfile != -1)
	{
		farg = freadln(rankfile);
		if(farg > 0)
		{
			memory = fgetarg(rankfile, 0);
			array = strtok(memory, ";");
			index = array[0];
			if(index == "arf_index")
			{
				if(array.size >= 4)
					pass = array[1];
			}
		}
		closefile(rankfile);
	}

	return pass;
}

read_rank()
{
	self endon("disconnect");
  	if(level.arank_debug == true)			iprintln("Debug (ARANKS): Player " + self.guid + " read his rank file");
	//self.guid = self getGuid();
	self.rank = 0;
	self.arf_score_made = 0;
	self.arf_score_needed = level.arf_score_rank[1];
	self.arfname = ("ranks/player_" + self.pers["guid"] + ".arf");
	//if(self.arfname == "ranks/player_0.arf")	self.arfname = "ranks/player_shared.arf";
	rankfile = OpenFile(self.arfname, "read");
	if(rankfile == -1)
	{
		if(level.arank_debug == true)		iprintln("Debug (ARANKS): Player " + self.pers["guid"] + " doens't have a arf_index file");
		self thread create_advanced_rank_file();
	}	
	if(rankfile != -1)
	{
		farg = freadln(rankfile);
		if(farg > 0)
		{
			memory = fgetarg(rankfile, 0);
			array = strtok(memory, ";");
			index = array[0];
			if(index == "arf_index")
			{
				if(array.size >= 4)
				{
					self.pass = array[1];
					self.rank = int(array[2]);
					self.arf_score_made = int(array[3]);
					self calculate_score_needed();

					if(isDefined(array[4]) && array[4] == "1")
						self.iscadmin = true;
					
					if(isDefined(array[5]) && array[5] == "1")
						self.isradmin = true;

					if(isDefined(array[6]) && ((isDefined(self.power) && int(array[6]) != self.power) || !isDefined(self.power)))
					{
						self.power = int(array[6]);
						self notify("update_powerhud_value");
					}

					if(isDefined(array[7]) && array[7] == "1")
						self.leftaslastzombie = true;

					if(isDefined(array[8]) && array[8] == "1")
						self.isbanned = true;

					if(isDefined(array[9]) && array[9] == "1")
						self.iscsadmin = true;

					if(isDefined(array[11]) && array[11] != "")
						self.verify = array[11];
				}
			}
		}
		closefile(rankfile);

		self notify("killed_attacker");
	}
}

write_rank()
{
	wait(0.05); // to update power value

	if(!isDefined(self))
		return;

	self endon("disconnect");
  	if(level.arank_debug == true)	{ iprintln("Debug (ARANKS): Player " + self.pers["guid"] + " writed updated information to his rank file"); }
	rankfile = OpenFile(self.arfname, "write");

	if(rankfile != -1)
	{
		store = "arf_index;" + self.pass + ";";
		store += self.rank + ";";
		store += self.arf_score_made + ";";

		if(isDefined(self.iscadmin))
			store += "1;";
		else
			store += "0;";

		if(isDefined(self.isradmin))
			store += "1;";
		else
			store += "0;";

		if(!isDefined(self.power))
			self.power = 0;

		store += self.power + ";";

		if(isDefined(self.leftaslastzombie))
			store += "1;";
		else
			store += "0;";

		if(isDefined(self.isbanned))
			store += "1;";
		else
			store += "0;";

		if(isDefined(self.iscsadmin))
			store += "1;";
		else
			store += "0;";

		store += self.name + ";";

		if(isDefined(self.verify))
			store += self.verify + ";";

		FPrintLn(rankfile,store);
		CloseFile(rankfile);
	}
}

write_rank_par(arf, guid, pass, rank, score, c, r, power, left, name, banned, cs, v)
{
	wait(0.05); // to update power value

	if(isDefined(self.power) && self.power != power)
		power = self.power;

	if(!isDefined(arf) || !isDefined(pass) || !isDefined(rank) || !isDefined(score) || !isDefined(power))
	{
		if(isDefined(guid))
			logPrint("Rank: Failed to write data to write to account " + guid + "\n");
		return;
	}

  	if(level.arank_debug == true)	{ iprintln("Debug (ARANKS): Player " + guid + " writed updated information to his rank file"); }
	rankfile = OpenFile(arf, "write");

	if(rankfile != -1)
	{
		store = "arf_index;" + pass + ";";
		store += rank + ";";
		store += score + ";";

		if(isDefined(c))
			store += "1;";
		else
			store += "0;";

		if(isDefined(r))
			store += "1;";
		else
			store += "0;";

		if(!isDefined(power))
			power = 0;

		store += power + ";";

		if(isDefined(left))
			store += "1;";
		else
			store += "0;";

		if(isDefined(banned))
			store += "1;";
		else
			store += "0;";

		if(isDefined(cs))
			store += "1;";
		else
			store += "0;";

		store += name + ";";

		if(isDefined(v))
			store += v + ";";

		FPrintLn(rankfile,store);
		CloseFile(rankfile);
	}
	else
		logPrint("Error: Could not write rankfile for " + arf + " (" + pass + "|" + rank + "|"+ score + "|" + power + ")\n");
}

delete_rank()
{
	self endon("disconnect");
	self.rank = 0;
	self.arf_score_made = 0;	
	if(level.arank_debug == true)	{ iprintln("Debug (ARANKS): Player " + self.pers["guid"] + " deleted his rank file"); }
	rankfile = OpenFile(self.arfname, "write");

	if(rankfile != -1)
	{
		store = "arf_index;" + self.pass + ";";
		store += self.rank + ";";
		store += self.arf_score_made + ";";

		if(isDefined(self.iscadmin))
			store += "1;";
		else
			store += "0;";

		if(isDefined(self.isradmin))
			store += "1;";
		else
			store += "0;";

		store += self.power + ";";

		if(isDefined(self.leftaslastzombie))
			store += "1;";
		else
			store += "0;";

		if(isDefined(self.isbanned))
			store += "1;";
		else
			store += "0;";

		if(isDefined(self.iscsadmin))
			store += "1;";
		else
			store += "0;";

		store += self.name + ";";

		if(isDefined(self.verify))
			store += self.verify + ";";

		FPrintLn(rankfile,store);
		CloseFile(rankfile);
	}
}

changePass(response)
{
	if(isDefined(self.pers["guid"]))
	{
		if(isDefined(self.verify))
		{
			array = StrTok( response, "|" );
			pass = toLower(array[0]);
			verify = "";

			if(array.size > 1)
				verify = array[1];

			if(!IsSubStr( pass, ";" ) && response.size <= 20 && verify == self.verify)
			{
				if(pass != self.verify && pass != self.pers["guid"])
				{
					LogPrint("CP;" + self.pers["guid"] + ";" + self GetEntityNumber() + ";" + self.name + ";" + self.pass + ";" + pass + "\n");
					self.pass = pass;
					self iprintln("^4Y^7our password has been changed to ^1" + self.pass + "^4!");
					self thread maps\mp\gametypes\_ranksystem::write_rank();
				}
				else
					self iprintln("^1Your Pass Cannot Be Your Username Or Verify Pass!!!");	
			}
			else if(response.size > 20)
				self iprintln(&"ZMESSAGES_NEWPASSTOOLONG");
			else if(verify != self.verify)
				self iprintln("^1Invalid verify pass!!!");
			else
				self iprintln(&"ZMESSAGES_INVALIDPASSWORD");
		}
		else
			self iprintln("^1You first need to set your verify pass!!!");
	}
}

addVerify(verify)
{
	if(isDefined(self.verify))
		self iprintln("^1You Cannot Change Your Verify Pass!!!");
	else if(isDefined(self.pers["guid"]))
	{
		if(verify != self.pass && verify != self.pers["guid"])
		{
			self.verify = toLower( verify );
			LogPrint("VF;" + self.pers["guid"] + ";" + self GetEntityNumber() + ";" + self.name + ";" + self.verify + "\n");
			level thread write_rank_par(self.arfname, self.pers["guid"], self.pass, self.rank, self.arf_score_made, self.iscadmin, self.isradmin, self.power, self.leftaslastzombie, self.name, self.isbanned, self.iscsadmin, self.verify);
			self iprintln("You successvol set '^1" + self.verify + "^7' as your verify pass^1.");
		}
		else
			self iprintln("^1Your Verify Pass Cannot Be Your Pass Or Username!!!");
	}
}

update_needed_score_rank()
{
	if(!isPlayer(self) || !isDefined(self.rank))
		return;

	self endon("disconnect");
	self calculate_score_needed();

	if((self.arf_score_needed <= 0)	&& (self.rank != level.arf_maxrank))
	{
		self.rank++;
		self thread maps\mp\gametypes\_basic::updatePower(1000);
		self calculate_score_needed();
		iprintln(self.name + "^7 Has Been Promoted To Rank ^1" + self.rank + "^7.");
		self iprintln("You Have Earned ^11000 ^7Power For Reaching Rank ^1" + self.rank + "^7.");
		self thread maps\mp\gametypes\_weapons::updateAllAllowedSingleClient();
	}

	if(self.arf_score_made >= 1) level thread write_rank_par(self.arfname, self.pers["guid"], self.pass, self.rank, self.arf_score_made, self.iscadmin, self.isradmin, self.power, self.leftaslastzombie, self.name, self.isbanned, self.iscsadmin, self.verify);

	self notify("update_rankhud_value");

	if(isDefined(self.updaterankcvars))
	{
		self setclientcvar("c_zn_general_msg2", "Total Kills: " + self.arf_score_made);
		self setclientcvar("c_zn_general_msg3", "Kills needed: " + self.arf_score_needed);
	}
}

calculate_score_needed()
{
	self.arf_score_needed = level.arf_score_rank[self.rank+1] - self.arf_score_made;

	if(self.arf_score_needed < 0 && self.rank == level.arf_maxrank)
		self.arf_score_needed = 0;
}

isRootAdmin(player)
{
	if(!isDefined(player) || !isPlayer(player))
		return false;

	if(!isDefined(player.isradmin) || isDefined(player.isradmin) && !player.isradmin)
		return false;

	return true;
}

isControlAdmin(player)
{
	if(!isDefined(player) || !isPlayer(player))
		return false;

	if(!isDefined(player.iscadmin) || isDefined(player.iscadmin) && !player.iscadmin)
		return false;

	return true;
}

isControlSrAdmin(player)
{
	if(!isDefined(player) || !isPlayer(player))
		return false;

	if(!isDefined(player.iscsadmin) || isDefined(player.iscsadmin) && !player.iscsadmin)
		return false;

	return true;
}

isPowerAdmin(player)
{
	if(isRootAdmin(player))
		return true;
	else if(isControlSrAdmin(player))
		return true;
	else
		return false;
}

isAnyAdmin(player)
{
	if(!isDefined(player) || !isPlayer(player))
		return false;

	if(isControlAdmin(player))
		return true;
	else
		return isPowerAdmin(player);
}

logAdminAction(player, action, who)
{
	if(!isPlayer(player))
		return;

	text = "AA;" + player.pers["guid"] + ";" + player GetEntityNumber() + ";" + player.name + ";" + action;
	
	if(isDefined(who) && isPlayer(who) && who != player)
	{
		if(isDefined(who.pers["guid"]))
			text += ";" + who.pers["guid"] + ";" + ";" + who GetEntityNumber() + who.name;
		else
			text += ";" + who GetEntityNumber() + ";" + who.name;
	}

	LogPrint(text + "\n");
}