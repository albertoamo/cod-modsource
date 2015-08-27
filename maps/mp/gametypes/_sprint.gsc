/*
Present Form of mod: 	Tally
Credits: 				Worm, for the heart of the mod
						Bell, for the bullet trace
						Zeppillin, for the idea of standalone
						Ravir, for cvardef
*/
#include maps\mp\_utility;

main()
{
	//---Sprint Vars-----
	level.bfe_allow_sprint = cvardef("scr_allow_sprint", 1, 0, 1,"int");
	level.bfe_sprint_time = cvardef("scr_sprint_time", 3, 0, 20, "float");
	level.bfe_sprint_regen_time = cvardef("scr_sprint_regen_time", 2, 0, 20, "int");
	level.bfe_sprint_speed = cvardef("scr_sprint_speed", 1, 0, 3, "int");
	level.bfe_sprintheavyflag = cvardef("scr_sprint_heavyflag", 1, 0, 1, "int");
	level.bfe_sprinthud = cvardef("scr_sprint_hud", 0, 0, 1,"int");
	
	//------Sprint Images-----
	game["sprint_cross"] = "gfx/hud/hud@health_cross.tga";
	game["sprinthud_back"] = "gfx/hud/hud@health_back.tga";
	game["sprinthud"] = "gfx/hud/hud@health_bar.tga";
     	precacheShader("hud_sprinter"); 
	
	Precache();
	thread Init();

}

Precache()
{
	//---Sprint
	precacheItem("sprint_med_mp");
	precacheItem("sprint_slow_mp");
	precacheItem("sprint_fast_mp");
	precacheString(&"SPRINT_HOLD_ACTIVATE");
	precacheShader(game["sprinthud_back"]);
	precacheShader(game["sprinthud"]);
	precacheShader(game["sprint_cross"]);
	precacheString(&"SPRINT_HEAVY_FLAG");
}

Init()
{
	
	if(!level.bfe_allow_sprint) return;

	level.sprint_time = int(level.bfe_sprint_time * 250);
	level.sprint_min_stamina = int(level.bfe_sprint_time * 62.5);

	regentime = level.bfe_sprint_regen_time;

	level.sprint_fast_regen = int(level.sprint_time / (regentime * 20) );
	level.sprint_fast_regen2 = level.sprint_fast_regen * 2;
	level.sprint_slow_regen = int(level.sprint_fast_regen / 2);
	level.sprint_slow_regen2 = level.sprint_slow_regen * 2;

	if(level.bfe_sprint_speed == 1)
	{
		level.sprint_weap = "sprint_slow_mp";
	}
	else if(level.bfe_sprint_speed == 2)
	{
		level.sprint_weap = "sprint_med_mp";
	}
	else if(level.bfe_sprint_speed == 3)
	{
		level.sprint_weap = "sprint_fast_mp";
	}

	if(level.bfe_allow_sprint && level.sprint_time > 25)
	{
		level thread onPlayerConnect();
		level thread Dropped_Monitor();
	}
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);

		player thread onPlayerSpawned();
		player thread onPlayerKilled();
	}
}

onPlayerKilled()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("killed_player");

		self notify("kill_monitors");
		
		thread CleanupKilled();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");

		self.is_Sprinting = false;
		self.sprint_stamina = level.sprint_time;
		self.old_position = self.origin;

		self thread Monitor_Sprint();
	}
}

Monitor_Sprint()
{
	self endon("disconnect");
	self endon("kill_monitors");
	
	maxwidth = 83;
	x = -94;
	y = -68; //-55

	if(level.bfe_sprinthud)
	{
		if(!isdefined(self.bfe_sprinthud_back))
		{
			self.bfe_sprinthud_back = newClientHudElem( self );
			self.bfe_sprinthud_back setShader(game["sprinthud_back"], maxwidth + 2, 7);
			self.bfe_sprinthud_back.horzAlign = "right";
			self.bfe_sprinthud_back.vertAlign = "bottom";
			self.bfe_sprinthud_back.x = x;
			self.bfe_sprinthud_back.y = y;
		}
		
		if(!isdefined(self.bfe_sprinthud_minus))
		{
			self.bfe_sprinthud_minus = newClientHudElem( self );
			self.bfe_sprinthud_minus setShader("hud_sprinter", 30, 20);
			self.bfe_sprinthud_minus.horzAlign = "right";
			self.bfe_sprinthud_minus.vertAlign = "bottom";
			self.bfe_sprinthud_minus.x = -115;
			self.bfe_sprinthud_minus.y = y-7;
			self.bfe_sprinthud_minus.alpha = .9;
		}
		
		if(!isdefined(self.bfe_sprinthud))
		{
			self.bfe_sprinthud = newClientHudElem( self );
			self.bfe_sprinthud setShader(game["sprinthud"], maxwidth, 5);
			self.bfe_sprinthud.color = ( 0, 0, 1);
			self.bfe_sprinthud.horzAlign = "right";
			self.bfe_sprinthud.vertAlign = "bottom";
			self.bfe_sprinthud.x = x + 1;
			self.bfe_sprinthud.y = y + 1;
		}
	}

	while (1)
	{
		wait 0.05;
		delay = 0;

		while (self useButtonPressed() && GetStance() == "stand" && self.sprint_stamina > level.sprint_min_stamina)
		{
			wait 0.1;

			if (!isMoving(self) || isHoldingNade(self) )
			{
				self.sprint_stamina = self.sprint_stamina + level.sprint_fast_regen2;
				if (self.sprint_stamina > level.sprint_time)
					  self.sprint_stamina = level.sprint_time;
				break;
			}

			if (delay < 5)
			{
				self.sprint_stamina = self.sprint_stamina + level.sprint_slow_regen2;
					
				if (self.sprint_stamina > level.sprint_time)
					 self.sprint_stamina = level.sprint_time;
				delay++;
				continue;
			}

			self Sprint();
		}
		
		if(level.bfe_sprinthud)
		{
			if(level.bfe_sprintheavyflag && isdefined(self.flagAttached)) continue;
			
			sprint = (level.sprint_time-self.sprint_stamina)/level.sprint_time;
			
			if(!self.sprint_stamina)
			{
				self.bfe_sprinthud.color = ( 1.0, 0.0, 0.0);
			}
			else	
			{
				self.bfe_sprinthud.color = ( sprint, 0, 1.0 - sprint);
			}
		
			hud_width = int((1.0 - sprint) * maxwidth);
			
			if ( hud_width < 1 )
				hud_width = 1;
			
			self.bfe_sprinthud setShader(game["sprinthud"], hud_width, 5);
		}

		if (self.sprint_stamina == level.sprint_time)
			continue;

		if (isMoving(self) )
			  self.sprint_stamina = self.sprint_stamina + level.sprint_slow_regen;
		else
			  self.sprint_stamina = self.sprint_stamina + level.sprint_fast_regen;

		if (self.sprint_stamina > level.sprint_time)
			  self.sprint_stamina = level.sprint_time;
	}
}

isMoving(player)
{
	moving = true;

	if (player.old_position == player.origin)
		  moving = false;

	player.old_position = player.origin;

	return moving;
}

isHoldingNade(player)
{
	weapon = self getCurrentWeapon(player);

	switch(weapon)
	{
		case "frag_grenade_american_mp":
		case "smoke_grenade_american_mp":
		case "frag_grenade_british_mp":
		case "smoke_grenade_british_mp":
		case "frag_grenade_russian_mp":
		case "smoke_grenade_russian_mp":
		case "frag_grenade_german_mp":
		case "smoke_grenade_german_mp":
			return true;
	
		 default:
			return false;
	}
}

Sprint()
{
	self endon("disconnect");
	self notify("start_sprinting");

	if(isDefined(self.is_Sprinting) && self.is_Sprinting)
		return;

	self.is_Sprinting = true;

	// 1st get and store current weapon info
	self.sprint_weap_return = self getCurrentWeapon();
	self.primaryweap = self getWeaponSlotWeapon("primary");
    	self.sprint_weap_ammo_return = self getWeaponSlotAmmo("primary");
	self.sprint_weap_clip_return = self getWeaponSlotClipAmmo("primary");

    	if(isDefined(self getWeaponSlotWeapon("primaryb")))
    	{
		self.sprint_weap_return2 = self getWeaponSlotWeapon("primaryb");
        	self.sprint_weap_ammo_return2 = self getWeaponSlotAmmo("primaryb");
	    	self.sprint_weap_clip_return2 = self getWeaponSlotClipAmmo("primaryb");
    	}  

	self setWeaponSlotWeapon("primary", level.sprint_weap);

	if(isDefined(self getWeaponSlotClipAmmo("primaryb")))
		self takeWeapon(self getWeaponSlotClipAmmo("primaryb"));

	sprint_ammo = int( (self.sprint_stamina / level.sprint_time) * 100 );

	self setWeaponSlotAmmo("primary", sprint_ammo);
	self switchToWeapon(level.sprint_weap);
	
	maxwidth = 83;

	while ( isAlive(self) && self useButtonPressed() && GetStance() == "stand" && self.sprint_stamina > 0 )
	{
		wait 0.08;
		
		if(level.bfe_sprinthud)
		{
			sprint = (level.sprint_time-self.sprint_stamina)/level.sprint_time;
			
			if(!self.sprint_stamina)
			{
				self.bfe_sprinthud.color = ( 1.0, 0.0, 0.0);
			}
			else	
			{
				self.bfe_sprinthud.color = ( sprint, 0, 1.0 - sprint);
			}
		
			hud_width = int((1.0 - sprint) * maxwidth);
			
			if ( hud_width < 1 )
				hud_width = 1;
			
			self.bfe_sprinthud setShader(game["sprinthud"], hud_width, 5);
		}
		
		// Disable sprinting if we carry a flag in heavy flag mode
		if(level.bfe_sprintheavyflag && isdefined(self.flagAttached))
		{
			self.sprint_stamina = 8;
			self thread Heavy_flag();
		}

		if( !isMoving(self) || isHoldingNade(self))
			break;

		    self.sprint_stamina = self.sprint_stamina - 25;

		    if (self.sprint_stamina < 0)
			  self.sprint_stamina = 0;

		    sprint_ammo = int( (self.sprint_stamina / level.sprint_time) * 100 );

		    self setWeaponSlotAmmo("primary", sprint_ammo);
	}

	//Stoped Sprinting for whatever reason, return old weapon (if Alive!)
	if ( isAlive(self) )
	{		
		nw = self getCurrentWeapon();
		nade = isHoldingNade(self);
		nw += nade;
		
		if(isdefined(nw))
		{
                	if(isDefined(self.primaryweap))
			{
				self setWeaponSlotWeapon("primary", self.primaryweap);
				self setWeaponSlotAmmo("primary", self.sprint_weap_ammo_return);
				self setWeaponSlotClipAmmo("primary", self.sprint_weap_clip_return);
			}

			if(isDefined(self.sprint_weap_return2))
			{
                		self setWeaponSlotWeapon("primaryb", self.sprint_weap_return2);
				self setWeaponSlotAmmo("primaryb", self.sprint_weap_ammo_return2);
				self setWeaponSlotClipAmmo("primaryb", self.sprint_weap_clip_return2);
			}

			if(self.sprint_weap_return != "none")
                		self switchToWeapon(self.sprint_weap_return);
		}

		self thread Sprint_Breathing();
	}

	self.is_Sprinting = false;
}

Sprint_Breathing()
{
	self endon("disconnect");
	self endon("kill_monitors");
	self endon("start_sprinting");

	very_tired = level.sprint_min_stamina * .75;
	getting_better = level.sprint_min_stamina * 2.25;
	minimum_sound = level.sprint_time * .75;
	played_sound = false;

	while (self.sprint_stamina < very_tired && isAlive(self) )
	{
		if(level.bfe_sprintheavyflag && isdefined(self.flagAttached))
		{
			self playsound("sprint_breathing");
			wait 2;
			played_sound = true;
			continue;
		}
		else
		{
			self playsound("sprint_breathing");
			wait 0.8;
		}
	}

	while (self.sprint_stamina < getting_better && isAlive(self) )
	{
		self playsound("sprint_breathing");
		wait 1.2;
		played_sound = true;
	}

	if ( played_sound && self.sprint_stamina < minimum_sound && isAlive(self) )
		self playsound("sprint_breathing");
}

Dropped_Monitor()
{
	while (1)
	{
		wait 0.1;
		deletePlacedEntity(level.sprint_weap);
	}
}

GetStance()
{
		trace = bulletTrace( self.origin, self.origin + ( 0, 0, 80 ), false, undefined );
		top = trace["position"] + ( 0, 0, -1);//find the ceiling, if it's lower than 80

		bottom = self.origin + ( 0, 0, -12 );
		forwardangle = maps\mp\_utility::vectorScale( anglesToForward( self.angles ), 12 );

		leftangle = ( -1 * forwardangle[1], forwardangle[0], 0 );//a lateral vector

		//now do traces at different sample points
		//there are 9 sample points, forming a 3x3 grid centered on player's origin
		//and oriented with the player's facing
		trace = bulletTrace( top + forwardangle,bottom + forwardangle, true, undefined );
		height1 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top - forwardangle, bottom - forwardangle, true, undefined );
		height2 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top + leftangle, bottom + leftangle, true, undefined );
		height3 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top - leftangle, bottom - leftangle, true, undefined );
		height4 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top + leftangle + forwardangle, bottom + leftangle + forwardangle, true, undefined );
		height5 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top - leftangle + forwardangle, bottom - leftangle + forwardangle, true, undefined );
		height6 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top + leftangle - forwardangle, bottom + leftangle - forwardangle, true, undefined );
		height7 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top - leftangle - forwardangle, bottom - leftangle - forwardangle, true, undefined );
		height8 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top, bottom, true, undefined );
		height9 = trace["position"][2] - self.origin[2];

		//find the maximum of the height samples
		heighta = getMax( height1, height2, height3, height4 );
		heightb = getMax( height5, height6, height7, height8 );
		maxheight = getMax( heighta, heightb, height9, 0 );



		//categorize stance based on height
		if( maxheight < 33 )
			stance="prone";
		else if( maxheight < 52 )
			stance="duck";
		else
			stance="stand";
		//self iprintln("Height: "+maxheight+" Stance: "+stance);

		return stance;
}

getMax( a, b, c, d )
{
	if( a > b )
		ab = a;
	else
		ab = b;
	if( c > d )
		cd = c;
	else
		cd = d;
	if( ab > cd )
		m = ab;
	else
		m = cd;
	return m;
}

CleanupKilled()
{
	// Remove hud elements
	if(isdefined(self.bfe_sprinthud))	self.bfe_sprinthud destroy();
	if(isdefined(self.bfe_sprinthud_minus)) self.bfe_sprinthud_minus destroy();
	if(isdefined(self.bfe_sprinthud_back))	self.bfe_sprinthud_back destroy();
	if(isdefined(self.heavymsg)) self.heavymsg destroy();
	self.is_Sprinting = false;
}

Heavy_flag()
{
	self endon("death");
	
	if(isdefined(self.heavymsg)) self.heavymsg destroy();
	
	if(level.bfe_sprintheavyflag && isdefined(self.flagAttached))
	{
		if(!isdefined(self.heavymsg))
		{
			self.heavymsg = newClientHudElem(self);
			self.heavymsg.archived = true;
			self.heavymsg.x = 320;
			self.heavymsg.y = 80;
			self.heavymsg.alignX = "center";
			self.heavymsg.alignY = "middle";
			self.heavymsg.fontScale = 1.3;
			self.heavymsg.alpha = 0;
			self.heavymsg setText(&"SPRINT_HEAVY_FLAG");
			self.heavymsg fadeOverTime(1.5);
			self.heavymsg.alpha = 1;
			wait 5;
			self.heavymsg fadeOverTime(1.5);
			self.heavymsg.alpha = 0;
			wait 1;
			self.heavymsg destroy();
		}
	}
	
}

cvardef(varname, vardefault, min, max, type)
{
	mapname = getcvar("mapname");		// "mp_dawnville", "mp_rocket", etc.

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