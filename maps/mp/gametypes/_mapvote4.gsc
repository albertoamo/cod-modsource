/***********************************************************************************************************
 MAP VOTE PACKAGE
 ORIGINALLY MADE BY NC-17 (codam, powerserver), REWORKED BY wizard220, MODIFIED BY FrAnCkY55, Modified again by bell
 
 Modified by 0ddball
***********************************************************************************************************/

init()
{
	level.awe_mapvote	= maps\mp\gametypes\_util::cvardef("zn_map_vote", 1, 0, 1, "int");
	level.zn_debug 		= maps\mp\gametypes\_util::cvardef("zn_debug", 0, 0, 1, "int");

	// Map voting
	if(!level.awe_mapvote) return;

	level.awe_mapvotetime	= maps\mp\gametypes\_util::cvardef("zn_map_vote_time", 30, 10, 180, "int");
	level.awe_mapvotereplay	= maps\mp\gametypes\_util::cvardef("zn_map_vote_replay", 0, 0, 1,"int");

	// Setup strings
	level.mapvotetext["MapVote"]		= &"Press ^2FIRE^7 to vote";
	level.mapvotetext["TimeLeft"] 		= &"^7Time Left: ^2";
	level.mapvotetext["MapVoteHeader"] 	= &"Next Map Vote";

	// Precache stuff used by map voting
	precacheString(level.mapvotetext["MapVote"]);
	precacheString(level.mapvotetext["TimeLeft"]);
	precacheString(level.mapvotetext["MapVoteHeader"]);

	thread GetMapCandidate();
}

Initialise()
{
	if(!level.awe_mapvote) return;

	level.awe_mapvotehudoffset = -7;

	// Small wait
	wait .5;

	// Cleanup some stuff to free up some resources
	CleanUp();

	// Create HUD
	CreateHud();

	// Start mapvote thread	
	thread RunMapVote();

	// Wait for voting to finish
	level waittill("VotingComplete");

	// Delete HUD
	DeleteHud();
}

CleanUp()
{
	level notify("cleanUP_endmap");

	setCvar("sv_hostname", getCvar("zn_hostname") + " ^4[^7End map^4]");

	if(isdefined(level.counter)) level.counter destroy();
	if(isdefined(level.clock)) level.clock destroy();
	if(isdefined(level.headicon)) level.headicon destroy();
	if(isdefined(level.hmine)) level.hmine destroy();
	if(isdefined(level.hmedpack)) level.hmedpack destroy();
	if(isdefined(level.hpower)) level.hpower destroy();
	if(isdefined(level.hmine2)) level.hmine2 destroy();
	if(isdefined(level.hmedpack2)) level.hmedpack2 destroy();
	if(isdefined(level.hpower2)) level.hpower2 destroy();
	if(isdefined(level.slogo)) level.slogo destroy();
	if(isdefined(level.ilogo)) level.ilogo destroy();

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		players[i] thread maps\mp\gametypes\_basic::RemoveHuds( false, true );
		players[i] thread maps\mp\gametypes\_deathicons::removeDeathIcon(players[i].clientid);
		players[i] notify("kill_monitors");
		players[i] thread maps\mp\gametypes\_sprint::CleanupKilled();
		//players[i] thread maps\mp\gametypes\_plusscore::CleanUp();
	}

	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
}

CreateHud()
{
	level.MapVoteHud = [];
	// top line
	level.MapVoteHud[0] = newHudElem();
	level.MapVoteHud[0].hideWhenInMenu = true;
	level.MapVoteHud[0].alignX = "center";
	level.MapVoteHud[0].x = 319.5;
	level.MapVoteHud[0].y = 115;
	level.MapVoteHud[0].alpha = 0.3;
	level.MapVoteHud[0].sort = 9994;
	level.MapVoteHud[0].color = (1,0,0);
	level.MapVoteHud[0] setShader("white", 318, 2);
	level.MapVoteHud[0].horzAlign = "fullscreen";
	level.MapVoteHud[0].vertAlign = "fullscreen";

	// mid line
	level.MapVoteHud[1] = newHudElem();
	level.MapVoteHud[1].hideWhenInMenu = true;
	level.MapVoteHud[1].alignX = "center";
	level.MapVoteHud[1].x = 319.5;
	level.MapVoteHud[1].y = 138; //248
	level.MapVoteHud[1].alpha = 0.3;
	level.MapVoteHud[1].sort = 9994;
	level.MapVoteHud[1].color = (1,0,0);
	level.MapVoteHud[1] setShader("white", 318, 2);
	level.MapVoteHud[1].horzAlign = "fullscreen";
	level.MapVoteHud[1].vertAlign = "fullscreen";

	// btm line
	level.MapVoteHud[2] = newHudElem();
	level.MapVoteHud[2].hideWhenInMenu = true;
	level.MapVoteHud[2].alignX = "center";
	level.MapVoteHud[2].x = 319.5;
	level.MapVoteHud[2].y = 273;
	level.MapVoteHud[2].alpha = 0.3;
	level.MapVoteHud[2].sort = 9994;
	level.MapVoteHud[2].color = (1,0,0);
	level.MapVoteHud[2] setShader("white", 318, 2);
	level.MapVoteHud[2].horzAlign = "fullscreen";
	level.MapVoteHud[2].vertAlign = "fullscreen";

	// background
	level.MapVoteHud[7] = newHudElem();
	level.MapVoteHud[7].hideWhenInMenu = true;
	level.MapVoteHud[7].alignX = "center";
	level.MapVoteHud[7].x = 320;
	level.MapVoteHud[7].y = 113;
	level.MapVoteHud[7].alpha = 0.7;
	level.MapVoteHud[7].color = (0,0,0);
	level.MapVoteHud[7].sort = 9993;
	level.MapVoteHud[7] setShader("white", 326, 164);
	level.MapVoteHud[7].horzAlign = "fullscreen";
	level.MapVoteHud[7].vertAlign = "fullscreen";

	// left line
	level.MapVoteHud[3] = newHudElem();
	level.MapVoteHud[3].hideWhenInMenu = true;
	level.MapVoteHud[3].alignX = "center";
	level.MapVoteHud[3].x = 160;
	level.MapVoteHud[3].y = 115;
	level.MapVoteHud[3].alpha = 0.3;
	level.MapVoteHud[3].sort = 9994;
	level.MapVoteHud[3].color = (1,0,0);
	level.MapVoteHud[3] setShader("white", 2, 160);
	level.MapVoteHud[3].horzAlign = "fullscreen";
	level.MapVoteHud[3].vertAlign = "fullscreen";

	// right line
	level.MapVoteHud[4] = newHudElem();
	level.MapVoteHud[4].hideWhenInMenu = true;
	level.MapVoteHud[4].alignX = "center";
	level.MapVoteHud[4].x = 480;
	level.MapVoteHud[4].y = 115;
	level.MapVoteHud[4].alpha = 0.3;
	level.MapVoteHud[4].sort = 9994;
	level.MapVoteHud[4].color = (1,0,0);
	level.MapVoteHud[4] setShader("white", 2, 160);
	level.MapVoteHud[4].horzAlign = "fullscreen";
	level.MapVoteHud[4].vertAlign = "fullscreen";

	mapvotetexty = 122; // 253

	// header
	level.MapVoteHud[5] = newHudElem();
	level.MapVoteHud[5].hideWhenInMenu = true;
	level.MapVoteHud[5].x = 200;
	level.MapVoteHud[5].y = mapvotetexty;
	level.MapVoteHud[5].alpha = 1;
	level.MapVoteHud[5].fontscale = 1.0;
	level.MapVoteHud[5].sort = 9994;
	level.MapVoteHud[5] setText(level.mapvotetext["MapVote"]);
	level.MapVoteHud[5].horzAlign = "fullscreen";
	level.MapVoteHud[5].vertAlign = "fullscreen";

	// time
	level.MapVoteHud[6] = newHudElem();
	level.MapVoteHud[6].hideWhenInMenu = true;
	level.MapVoteHud[6].alignX = "right";
	level.MapVoteHud[6].x = 465;
	level.MapVoteHud[6].y = mapvotetexty;
	level.MapVoteHud[6].alpha = 1;
	//level.MapVoteHud[6].color = (0,0,0);
	level.MapVoteHud[6].fontscale = 1.0;
	level.MapVoteHud[6].sort = 9994;
	level.MapVoteHud[6].label = level.mapvotetext["TimeLeft"];
	level.MapVoteHud[6] setValue(level.awe_mapvotetime);
	level.MapVoteHud[6].horzAlign = "fullscreen";
	level.MapVoteHud[6].vertAlign = "fullscreen";

	level.MapVoteNames = [];
	// choice of maps/gametypes
	level.MapVoteNames[0] = newHudElem();
	level.MapVoteNames[1] = newHudElem();
	level.MapVoteNames[2] = newHudElem();
	level.MapVoteNames[3] = newHudElem();
	level.MapVoteNames[4] = newHudElem();
	level.MapVoteNames[5] = newHudElem();
	level.MapVoteNames[6] = newHudElem();

	level.MapVoteVotes = [];
	// values for each selection
	level.MapVoteVotes[0] = newHudElem();
	level.MapVoteVotes[1] = newHudElem();
	level.MapVoteVotes[2] = newHudElem();
	level.MapVoteVotes[3] = newHudElem();
	level.MapVoteVotes[4] = newHudElem();
	level.MapVoteVotes[5] = newHudElem();
	level.MapVoteVotes[6] = newHudElem();

	yPos = 122;
	yPos += 25;

	for (i = 0; i < level.MapVoteNames.size; i++)
	{
		level.MapVoteNames[i].hideWhenInMenu = true;
		level.MapVoteNames[i].x = 200;
		level.MapVoteNames[i].y = yPos;
		level.MapVoteNames[i].alpha = 1;
		level.MapVoteNames[i].sort = 9995;
		level.MapVoteNames[i].fontscale = 1.2;
		level.MapVoteNames[i].horzAlign = "fullscreen";
		level.MapVoteNames[i].vertAlign = "fullscreen";
		//
		level.MapVoteVotes[i].hideWhenInMenu = true;
		level.MapVoteVotes[i].alignX = "right";
		level.MapVoteVotes[i].x = 465;
		level.MapVoteVotes[i].y = yPos;
		level.MapVoteVotes[i].alpha = 1;
		level.MapVoteVotes[i].sort = 9996;
		level.MapVoteVotes[i].fontscale = 1.2;
		level.MapVoteVotes[i].horzAlign = "fullscreen";
		level.MapVoteVotes[i].vertAlign = "fullscreen";
		//
		yPos += 17;
	}
}

GetMapCandidate()
{
	maps = undefined;
	x = undefined;

	currentgt = getCvar("g_gametype");
	currentmap = getCvar("mapname");
 
	if(getCvar ("zn_map_vote_gametypes") != "")
		maps = GetRandomMapVoteRotation();
    	else
		maps = maps\mp\gametypes\_util::GetRandomMapRotation();

	if(!isdefined(maps))
	{
		level.awe_mapvote = 0;
		LogPrint("Debug: No maps found\n");
		return;
	}

	level.mapcandidate = [];

	// Fill all alternatives with the current map in case there is not enough unique maps
	for(j=0;j<7;j++)
	{
		level.mapcandidate[j] = [];
		level.mapcandidate[j]["map"] = currentmap;
		level.mapcandidate[j]["mapname"] = "Replay this map";
		level.mapcandidate[j]["locmapname"] = &"Replay this map";
		level.mapcandidate[j]["gametype"] = currentgt;
		level.mapcandidate[j]["votes"] = 0;
	}
	
	//get candidates
	i = 0;
	for(j=0;j<7;j++)
	{
		// Skip current map and gametype combination
		if(maps[i]["map"] == currentmap && maps[i]["gametype"] == currentgt)
			i++;

		// Any maps left?
		if(!isdefined(maps[i]))
			break;

		level.mapcandidate[j]["map"] = maps[i]["map"];
		level.mapcandidate[j]["mapname"] = maps\mp\gametypes\_util::getMapName(maps[i]["map"]);
		level.mapcandidate[j]["locmapname"] = maps\mp\gametypes\_util::getLocMapName(maps[i]["map"]);
		level.mapcandidate[j]["gametype"] = maps[i]["gametype"];
		level.mapcandidate[j]["votes"] = 0;

		i++;

		// Any maps left?
		if(!isdefined(maps[i]))
			break;

		// Keep current map as last alternative?
		if(level.awe_mapvotereplay && j>4)
			break;
	}

	//precacheString(&")");
	//precacheString(&" (");
	

	for(j=0;j<level.mapcandidate.size;j++)
	{
		precacheString(level.mapcandidate[j]["locmapname"]);
	}

	/*

	gtrotstr = getcvar("zn_map_vote_gametypes");
	gtrot_array = listOfStringsToArray(gtrotstr);
		
	for (i=0;i<gtrot_array.size;i++)
	{
		gt=gtrot_array[i];
		precacheString(getLocalizedGametype(gt));
	}*/
}

RunMapVote()
{	
	thread DisplayMapChoices();
	
	game["menu_team"] = "";

	//start a voting thread per player
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		players[i] thread PlayerVote();
	
	thread VoteLogic();	
}

DeleteHud()
{
	level.MapVoteHud[0] destroy();
	level.MapVoteHud[1] destroy();
	level.MapVoteHud[2] destroy();
	level.MapVoteHud[3] destroy();
	level.MapVoteHud[4] destroy();
	level.MapVoteHud[5] destroy();
	level.MapVoteHud[6] destroy();
	level.MapVoteHud[7] destroy();
	level.MapVoteNames[0] destroy();
	level.MapVoteNames[1] destroy();
	level.MapVoteNames[2] destroy();
	level.MapVoteNames[3] destroy();
	level.MapVoteNames[4] destroy();
	level.MapVoteNames[5] destroy();
	level.MapVoteNames[6] destroy();
	level.MapVoteVotes[0] destroy();
	level.MapVoteVotes[1] destroy();
	level.MapVoteVotes[2] destroy();
	level.MapVoteVotes[3] destroy();	
	level.MapVoteVotes[4] destroy();
	level.MapVoteVotes[5] destroy();
	level.MapVoteVotes[6] destroy();

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		if(isdefined(players[i].vote_indicator))
			players[i].vote_indicator destroy();
}

//Displays the map candidates
DisplayMapChoices()
{
	level endon("VotingDone");

	for (i = 0; i < level.MapVoteNames.size; i++)
	{
		if (isDefined(level.mapcandidate[i]))
		{
			//if (isDefined(level.mapcandidate[i]["gametype"]))
				//level.MapVoteNames[i] setText(level.mapcandidate[i]["mapname"] + &" (" + level.mapcandidate[i]["gametype"] + &")");
			//else
				level.MapVoteNames[i] setText(level.mapcandidate[i]["locmapname"]);
		}
		wait 0.05;
	}
}

//Changes the players vote as he hits the attack button and updates HUD
PlayerVote()
{
	level endon("VotingDone");
	self endon("disconnect");
	self notify ( "reset_outcome" );

	novote = false;
	
	// No voting for spectators
	if(self.pers["team"] == "spectator")
		novote = true;
		
	if (isDefined(self.pers["isBot"]))
		novote = true;

	// Spawn player as spectator
	self maps\mp\gametypes\_util::spawnSpectator();
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	resettimeout();
	
	//remove the scoreboard
	self setClientCvar("g_scriptMainMenu", "");
	self closeMenu();

	self allowSpectateTeam("allies", false);
	self allowSpectateTeam("axis", false);
	self allowSpectateTeam("freelook", false);
	self allowSpectateTeam("none", true);

	if(novote)
		return;

	colors[0] = (0  ,  0,  1);
	colors[1] = (0  ,0.5,  1);
	colors[2] = (0  ,  1,  1);
	colors[3] = (0  ,  1,0.5);
	colors[4] = (0  ,  1,  0);
	colors[5] = (1  ,  0,  1);
	colors[6] = (1  ,  0.5,  1);
	colors[0] = (1, 0, 0);
	
	self.vote_indicator = newClientHudElem( self );
	self.vote_indicator.alignY = "middle";
	self.vote_indicator.x = 161;
	self.vote_indicator.y = level.awe_mapvotehudoffset + 120;
	self.vote_indicator.archived = false;
	self.vote_indicator.sort = 9998;
	self.vote_indicator.alpha = 0;
	self.vote_indicator.color = colors[0];
	self.vote_indicator setShader("white", 318, 17);
	
	hasVoted = false;

	for(;;)
	{
		wait .01;

		if(self attackButtonPressed() == true)
		{
			// -- Added by Number7 --
			if(!hasVoted)
			{
				self.vote_indicator.alpha = .3;
				self.votechoice = 0;
				hasVoted = true;
			}
			else
				self.votechoice++;

			if (self.votechoice == 7)
				self.votechoice = 0;

			self iprintln("You have voted for ^2" + level.mapcandidate[self.votechoice]["mapname"]);
			self.vote_indicator.y = 130 + 25 + self.votechoice * 17;			
			//self.vote_indicator.color = colors[self.votechoice];

			self playLocalSound("ui_mp_timer_countdown");
		}					
		while(self attackButtonPressed() == true)
			wait.01;

		self.sessionstate = "spectator";
		self.spectatorclient = -1;
	}
}

//Determines winning map and sets rotation
VoteLogic()
{
	//Vote Timer
	for ( ; level.awe_mapvotetime >= 0; level.awe_mapvotetime--)
	{
		for(j=0;j<10;j++)
		{
			// Count votes
			for(i=0;i<7;i++)	level.mapcandidate[i]["votes"] = 0;
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
				if(isdefined(players[i].votechoice))
					level.mapcandidate[players[i].votechoice]["votes"]++;

			// Update HUD
			level.MapVoteVotes[0] setValue( level.mapcandidate[0]["votes"] );
			level.MapVoteVotes[1] setValue( level.mapcandidate[1]["votes"] );
			level.MapVoteVotes[2] setValue( level.mapcandidate[2]["votes"] );
			level.MapVoteVotes[3] setValue( level.mapcandidate[3]["votes"] );
			level.MapVoteVotes[4] setValue( level.mapcandidate[4]["votes"] );
			level.MapVoteVotes[5] setValue( level.mapcandidate[5]["votes"] );
			level.MapVoteVotes[6] setValue( level.mapcandidate[6]["votes"] );
			wait .1;
		}
		
		level.MapVoteHud[6] setValue( level.awe_mapvotetime );
	}	

	wait 0.2;
	
	newmapnum = 0;
	topvotes = 0;
	for(i=0;i<7;i++)
	{
		if (level.mapcandidate[i]["votes"] > topvotes)
		{
			newmapnum = i;
			topvotes = level.mapcandidate[i]["votes"];
		}
	}

	SetMapWinner(newmapnum);
}

getMapVoteCount(map)
{
	loc = getMapVoteCountLocation(map);
	file = OpenFile(loc, "read");
	
	count = 0;
	
	if(file != -1)
	{
		farg = freadln(file);
		if(farg > 0)
		{
			memory = fgetarg(file, 0);
			count = int(memory);
		}
		closefile(file);
	}
	
	return count;
}

getMapVoteCountLocation(map)
{
	return ("mapvote/" + map + ".ini");
}

saveMapWinner(map)
{
	loc = getMapVoteCountLocation(map);
	count = getMapVoteCount(map) + 1;

	file = OpenFile(loc, "write");
	
	if(file != -1)
	{
		FPrintLn(file,count);
		CloseFile(file);
	}
}

//change the map rotation to represent the current selection
SetMapWinner(winner)
{
	map		= level.mapcandidate[winner]["map"];
	mapname	= level.mapcandidate[winner]["mapname"];
	gametype	= level.mapcandidate[winner]["gametype"];

	level thread saveMapWinner(map);

	setCvar("sv_mapRotationCurrent", " gametype " + gametype + " map " + map);

	wait 0.1;

	// Stop threads
	level notify( "VotingDone" );

	// Wait for threads to die
	wait 0.05;

	// Announce winner
	iprintlnbold("^2T^9HE WINNER IS");
	iprintlnbold("^2" + mapname);
	iprintlnbold("^2" + maps\mp\gametypes\_util::GetGametypeName(gametype));

	// Fade HUD elements
	level.MapVoteHud[0] fadeOverTime (1);
	level.MapVoteHud[1] fadeOverTime (1);
	level.MapVoteHud[2] fadeOverTime (1);
	level.MapVoteHud[3] fadeOverTime (1);
	level.MapVoteHud[4] fadeOverTime (1);
	level.MapVoteHud[5] fadeOverTime (1);
	level.MapVoteHud[6] fadeOverTime (1);
	level.MapVoteHud[7] fadeOverTime (1);
	level.MapVoteNames[0] fadeOverTime (1);
	level.MapVoteNames[1] fadeOverTime (1);
	level.MapVoteNames[2] fadeOverTime (1);
	level.MapVoteNames[3] fadeOverTime (1);
	level.MapVoteNames[4] fadeOverTime (1);
	level.MapVoteNames[5] fadeOverTime (1);
	level.MapVoteNames[6] fadeOverTime (1);
	level.MapVoteVotes[0] fadeOverTime (1);
	level.MapVoteVotes[1] fadeOverTime (1);
	level.MapVoteVotes[2] fadeOverTime (1);
	level.MapVoteVotes[3] fadeOverTime (1);	
	level.MapVoteVotes[4] fadeOverTime (1);
	level.MapVoteVotes[5] fadeOverTime (1);
	level.MapVoteVotes[6] fadeOverTime (1);

	level.MapVoteHud[0].alpha = 0;
	level.MapVoteHud[1].alpha = 0;
	level.MapVoteHud[2].alpha = 0;
	level.MapVoteHud[3].alpha = 0;
	level.MapVoteHud[4].alpha = 0;
	level.MapVoteHud[5].alpha = 0;
	level.MapVoteHud[6].alpha = 0;
	level.MapVoteHud[7].alpha = 0;
	level.MapVoteNames[0].alpha = 0;
	level.MapVoteNames[1].alpha = 0;
	level.MapVoteNames[2].alpha = 0;
	level.MapVoteNames[3].alpha = 0;
	level.MapVoteNames[4].alpha = 0;
	level.MapVoteNames[5].alpha = 0;
	level.MapVoteNames[6].alpha = 0;
	level.MapVoteVotes[0].alpha = 0;
	level.MapVoteVotes[1].alpha = 0;
	level.MapVoteVotes[2].alpha = 0;
	level.MapVoteVotes[3].alpha = 0;	
	level.MapVoteVotes[4].alpha = 0;
	level.MapVoteVotes[5].alpha = 0;
	level.MapVoteVotes[6].alpha = 0;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].vote_indicator))
		{
			players[i].vote_indicator fadeOverTime (1);
			players[i].vote_indicator.alpha = 0;
		}
	}

	// Show winning map for a few seconds
	wait 4;
	level notify( "VotingComplete" );
}

GetRandomMapVoteRotation()
{
	gtrotstr = getcvar("zn_map_vote_gametypes");
	gtrot_array = listOfStringsToArray(gtrotstr);
	
	// Spawn entity to hold the array
	
	maps = [];
	z=0;
		
	for (i=0;i<gtrot_array.size;i++)
	{
		gt=gtrot_array[i];
		gtmaprotstr = getcvar("zn_map_vote_" + gt + "_maps");
		if (isdefined(gtmaprotstr))
		{
			gtmaprot = listOfStringsToArray(gtmaprotstr);
		  
		  	for (j=0; j<gtmaprot.size; j++)
		  	{
				//if(MapExists(gtmaprot[j]) && gtmaprot[j] != getCvar("mapname"))
				//{
		  			maps[z]["gametype"] = gt;
		  			maps[z]["map"] = gtmaprot[j];
		  			z++;
				//}
				//else if(gtmaprot[j] != getCvar("mapname"))
				//{
				//	LogPrint( "Invalid map (" + gtmaprot[j] + ") in vote system. (gt:" + gt + ")\n");
				//	PrintLn( "Invalid map (" + gtmaprot[j] + ") in vote system. (gt:" + gt + ")\n" );
				//}
		  	}
		}
	}

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


	return maps;
}

listOfStringsToArray(list)
{
		
	list = maps\mp\gametypes\_util::strip(list);
		
	j=0;
	temparr2[j] = "";	
	for(i=0;i<list.size;i++)
	{
		if(list[i]==" ")
		{
			j++;
			temparr2[j] = "";
		}
		else
			temparr2[j] += list[i];
	}

	// Remove empty elements (double spaces)
	temparr = [];
	for(i=0;i<temparr2.size;i++)
	{
		element = maps\mp\gametypes\_util::strip(temparr2[i]);
		if(element != "")
		{
			if(level.zn_debug) iprintln("list" + temparr.size + ":" + element);
			temparr[temparr.size] = element;
		}
	}
	return temparr;
}

isConfig(cfg)
{
	temparr = explode(cfg,".");
	if(temparr.size == 2 && temparr[1] == "cfg")
		return true;
	else
		return false;
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

isGametype(gt)
{
	switch(gt)
	{
		case "dm":
		case "tdm":
		case "sd":
		case "dom":
		case "koth":
		case "sab":
		case "ctfb":
		case "htf":
		case "ctf":
		case "re":
		case "cnq":
		case "ch":
		case "hq":
		case "zom":
			return true;

		default:
			return false;
	}
}

getLocalizedGametype(gt)
{
	switch(gt)
	{
		case "dm":
			return &"dm";

		case "tdm":
			return &"tdm";

		case "sd":
			return &"sd";

		case "dom":
			return &"dom";

		case "koth":
			return &"koth";

		case "sab":
			return &"sab";

		case "ctfb":
			return &"ctfb";

		case "htf":
			return &"htf";

		case "ctf":
			return &"ctf";

		case "re":
			return &"re";

		case "cnq":
			return &"cnq";

		case "ch":
			return &"ch";

		case "hq":
			return &"hq";

		case "zom":
			return &"zom";

		default:
			return &"?";
	}
}
