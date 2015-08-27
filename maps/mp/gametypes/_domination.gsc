// * Credits:
// *
// * DOMination 2 gametype from  Nedgerblansky, Tally, Oddball based on the
// * original work of Matthias Lorenz on his mod ADMIRALMod, http://www.cod2mod.com.
// *
// * Modified by Mitch

init()
{
	if(getCvar("zn_domination_" + getCvar("mapname")) != "1") return;

	level.compassflag_allies 	= "compass_flag_" + game["allies"];
	level.compassflag_axis 	= "compass_flag_" + game["axis"];
	
	level.objpointflag_allies 	= "objpoint_flagpatch1_" + game["allies"];	
	level.objpointflag_axis	= "objpoint_flagpatch1_" + game["axis"];

	precacheShader ("hudStopwatch");
	precacheShader("white");

	precacheShader(level.compassflag_allies);
	precacheShader(level.objpointflag_allies);
	
	precacheShader(level.compassflag_axis);
	precacheShader(level.objpointflag_axis);

	precacheModel("xmodel/prop_flag_" + game["allies"]);
	precacheModel("xmodel/prop_flag_" + game["axis"]);
	precacheModel ("xmodel/prop_flag_base");

	level.showobjdom = false;

	level.flagcapturetime = 30;
	level.pointscaptureflag = 2;
	level.flagtimeout = 1200; // 9 mins

	level.progressBarHeight = 12;

	if(level.splitscreen)
		level.progressBarWidth = 152;
	else
		level.progressBarWidth = 192;

	thread initFlags();
}

initFlags()
{
	level.hud_dom_pos_y = 20;
	level.flag_radius 	= 80;
	
	level.flags = [];
	spawnpoints = getentarray("mp_tdm_spawn", "classname");

	for (i = 0; i < spawnpoints.size; i++)
		spawnpoints[i] placeSpawnpoint ();

	j = randomInt(spawnpoints.size);
	level.flags[0] = spawnpoints[j];

	flagsnumber = 3;

	trys = 0;
		
	while(level.flags.size < flagsnumber) 
	{
		trys++;
		if(trys > 100) break;
		
		j = randomInt(spawnpoints.size);
			
		near = false;
			
		for(i=0;i<level.flags.size;i++) 
		{
			if(distance(spawnpoints[j].origin,level.flags[i].origin) < 1000) 
			{
				near = true;
				break;
			}
		}
		
		if(near == true) 
			continue;
			
		level.flags[level.flags.size] = spawnpoints[j];
	}

  	flags = level.flags;	
	
	for(i=0;i<flags.size;i++) 
	{
		flags[i].flagmodel 	= spawn("script_model", flags[i].origin);
		flags[i].flagmodel.angles 		= flags[i].angles;
		flags[i].flagmodel setmodel("xmodel/prop_flag_" + game["axis"]);
	
		flags[i].basemodel 	= spawn("script_model", flags[i].origin);
		flags[i].basemodel.angles = flags[i].angles;
		flags[i].basemodel setmodel("xmodel/prop_flag_base");

		flags[i].team = "axis";
		flags[i].objective = i;
		flags[i].compassflag = level.compassflag_axis;
		flags[i].objpointflag = level.objpointflag_axis;
		flags[i].playerscount = 0;
		flags[i].progresstime = 0;
		flags[i].timeout = false;
		flags[i].reachable = undefined;

		flags[i] thread flag();		

		//level createLevelHudElement ("flag_" + flags[i].objective, 325 + 36 * i - 18 * (flags.size - 1), level.hud_dom_pos_y, "center", "middle", "fullscreen", "fullscreen", false, game["hudicon_axis"], 32, 32, 1, 0.8, 1, 1, 1);
	}
}

createLevelHudElement(hud_element_name, x,y,xAlign,yAlign,horzAlign,vertAlign,foreground,shader,shader_width,shader_height,sort,alpha,color_r,color_g,color_b) 
{
	
	if(!isDefined(level.hud)) level.hud = [];
	
	count = level.hud.size;

	level.hud[count] = newHudElem();
	level.hud[count].x = x;
	level.hud[count].y = y;
	level.hud[count].alignX = xAlign;
	level.hud[count].alignY = yAlign;
	level.hud[count].horzAlign = horzAlign;
	level.hud[count].vertAlign = vertAlign;
	level.hud[count].foreground = foreground;
	level.hud[count] setShader(shader, shader_width, shader_height);	
	level.hud[count].sort = sort;
	level.hud[count].alpha = alpha;
	level.hud[count].color = (color_r,color_g,color_b);
	
	level.hud[count].name 			= hud_element_name;
	level.hud[count].shader_name 	= shader;
	level.hud[count].shader_width 	= shader_width;
	level.hud[count].shader_height 	= shader_height;
}

flag()
{
	level endon("intermission");

	if(level.showobjdom) objective_add(self.objective, "current", self.origin, self.compassflag);
	self createFlagWaypoint();

	trigger = spawn("trigger_radius", self.origin, 0, level.flag_radius, 50);	

	self thread onCapture(trigger);

	for(;;) 
	{
		trigger waittill("trigger", other);	
	
		if(isPlayer(other) && !self.timeout && other.pers["team"] != self.team && self DOM_CanCapture (other, other.pers["team"]) && other.sessionstate == "playing" && !isdefined(other.iscapturingflag)) 
		{
			other.iscapturingflag = true;
			self thread startCaptureProgress(other, trigger);
			self.playerscount++;
			
			//if(maps\mp\gametypes\_basic_util::debugModeOn(other))
			//	other iprintln("Flag() : trigger : Count:" + self.playerscount);
		}

		if(!isDefined(self.reachable))
			self.reachable = true;	
		
		wait 0.1;
	}
}

changeLevelHudElementByName(hud_element_name,alpha) 
{
	if(isDefined(level.hud) && level.hud.size > 0) 
	{
	
		for(i=0;i<level.hud.size;i++) 
		{
			if(isDefined(level.hud[i].name) && level.hud[i].name == hud_element_name) 
			{
 				if(isDefined(level.hud[i])) level.hud[i].alpha = alpha;
				
				break;
			}
		}	
	}
}

onCapture(trigger)
{
	//Prepare the blinking of objective icon on compass and HUD.
	origin 	= self.origin;
	swatch 	= 0;
	helper = self.basemodel;
	counter = 0;

	for(;;)
	{
		// Axis
		compass_icon[0] = level.objpointflag_allies;
		compass_icon[1] = level.objpointflag_axis;
		hud_icon[0] = level.compassflag_axis;
		hud_icon[1] = level.compassflag_allies;
		team[0] = game["allies"];
		team[1] = game["axis"];

		if(self.team == "allies")
		{
			compass_icon[0] = level.objpointflag_allies;
			compass_icon[1] = level.objpointflag_axis;
			hud_icon[0] = level.compassflag_allies;
			hud_icon[1] = level.compassflag_axis;
			team[0] = game["axis"];
			team[1] = game["allies"];
		}

		//helper.isplaying = false;

		currenticon = self.objpointflag;

		while(self.progresstime < level.flagcapturetime)
		{	
			if(self.playerscount > 0)
			{
				//if(!helper.isplaying) helper playloopsound("dom_start_flag_capture");
				//helper.isplaying = true;
				capturing = true;

				swatch++;
				if(swatch > 1) swatch = 0;

				currenticon = compass_icon[swatch];
				self createFlagWaypoint(currenticon);

				flagModel = "xmodel/prop_flag_" + team[swatch];
				self.flagmodel setmodel(flagModel);	

				//Compass and HUD blink.
				if(level.showobjdom) objective_icon(self.objective, compass_icon[swatch] );
	  
	  			//level changeLevelHudElementShaderByName ("flag_" + self.objective, hud_icon[swatch], 32, 32);	

				self.progresstime += 0.5;
			}
			else
			{
				self.progresstime = 0;

				if(level.showobjdom) objective_icon(self.objective, self.compassflag);
				//level changeLevelHudElementShaderByName ("flag_" + self.objective, hud_icon[1], 32, 32);

				//helper stopLoopSound();
				//helper.isplaying = false;

				if(currenticon != self.objpointflag)
				{
					self createFlagWaypoint();
					currenticon = self.objpointflag;
				}

				flagModel = "xmodel/prop_flag_" + team[1];
				self.flagmodel setmodel(flagModel);	
			}
		
			wait 0.45;

			if(!isDefined(self.reachable))
			{
				counter++;
				
				if(counter >= level.flagtimeout)
				{
					counter = 0;
					self FlagTimeOut();
				}
			}
		}

		self.timeout = true;

		self.progresstime  = 0;	
		//helper stopLoopSound();

		self GetFlag(trigger); // Getting flag
		self.timeout = false;
	}
}

startCaptureProgress(other, trigger) 
{
	other DOM_SetCaptureProgressIndicator();
  
	// * Objective capture *	
	while(isAlive(other) && (self.progresstime < level.flagcapturetime)) 
	{
		//Player (other) not in flag radius or dead
    		if(!(self DOM_CanCapture(other, other.pers["team"])) || !(other isTouching(trigger)) ) 
   		{
   			other DOM_DestroyCaptureProgressIndicator();

			other.iscapturingflag = undefined;
			self.playerscount--;
			  
			return;
		}

		if(isDefined(other.progressbar_domcapture2)) other.progressbar_domcapture2 setShader("white", int(self.progresstime / level.flagcapturetime * (level.progressBarWidth - 4)), level.progressBarHeight - 4);
		
		wait 0.45;
	}
		
	if(isPlayer(other))
		other DOM_DestroyCaptureProgressIndicator();

	wait(1);
	other.iscapturingflag = undefined;
}

givePlayerPoints(points, trigger) 
{		
	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++) 
	{
		if(players[i].sessionstate == "playing" && self.team != players[i].pers["team"] && players[i] isTouching(trigger)) 
		{	
			players[i].score = players[i].score + points;

			if(self.playerscount == 1)
				iprintln(players[i].name + "^7 Has Captured A Flag^1!");
			else
				players[i] iprintln("^7You Have Captured A Flag^1!");

			players[i] iprintln("^4Y^7ou have earned ^1" + points + " ^7points.");

			//if(players[i] maps\mp\gametypes\_basic_util::debugModeOn())
			//	players[i] iprintln("givePlayerPoints : Count:" + self.playerscount);

			break;
		}
	}	
}

GetFlag(trigger) 
{
	level endon("intermission");

	if(self.playerscount > 1)
	{
		if(self.team == "axis") 
			iprintln("^7The ^1Hunters^7 Have Captured A Flag^1!");
		else
			iprintln("^7The ^1Zombies^7 Have Captured A Flag^1!");

		wait(0.5);
	}

	if(level.pointscaptureflag > 0) 
	{
		self givePlayerPoints(level.pointscaptureflag, trigger);
	}

	self.playerscount = 0;
	
	if(self.team == "axis") 
	{
		self.team = "allies";	
		self.compassflag = level.compassflag_allies;

		if(level.showobjdom)
			objective_icon(self.objective, self.compassflag);

		self.objpointflag = level.objpointflag_allies;

		flagModel = "xmodel/prop_flag_" + game["allies"];
		self.flagmodel setmodel(flagModel);

		self thread DebugPlayerMsg(trigger, "GetFlag() : Axis > Allies");
		
		//level changeLevelHudElementShaderByName("flag_" + self.objective, game["hudicon_allies"], 32, 32);

	}
	else 
	{
		self.team = "axis";	  	
		self.compassflag = level.compassflag_axis;

		if(level.showobjdom) 
			objective_icon(self.objective, self.compassflag);

		self.objpointflag = level.objpointflag_axis;

		flagModel = "xmodel/prop_flag_" + game["axis"];
		self.flagmodel setmodel(flagModel);

		self thread DebugPlayerMsg(trigger, "GetFlag() : Allies > Axis");

		//level changeLevelHudElementShaderByName("flag_" + self.objective, game["hudicon_axis"], 32, 32);
	}

	self createFlagWaypoint();			
}

DebugPlayerMsg(trigger, msg)
{
	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++) 
	{
		if(players[i].sessionstate == "playing" && players[i] isTouching(trigger)) 
		{	
			//if(players[i] maps\mp\gametypes\_basic_util::debugModeOn())
			//	players[i] iprintln(msg);

			break;
		}
	}
}

DOM_SetCaptureProgressIndicator()
{
	if(!isdefined(self.progressbar_domcapture))
	{
		self.progressbar_domcapture = newClientHudElem(self);
		self.progressbar_domcapture.x = 0;

		if(level.splitscreen)
			self.progressbar_domcapture.y = 70;
		else
			self.progressbar_domcapture.y = 104;

		self.progressbar_domcapture.alignX = "center";
		self.progressbar_domcapture.alignY = "middle";
		self.progressbar_domcapture.horzAlign = "center_safearea";
		self.progressbar_domcapture.vertAlign = "center_safearea";
		self.progressbar_domcapture.alpha = 0.5;
	}

	self.progressbar_domcapture setShader("black", level.progressBarWidth, level.progressBarHeight);

	if(!isdefined(self.progressbar_domcapture2))
	{
		self.progressbar_domcapture2 = newClientHudElem(self);
		self.progressbar_domcapture2.x = ((level.progressBarWidth / (-2)) + 2);

		if(level.splitscreen)
			self.progressbar_domcapture2.y = 70;
		else
			self.progressbar_domcapture2.y = 104;

		self.progressbar_domcapture2.alignX = "left";
		self.progressbar_domcapture2.alignY = "middle";
		self.progressbar_domcapture2.horzAlign = "center_safearea";
		self.progressbar_domcapture2.vertAlign = "center_safearea";
		self.progressbar_domcapture2.color = (0,0,1);
	}

	//self.progressbar_domcapture2 setShader("white", 0, level.progressBarHeight - 4);
}

//Player Method: Destroy the Capture Progress Indicator.

DOM_DestroyCaptureProgressIndicator()
{
	self notify("stopped_capturing");

	if(isDefined(self.progressbar_domcapture))
		self.progressbar_domcapture Destroy();

	if(isDefined(self.progressbar_domcapture2))
		self.progressbar_domcapture2 Destroy();
}

DOM_CanCapture(player,team)
{
	return (isdefined(player) && isalive(player) && (player.sessionstate == "playing") && (distance(player.origin, self.origin) < level.flag_radius) && ( checkOtherPlayerInRange(player.clientid, self.origin, EnemyTeam (team), level.flag_radius) == -1 )); 
}

EnemyTeam(team)
{
	if(team == "allies")
		return "axis";
	else
		return "allies";
}

checkOtherPlayerInRange(client_id, origin, team, radius) 
{
	wait 0.05;
	
	players = getentarray("player", "classname");

	for(i = 0; i < players.size; i++) 
	{             
		if(players[i].sessionstate == "playing" && isDefined(players[i].pers["team"]) && (players[i].pers["team"] == team || team == "all") && distance(players[i].origin,origin) < radius && players[i].clientid != client_id) 
		{
			return players[i].clientid;			
		}
	}		
	
	return -1;
}

changeLevelHudElementShaderByName(hud_element_name, shader, shader_width, shader_height) 
{
	if(isDefined(level.hud) && level.hud.size > 0) 
	{
	
		for(i=0;i<level.hud.size;i++) 
		{
			if(isDefined(level.hud[i].name) && level.hud[i].name == hud_element_name) 
			{
 				if(isDefined(level.hud[i])) level.hud[i] setShader(shader, shader_width, shader_height);
				
				break;
			}
		}	
	}
}

deleteFlagWaypoint()
{
	if(isdefined(self.waypoint_flag))
		self.waypoint_flag destroy();
}

IsAwayFromFlags (mindist)
{
	for (i = 0; i < level.flags.size; i ++)
		if (distance (self.origin, level.flags[i].origin) < mindist)
			return false;
	
	return true;
}

FlagTimeOut()
{	
	while (isdefined (level.FlagTimeOut_running) && level.FlagTimeOut_running)
		// No multiple occurrences allowed otherwise new flag point selection will yield unpredictable results
		wait (randomint (10) / 10);
	
	level.FlagTimeOut_running = true;
	self.flagmodel hide ();
	self.basemodel hide ();
	self deleteFlagWaypoint ();
	if(level.showobjdom) objective_state (self.objective, "invisible");
	//level changeLevelHudElementByName ("flag_" + self.objective, 0);

	spawnpoints = getentarray ("mp_tdm_spawn", "classname");
	
	new_point = undefined;
	for (i = 0; i < 100 ; i ++)
	{
		new_point = spawnpoints[randomint (spawnpoints.size)];
		if (new_point IsAwayFromFlags (1000))
			break;
	}

	wait 5;

	self.origin = new_point.origin;
	self.flagmodel.origin = self.origin;
	self.flagmodel.angles = self.angles;
	self.basemodel.origin = self.origin;
	self.basemodel.angles = self.angles;
	//level changeLevelHudElementByName ("flag_" + self.objective, 0.8);
	if(level.showobjdom) objective_position (self.objective, self.origin);
	if(level.showobjdom) objective_state (self.objective, "current");
	self createFlagWaypoint ();
	self.flagmodel show ();
	self.basemodel show ();

	level.FlagTimeOut_running = false;
}

createFlagWaypoint(icon)
{
	self deleteFlagWaypoint();

	waypoint = newHudElem();
	waypoint.x = self.origin[0];
	waypoint.y = self.origin[1];
	waypoint.z = self.origin[2] + 100;
	waypoint.alpha = .61;
	waypoint.archived = true;

	if(!isDefined(icon))
		icon = self.objpointflag;

	if(level.splitscreen)
		waypoint setShader(icon, 14, 14);
	else
	{
		waypoint setShader(icon, 7, 7);
	}

	waypoint setwaypoint(true);
	self.waypoint_flag = waypoint;
}