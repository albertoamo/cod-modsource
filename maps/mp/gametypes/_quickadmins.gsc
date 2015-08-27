// All menu based admin actions

blockCheck()
{
	player = self AdminHud(true, true);

	if(isPlayer(player))
	{
		player thread maps\mp\gametypes\_admin::CheckBlock(undefined);
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "checkblock", player);
	}
}

moveAfk()
{
	player = self AdminHud(false);

	if(isPlayer(player))
	{
		player thread maps\mp\gametypes\_admin::MoveAfk();
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "moveafk", player);
	}
}

View()
{
	player = self AdminHud(true, true);		

	if(isPlayer(player))
	{
		iprintln(self.name + " ^7used view " + player.name + "^1.");
		player thread maps\mp\gametypes\_admin::View();	
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "view", player);
	}
}

Burn()
{
	player = self AdminHud(true, true);
	
	if(isPlayer(player))
	{
		iprintln(self.name + " ^7burned " + player.name + "^1.");
		player thread maps\mp\gametypes\_admin::Burn(true);
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "burn", player);
	}
}

Respawn()
{
	player = self AdminHud(true, true);

	if(isPlayer(player))
	{
		iprintln(self.name + " ^7respawned " + player.name + "^1.");
		player thread maps\mp\gametypes\_admin::Magic();
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "magic", player);
	}
}

kickPlayer()
{
	player = self AdminHud(false);

	if(isPlayer(player) && !maps\mp\gametypes\_ranksystem::isAnyAdmin(player))
	{
		iprintln(player.name + " ^7got kicked by " + self.name + "^1.");
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "kick", player);
		maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_BEINGKICKED", self, player);

		wait(1.5);

		Kick(player GetEntityNumber());
	}
	else if(isPlayer(player) && maps\mp\gametypes\_ranksystem::isAnyAdmin(player))
		self iprintlnbold("^4Y^7ou cannot kick admins^1!");
}

randomBurn()
{
	if(level.totalplayersnum["axis"] == 0 && !isDefined(level.randomburnactive))
	{
		maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_STARTEDRANDOMBURN", self);
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "randomburn");
		self thread maps\mp\gametypes\_admin::RandomBurn();
	}
}

Teleport()
{
	player = self AdminHud(true);

	if(isPlayer(player) && player != self && !maps\mp\gametypes\_ranksystem::isRootAdmin(player))
	{
		trace = self maps\mp\gametypes\_admin::getTargetPosition();
		pos = trace["position"];
		iprintln(self.name + " ^7teleported " + player.name + "^1.");
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "teleport", player);
		player setOrigin(pos);
	}
	else if(isPlayer(player) && player == self)
		self iprintlnbold(&"ZMESSAGES_TELEPORTYOURSELF");
	else if(isPlayer(player) && maps\mp\gametypes\_ranksystem::isRootAdmin(player))
		self iprintlnbold(&"ZMESSAGES_TELEPORTROOTADMIN");		
}

playerInfo()
{
	player = self AdminHud(false, true);

	if(isPlayer(player)) 
	{
		self maps\mp\gametypes\_admin::OutputPlayerInfo(player);
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "playerinfo", player);
	}			
}

Status()
{
	if(gotPowerRights(self))
	{
		self thread maps\mp\gametypes\_admin::RconStatus();
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "status");
	}
}

randomPlay()
{
	if(!isDefined(level.randomplayactive))
	{
		iprintln(self.name + " ^7started Random Play^1.");
		maps\mp\gametypes\_ranksystem::logAdminAction(self, "randomplay");
		self thread maps\mp\gametypes\_admin::RandomPlay();
	}
}

endMap()
{
	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ENDEDMAPBY", self);
	maps\mp\gametypes\_ranksystem::logAdminAction(self, "endmap");
	setCvar ("endmap", "true");		
}

Music()
{
	maps\mp\gametypes\_ranksystem::logAdminAction(self, "musichud");
	self thread maps\mp\gametypes\_admin::playMusic(true);		
}

changeMap()
{
	if(gotPowerRights(self))
	{
		newmap = self MapChoser();

		if(isDefined(newmap))
		{
			iprintln(self.name + " ^7is changing the map to " + maps\mp\gametypes\_util::getMapName(newmap) + "^1.");
			maps\mp\gametypes\_ranksystem::logAdminAction(self, "map;" + newmap);
			wait(2);
			Map(newmap, false);
		}
	}		
}

gotPowerRights(player)
{
	if(maps\mp\gametypes\_ranksystem::isPowerAdmin(player))
		return true;
	else
	{
		player iprintln("^1You Need To Be At Least Control Senior Admin To Use This Function!!!");
		return false;
	}	
}

AdminHud(activeonly, lookat)
{
	self closeMenu();

	if(isDefined(self.adminhudtext) || isDefined(self.adminhudchoser)) 
	{
		self iprintlnbold("^1You already got an admin player choser hud open!!!");
		return;
	}

	selected = 0;
	player = undefined;

	if(isDefined(lookat) && lookat)
	{
		p = self maps\mp\gametypes\_quickactions::getLookAtPlayer();
		if(isPlayer(p))
		{
			players = getentarray("player", "classname");
		
			for(i=0;i<players.size;i++)
			{
				if(players[i] == p)
				{
					selected = i;
					break;
				}
			}
		}
	}
	
       	self.adminhudtext = newClientHudElem(self);
	self.adminhudtext.horzAlign = "center";
	self.adminhudtext.vertAlign = "middle";
	self.adminhudtext.x = -140;
	self.adminhudtext.y = -60;
	self.adminhudtext.fontScale = 1;
	self.adminhudtext.alpha = 1;

       	self.adminhudchoser = newClientHudElem(self);
	self.adminhudchoser.horzAlign = "center";
	self.adminhudchoser.vertAlign = "middle";
	self.adminhudchoser.x = -140;
	self.adminhudchoser.y = -40;
	self.adminhudchoser.fontScale = 1;
	self.adminhudchoser.alpha = 1;
	self.adminhudchoser.label = (&"ZMESSAGES_SELECTEDPLAYER");

	players = getentarray("player", "classname");
	player = players[selected];

	self.adminhudtext setText(&"ZMESSAGES_SELECTCONTROLS");
	self.adminhudchoser SetPlayerNameString(player);

	while(isAlive(self))
	{
		if(self usebuttonpressed())
		{
			if(self meleeButtonPressed() && (isAlive(player) || !activeonly) )
				break;
			else if(self meleeButtonPressed() && !isAlive(player) && isPlayer(player) && activeonly)
			{
				maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_PLNOTALIVE", player, self);
				player = undefined;
			}
			else
			{
				players = getentarray("player", "classname");

				if(self getweaponslotweapon("primaryb") == self getcurrentweapon())
				{
					selected--;
					if(selected < 0)
						selected = players.size-1;
				}
				else
				{
					selected++;
					if(selected > players.size-1)
						selected = 0;				
				}			

				player = players[selected];

				if(isDefined(self.adminhudchoser)) self.adminhudchoser SetPlayerNameString(player);
			}

			while(self usebuttonpressed())
				wait(0.05);
		}
		
		if(self attackButtonPressed())
		{
			player = undefined;
			break;
		}

		wait(0.05);
	}

	if(isDefined(self.adminhudtext)) self.adminhudtext Destroy();
	if(isDefined(self.adminhudchoser)) self.adminhudchoser Destroy();

	if(!isAlive(self))
		player = undefined;

	return player;
}

MapChoser()
{
	self closeMenu();

	if(isDefined(self.adminhudtext2) || isDefined(self.adminhudchoser2)) 
		return;

	selected = 0;
	
	self.adminhudtext2 = newClientHudElem(self);
	self.adminhudtext2.horzAlign = "center";
	self.adminhudtext2.vertAlign = "middle";
	self.adminhudtext2.x = -140;
	self.adminhudtext2.y = -60;
	self.adminhudtext2.fontScale = 1;
	self.adminhudtext2.alpha = 1;

       	self.adminhudchoser2 = newClientHudElem(self);
	self.adminhudchoser2.horzAlign = "center";
	self.adminhudchoser2.vertAlign = "middle";
	self.adminhudchoser2.x = -140;
	self.adminhudchoser2.y = -40;
	self.adminhudchoser2.fontScale = 1;
	self.adminhudchoser2.alpha = 1;
	self.adminhudchoser2.label = (game["adminhud_selectmap"]);
	self.adminhudtext2 setText(&"ZMESSAGES_SELECTCONTROLS");

	gt = getCvar("g_gametype");
	maps = StrTok( getCvar("zn_map_vote_" + gt + "_maps"), " ");

	map = maps[selected];
	self.adminhudchoser2 SetMapNameString(map);

	while(isAlive(self))
	{
		if(self usebuttonpressed())
		{
			if(self meleeButtonPressed())
				break;
			else
			{
				if(self getweaponslotweapon("primaryb") == self getcurrentweapon())
				{
					selected--;
					if(selected < 0)
						selected = maps.size-1;
				}
				else
				{
					selected++;
					if(selected > maps.size-1)
						selected = 0;				
				}			

				map = maps[selected];

				if(isDefined(self.adminhudchoser2)) self.adminhudchoser2 SetMapNameString( map );
			}

			while(self usebuttonpressed())
				wait(0.05);
		}
		
		if(self attackButtonPressed())
		{
			map = undefined;
			break;
		}

		wait(0.05);
	}

	if(isDefined(self.adminhudtext2)) self.adminhudtext2 Destroy();
	if(isDefined(self.adminhudchoser2)) self.adminhudchoser2 Destroy();

	if(!isAlive(self))
		map = undefined;

	return map;
}