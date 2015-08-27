// Bots by Mitch
// DO NOT USE
// LAGGY
init()
{
	if(getCvar("zn_enable_bots") == "")
		setCvar("zn_enable_bots", "0");

	if(getCvar("zn_enable_bots") != "1" && getCvar("zn_enable_bots") != "0")
		setCvar("zn_enable_bots", "0");
	
	level.zn_enable_bots = getCvar("zn_enable_bots");

	if(level.zn_enable_bots == "0") return;

	//precacheModel("xmodel/prop_tombstone1");
	precacheModel("xmodel/zombie_hitbox_alpha");

	if(getcvar("zn_no_cmdhq") == "1")
	{
		precacheShader("white");
		level._effect["radioexplosion"] = loadfx("fx/explosions/grenadeExp_blacktop.efx");
	}

	precacheString(&"^1Disabled");
	precacheString(&"Current Wave: ^1");
	precacheString(&"Killed: ^1");
	precacheString(&"Left: ^1");

	Setup();
	thread SpawnBots();
	thread WaveSystem();
}

Setup()
{
	level.total_bots_alive = 0;
	level.total_bots_killed_wave = 0;
	level.currentwave = 1;

	file = OpenFile("config/waves.ini", "read");

	level.total_bots_wave = [];

	if(file != -1)
	{
		farg = freadln(file);
		if(farg > 0)
		{
			memory = fgetarg(file, 0);
			array = strtok(memory, ";");
			index = array[0];

			if(index == "waves")
			{
				if(array.size >= 2)
				{
					for(i=1;i<array.size;i++)
					{
						level.total_bots_wave[i] = int(array[i]);
					}
				}
			}
		}

		closefile(file);
	}

	level.total_bots_left_wave = level.total_bots_wave[1];
}

WaveSystem()
{
	level endon("intermission");

	progressBarHeight = 12;

	if(level.splitscreen)
		progressBarWidth = 192;
	else
		progressBarWidth = 232;

	level.wavebarbg = newHudElem();
	level.wavebarbg.x = 0;
	if(level.splitscreen)
		level.wavebarbg.y = -190;
	else
		level.wavebarbg.y = -224;
	level.wavebarbg.alignX = "center";
	level.wavebarbg.alignY = "middle";
	level.wavebarbg.horzAlign = "center_safearea";
	level.wavebarbg.vertAlign = "center_safearea";
	level.wavebarbg.alpha = 0.5;
	level.wavebarbg.sort = 1;
	level.wavebarbg setShader("black", progressBarWidth, progressBarHeight);

	
	level.wavebarfront = newHudElem();
	level.wavebarfront.x = ((progressBarWidth / (-2)) + 2);

	if(level.splitscreen)
		level.wavebarfront.y = -190;
	else
		level.wavebarfront.y = -224;

	level.wavebarfront.alignX = "left";
	level.wavebarfront.alignY = "middle";
	level.wavebarfront.horzAlign = "center_safearea";
	level.wavebarfront.vertAlign = "center_safearea";
	level.wavebarfront.color = (1,0,0);
	level.wavebarfront.sort = 0;

	if(level.total_bots_killed_wave > 0) 
		botsleft = int(level.total_bots_killed_wave / level.total_bots_wave[level.currentwave] * (progressBarWidth - 4));
	else 
		botsleft = int(1 / level.total_bots_wave[level.currentwave] * (progressBarWidth - 4));	

	level.wavebarfront setShader("white", botsleft, progressBarHeight - 4);

	level.wavebartext = newHudElem();
	level.wavebartext.x = ((progressBarWidth / (-2)) + 2) + 25;

	if(level.splitscreen)
		level.wavebartext.y = -175;
	else
		level.wavebartext.y = -209;
	level.wavebartext.alignX = "left";
	level.wavebartext.alignY = "middle";
	level.wavebartext.horzAlign = "center_safearea";
	level.wavebartext.vertAlign = "center_safearea";
	level.wavebartext.sort = 0;
	level.wavebartext.label = (&"Current Wave: ^1");
	level.wavebartext setValue(level.currentwave);

	level.wavebartext2 = newHudElem();
	level.wavebartext2.x = ((progressBarWidth / (-2)) + 2) + 105;

	if(level.splitscreen)
		level.wavebartext2.y = -175;
	else
		level.wavebartext2.y = -209;
	level.wavebartext2.alignX = "left";
	level.wavebartext2.alignY = "middle";
	level.wavebartext2.horzAlign = "center_safearea";
	level.wavebartext2.vertAlign = "center_safearea";
	level.wavebartext2.sort = 0;
	level.wavebartext2.label = (&"Killed: ^1");
	level.wavebartext2 setValue(level.total_bots_killed_wave);

	level.wavebartext3 = newHudElem();
	level.wavebartext3.x = ((progressBarWidth / (-2)) + 2) + 155;

	if(level.splitscreen)
		level.wavebartext3.y = -175;
	else
		level.wavebartext3.y = -209;
	level.wavebartext3.alignX = "left";
	level.wavebartext3.alignY = "middle";
	level.wavebartext3.horzAlign = "center_safearea";
	level.wavebartext3.vertAlign = "center_safearea";
	level.wavebartext3.sort = 0;
	level.wavebartext3.label = (&"Left: ^1");
	level.wavebartext3 setValue(level.total_bots_left_wave);

	for(;;)
	{
		if(level.total_bots_killed_wave > 0) 
			botsleft = int(level.total_bots_killed_wave / level.total_bots_wave[level.currentwave] * (progressBarWidth - 4));
		else 
			botsleft = int(1 / level.total_bots_wave[level.currentwave] * (progressBarWidth - 4));

		level.wavebarfront setShader("white", botsleft, progressBarHeight - 4);

		level.wavebartext2 setValue(level.total_bots_killed_wave);
		level.wavebartext3 setValue(level.total_bots_left_wave);

		level waittill("killed_bot");
	}
}

SpawnBots()
{
	level endon("intermission");

	limit = 30;

	level.total_bots = [];
	level.bot_respawndelay = undefined;
	level.disabledspawn = undefined;

	level waittill("player_spawned");

	wait(5);

	thread DisableSpawnDelay();

	for(;;)
	{
		if(!isDefined(level.bot_respawndelay))
		{
			if(level.total_bots_alive < limit && level.total_bots_left_wave > level.total_bots_alive)
			{
				thread add_bot();
				wait(0.05);
			}
			else
			{
				level waittill("killed_bot");
				wait(0.05);
			}
		}
		else
		{
			level waittill("start_newzomwave");
		}
	}
}

DisableSpawnDelay()
{
	level.disabledspawn = undefined;
	wait(30);
	level.disabledspawn = true;
}

add_bot()
{
	level.total_bots_alive++;

	who = undefined;
	num = undefined;

	spawnpointname = "mp_tdm_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	zombie = spawn("script_model", spawnpoint.origin);
	//zombie setModel( "xmodel/prop_tombstone1" );
	zombie setModel( "xmodel/zombie_pluxy_infected" );
	zombie attach("xmodel/zombie_hitbox_alpha", "tag_origin");
	zombie.angles = spawnpoint.angles;
	zombie.health = 500;
	zombie.name = "zombie";
	zombie.bugged = false;
	zombie.pers["team"] = "axis";
	zombie.debug = false;
	zombie setCanDamage(1);
	zombie setContents(1);
	zombie thread hurtHunters();
	zombie thread MoveZombie();
	zombie thread CheckForFallingZom();
	zombie thread CheckHuntersInRange();

	for(i=0;i<level.total_bots_alive;i++)
	{
		if(!isDefined(level.total_bots[i]))
		{
			level.total_bots[i] = zombie;
			num = i;
			break;
		}
	}


	while( zombie.health > 0 )
	{
		// wait for damage...
		zombie waittill("dmg", dmg, who, weap, point, mod);
		zombie.health -= dmg;

		if(getcvar("zn_debug_bots") == "1") who iprintln("dmg:" + dmg + "; who:" + who.name + "; mod:" + mod);
		who thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback();
	}

	zombie notify("kill_damagemonitor");
	playFX(level._effect["radioexplosion"], zombie.origin);
	zombie notify("killed_player");
	zombie delete();

	who thread maps\mp\gametypes\_quickactions::Killstreak();

	who.score = who.score + GetCvarInt("scr_zom_alliesPointsForKilling");
	who iprintln("You killed a zombie!");
	level.total_bots_alive--;
	level.total_bots[num] = undefined;
	level.total_bots_killed_wave++;
	level.total_bots_left_wave--;
	who maps\mp\gametypes\zom_svr::checkScoreLimit();
	who.power += GetCvarInt("scr_zom_alliesPowerForKilling");
	who notify("update_powerhud_value");
	who.arf_score_needed--;
	who.arf_score_made++;
	who thread maps\mp\gametypes\_ranksystem::update_needed_score_rank();
	wait(0.05);
	level notify("killed_bot");

	if(level.total_bots_left_wave <= 0)
	{
		iprintlnbold("Wave ^1" + level.currentwave + "^7 has been defeated");

		if(level.total_bots_wave.size >= ( level.currentwave + 1 ))
		{
			level.bot_respawndelay = true;
			level.currentwave++;
			level.total_bots_killed_wave = 0;
			level.total_bots_left_wave = level.total_bots_wave[level.currentwave];
			level.wavebartext setValue(level.currentwave);
			level.wavebartext2 setValue(level.total_bots_killed_wave);
			level.wavebartext3 setValue(level.total_bots_left_wave);
			RespawnDeadPlayers();
			wait(15);
			level.bot_respawndelay = undefined;
			level notify("start_newzomwave");
			thread DisableSpawnDelay();
		}
		else
		{
			wait(2);
			iprintlnbold("The zombies have been defeated!");
			if(level.mapended)
				return;
			level.mapended = true;

			wait(2);

			level thread maps\mp\gametypes\zom_svr::endMap();

		}
	}	
}

RespawnDeadPlayers()
{
	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++)
	{
		if(players[i].sessionstate == "dead")
		{
			players[i] notify("joined_team");
			players[i] notify("end_respawn");

			players[i] thread maps\mp\gametypes\zom_svr::respawn();
		}
		else if(players[i].sessionstate == "playing")
		{
			players[i] iprintlnbold("^1You earned one ammo pack!!!");
                      	players[i] GiveStartAmmo( players[i] getweaponslotweapon("primary") );
		}
	}
}

CheckHuntersInRange()
{
	self endon("kill_damagemonitor");
	self endon("zombiefallingdown");

	player = undefined;
	self.followhunter = undefined;

	if(getcvar("zn_debug_bots_follow") == "1") iprintln("start checkhuntersinrange thread");

	while(1)
	{
		closest = GetClosestHunter();

		if(isDefined(closest) && isPlayer(closest) && closest.pers["team"] == "allies" && distance(closest.origin, self.origin) < 800)
		{
			//trace = bulletTrace( self.origin, closest.origin, true, self );
			trace = bulletTrace(self.origin + (0,0,50), closest getEye() + (0,0,20), true, self);

			if(isDefined(self.followhunter) && isPlayer(self.followhunter) && isAlive(self.followhunter))
				player = self.followhunter;
			else			
				player = trace["entity"];
		
			if(isDefined(player) && isPlayer(player))
			{
				count = 0;
				self.followhunter = player;
	
				while(isAlive(player) && distance(player.origin, self.origin) < 800 && isDefined(self.followhunter))
				{
					self notify("hunterinrange");

					needwait = true;
			
					angles = VectorToAngles( player.origin - self.origin );				

					forward = maps\mp\_utility::vectorScale( anglesToForward(angles), 10 );
	
					//trace = bulletTrace( self.origin, self.origin + forward + (0,0,30), false, self );
					trace = bulletTrace(self.origin, self.origin + forward + (0,0,40), false, self);
					trace = bulletTrace( trace["position"], trace["position"] - (0,0,50), false, self );

					distance = distance(trace["position"], self.origin);

					angles = VectorToAngles( trace["position"] - self.origin );
					
					if(self.angles != (0,angles[1],0))
					{
						self rotateTo((0,angles[1],0), 0.1);
						self waittill("rotatedone");

						needwait = undefined;

						if(getcvar("zn_debug_bots_follow") == "1") iprintln("follow hunter rotate");
					}
					
					if(distance > 0)
					{
						self MoveTo(trace["position"], 0.05);
						self waittill("movedone");

						needwait = undefined;

						count = 0;
	
						if(getcvar("zn_debug_bots_follow") == "1") iprintln("follow hunter move");
					}
					else
					{
						count++;
					}

					if(count > 5)
					{
						if(player.origin[2] > self.origin[2])
						{
							self notify("climbhunterinrange");

							while(count > 5)
							{
								trace = bulletTrace(self.origin, self.origin + (0,0,10), false, self);
								
								if(self.origin != trace["position"])
								{
									self MoveTo(trace["position"], 0.05);
									self waittill("movedone");

									needwait = undefined;
								}
		
								angles = VectorToAngles( (player.origin[0], player.origin[1], self.origin[2]) - self.origin );	
								forward = maps\mp\_utility::vectorScale( anglesToForward(angles), 10 );

								trace = bulletTrace(self.origin, self.origin + forward, false, self);
								trace = bulletTrace(trace["position"], trace["position"], false, self);

								distance = distance(trace["position"], self.origin);

								if(distance > 0)
								{
									self MoveTo(trace["position"], 0.05);
									self waittill("movedone");
									count = 0;
									needwait = undefined;
								}

								trace = bulletTrace(self.origin, self.origin + (0,0,1000), false, self);

								if(distance(trace["position"], self.origin) < 30)
									count = 0;

								if(player.origin[2] < self.origin[2])
									count = 0;
							}

							self thread CheckForFallingZom();
						}
						else
						{
							self.followhunter = undefined;
						}
					}

					if(isDefined(needwait))
						wait(0.05);

					if(getcvar("zn_debug_bots_follow") == "1") iprintln("following hunter");

					if(self.bugged == true)
					{
						//spawnpointname = "mp_tdm_spawn";
						//spawnpoints = getentarray(spawnpointname, "classname");
						spawnpoints = level.spawnpoints;
						spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

						self.origin = spawnpoint.origin;
					}
				}
				
				if(getcvar("zn_debug_bots_follow") == "1") iprintln("stopped following hunter");

				self.goforward = undefined;
				self.followhunter = undefined;
				self thread MoveZombie();
			}
		}

		self.debug = false;

		wait(1);
	}
}

GetClosestHunter()
{
	closest = undefined;
	
	players = getentarray("player","classname");
	for(i=0;i<players.size;i++)
	{
		p = players[i];

		if(!isDefined(closest) && p.pers["team"] == "allies")
			closest = p;
		else if(isDefined(closest) && Closer(self.origin,p.origin,closest.origin) && p.pers["team"] == "allies")
			closest = p;
	}
	
	return closest;
}

CheckForFallingZom()
{
	self endon("kill_damagemonitor");
	self endon("climbhunterinrange");

	while(1)
	{
		endOrigin = self.origin - (0,0,100000);
		trace = bulletTrace( self.origin, endOrigin, false, self );

		distance = distance(self.origin, trace["position"]);
		
		if(distance > 0 && self.origin != trace["position"])
		{
			self notify("zombiefallingdown");

			time = distance / 400;

			if(time <= 0)
				time = 0.1;

			if(self.origin != trace["position"])
			{
				self MoveTo(trace["position"], time);
				self waittill("movedone");
			}
			else
				wait(0.05);

			//if(!isDefined(self.followhunter)) 
			self thread MoveZombie();
			self thread CheckHuntersInRange();

			if(getcvar("zn_debug_bots_follow") == "1") iprintln("falling zom");
		}
		
		wait(0.25);
	}
}

MoveZombie()
{
	self endon("kill_damagemonitor");
	self endon("zombiefallingdown");
	self endon("hunterinrange");

	wait(0.05);

	noforward = false;
	count = 0;

	while(1)
	{
		forward = self GetForwardDir(false, noforward);	

		nowall = true;			

		while(isDefined(nowall))
		{		
			endOrigin = self.origin + forward;
		
			trace = bulletTrace(self.origin, endOrigin + (0,0,40), false, self);
			trace = bulletTrace(trace["position"], trace["position"] - (0,0,40), false, self);

			distance = distance(self.origin, trace["position"]);

			if(distance > 0)
			{
				self MoveTo(trace["position"], 0.05);
				self waittill("movedone");

				forward2 = maps\mp\_utility::vectorScale( anglesToForward(self.angles), 100 );
				endOrigin2 = self.origin + forward2;
				trace = bulletTrace(self.origin, endOrigin2 + (0,0,40), false, self);
				trace = bulletTrace( trace["position"], trace["position"] - (0,0,40), false, self);

				count = 0;

				if(distance(trace["position"], self.origin) < 20)
					nowall = undefined;
			}
			else
			{
				nowall = undefined;
				count++;
				wait(0.05);
			}

			if(getcvar("zn_debug_bots_simple") == "1") iprintln("nowall while");

			if(RandomInt(100) > 96)
			{
				forward = self GetForwardDir(true, true);
			}	
		}

		self.goforward = undefined;
		noforward = true;

		wait(0.05);

		if(count > 5)
		{
			spawnpointname = "mp_tdm_spawn";
			spawnpoints = getentarray(spawnpointname, "classname");
			spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

			self.origin = spawnpoint.origin;
		}
	}
}

GetForwardDir(noforward, atend)
{
	if(!isDefined(self.option)) 
		returnme = false;
	else 
		returnme = undefined;

	// 0 = backwards, 1 = right, 2 = left, 3 = forward
	if(noforward == false && atend == false) 
		option = RandomInt(4);
	else 
		option = RandomInt(3);

	if(!isDefined(returnme) && isDefined(self.option) && self.option == option)
	{
		forward = maps\mp\_utility::vectorScale( anglesToForward(self.angles), 10 );

		return forward;
	}

	self.option = option;

	if(option == 3)
		forward = anglesToForward(self.angles);
	else if(option == 0)
		forward = maps\mp\_utility::vectorScale( anglesToForward(self.angles), -1 );
	else if(option == 1)
		forward = anglesToRight(self.angles);
	else
		forward = maps\mp\_utility::vectorScale( anglesToRight(self.angles), -1 );

	if(getcvar("zn_debug_bots") == "1")
	{
		if(option == 3)
			iprintln("forward");
		else if(option == 0)
			iprintln("backwards");
		else if(option == 1)
			iprintln("right");
		else
			iprintln("left");
	}
	
	if(isDefined(self.goforward) && noforward == false)
		forward = anglesToForward(self.angles);

	forward = maps\mp\_utility::vectorScale( forward, 10 );

	endOrigin = self.origin + forward;
		
	trace = bulletTrace( self.origin, endOrigin, false, self);
	distance = distance(self.origin, trace["position"]);

	forward2 = maps\mp\_utility::vectorScale( forward, 1000 );
	endOrigin2 = self.origin + forward2;
	trace2 = bulletTrace( self.origin, endOrigin2 + (0,0,20), false, self);
	trace2 = bulletTrace( trace2["position"], trace2["position"] - (0,0,20), false, self);

	distance2 = distance(self.origin, trace2["position"]);

	if(distance2 < 350 && noforward == true)
	{
		forward = maps\mp\_utility::vectorScale( anglesToForward(self.angles), 10 );

		return forward;
	}

	if(distance > 0)
	{
		angles = VectorToAngles( trace["position"] - self.origin );
		
		if(getcvar("zn_debug_bots") == "1") iprintln("angles: " + self.angles);
		if(getcvar("zn_debug_bots") == "1") iprintln("new: " + (self.angles[0],angles[1],self.angles[2]));
	
		if(self.angles != (self.angles[0],angles[1],self.angles[2]))
		{
			self rotateTo((self.angles[0],angles[1],self.angles[2]),0.3);
			self waittill("rotatedone");
			if(getcvar("zn_debug_bots") == "1") iprintln("rotate dir");
		}

		self.goforward = true;

		forward = anglesToForward(self.angles);
		forward = maps\mp\_utility::vectorScale( forward, 10 );
	}

	return forward;
}

setCanDamage( flag )
{
	if(!flag)
	{
		self notify("kill_damagemonitor");
		return;
	}
	else
		self thread setCanDamage2();
}


setCanDamage2()
{
	self endon("kill_damagemonitor");

	trace = undefined;
	bashradius = 45;

	while(1)
	{
		players = getentarray( "player", "classname" );
		for( i = 0; i < players.size; i++ )
		{
			p = players[i];

			if( !isDefined( p.bash_delay ) )
				p.bash_delay = false;


			if( !isDefined( p.shoot_delay ) )
				p.shoot_delay = false;

			starts = [];
			starts[0] = p.origin + (0,0,66); // stand
			starts[1] = p getEye(); // sit
			starts[2] = p getEye() - (0,0,30); // lay

			forward = maps\mp\_utility::vectorScale( anglesToForward(p getPlayerAngles()), 10000 );
			//startOrigin = starts[0]; // + (0,0,20);
			//fwd2gun = maps\mp\_utility::vectorScale( anglesToForward(p getPlayerAngles()), 20 );
			//startOrigin = p getOrigin() + (0,0,30) + fwd2gun;
			//endOrigin = starts[0] + forward;

			tracedone = undefined;

			for(i=0;i<starts.size;i++)
			{
				startOrigin = starts[i];
				endOrigin = startOrigin + forward;
				trace = bulletTrace( startOrigin, endOrigin, true, p );

				if( isDefined( trace["entity"] ) && trace["entity"] == self )
				{
					tracedone = trace;
					break;
				}
			}

			if( isDefined(tracedone) && isDefined( tracedone["entity"] ) && tracedone["entity"] == self )
			{
				if( p attackButtonPressed() && !p shoot_delay("get") && p getWeaponSlotClipAmmo(p getCurrentSlot()) > 0)
				{
					p thread shoot_delay("set", 0.6);
					weap = p getCurrentWeapon();
					dmg = getDamage( weap );
					who = p;
					point = tracedone["position"];
					mod = damageMod( weap );

					self notify("dmg", dmg, who, weap, point, mod);
				}
				if ( p meleeButtonPressed() && !p.bash_delay && distance( p.origin, self.origin ) < bashradius )
				{
					p thread bash_delay( 0.6 );
					weap = p getCurrentWeapon();
					dmg = int(getDamage( weap ) * 1.25);
					who = p;
					point = tracedone["position"];
					mod = "MOD_MELEE";

					self notify("dmg", dmg, who, weap, point, mod);
				}

			}

		}

		wait (0.05);
	}
}

getCurrentSlot()
{
	weapon1 = self getweaponslotweapon("primary");
	current = self getCurrentWeapon();

	if(weapon1 == current)
		return "primary";
	else
		return "primaryb";
}

hurtHunters()
{
	self endon("kill_damagemonitor");
	hurtradius = 24;

	while(1)
	{

		players = getentarray( "player", "classname" );
		for( i = 0; i < players.size; i++ )
		{
			p = players[i];

			if(isDefined(self))
			{
				origin = (p.origin[0], p.origin[1], self.origin[2]);
				height = self.origin[2];

				if ( distance( origin, self.origin ) < hurtradius && p.origin[2] >= height && p.origin[2] <= (height + 30) )
				{
					direction = anglesToForward( self.angles );
					p thread [[level.callbackPlayerDamage]](self, self, 20, 1, "MOD_GRENADE_SPLASH", "zombie_mp", p.origin,direction, "none",0);	
				}
			}
		}
		
		wait(0.05);
	}
}

bash_delay( time )
{
	self endon("disconnect");
	self.bash_delay = true;
	wait time;
	self.bash_delay = false;
}

shoot_delay( action, delay )
{
	self endon("disconnect");

	if(action == "set")
	{
		self.shoot_delayinfo = [];
		self.shoot_delayinfo["gun"] = self getCurrentWeapon();
		self.shoot_delayinfo["ammo"] = self getWeaponSlotClipAmmo(self getCurrentSlot());
		self.shoot_delay = true;
		wait(delay);
		self.shoot_delay = false;
	}
	else if(action == "get")
	{
		if(!isDefined(self.shoot_delayinfo) || !isDefined(self.shoot_delay))
		{
			return false;
		}

		if(self getWeaponSlotClipAmmo(self getCurrentSlot()) == self.shoot_delayinfo["ammo"] && self.shoot_delay == true && self.shoot_delayinfo["gun"] == self getCurrentWeapon())
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}

getDamage(weapon)
{
	switch(weapon)
	{
	case "springfield_mp":
		return 50;
	case "enfield_scope_mp":
		return 50;
	case "mosin_nagant_sniper_mp":
		return 50;
	case "kar98k_sniper_mp":
		return 50;
	case "mosin_nagant_mp":
		return 50;
	case "kar98k_mp":
		return 50;
	case "m1carbine_mp":
		return 38;
	case "m1garand_mp":
		return 38;
	case "enfield_mp":
		return 50;
	case "SVT40_mp":
		return 38;
	case "g43_mp":
		return 38;
	case "bar_mp":
		return 40;
	case "bren_mp":
		return 40;
	case "mp44_mp":
		return 40;
	case "thompson_mp":
		return 35;
	case "sten_mp":
		return 33;
	case "greasegun_mp":
		return 34;
	case "mp40_mp":
		return 36;
	case "ppsh_mp":
		return 30;
	case "PPS42_mp":
		return 40;
	case "shotgun_mp":
		return 40;
	case "panzerschreck_mp":
		return 400;
	case "TT30_mp":
		return 20;
	case "webley_mp":
		return 20;
	case "colt_mp":
		return 20;
	case "luger_mp":
		return 20;
	case "tesla_mp":
		return 50;
	case "sig_mp":
		return 40;
	case "remington_mp":
		return 150;
	case "m14_scoped_mp":
		return 90;
	case "m14_mp":
		return 90;
	case "barret_mp":
		return 190;
	case "winchester_mp":
		return 90;
	case "rpd_mp":
		return 40;
	case "benelli_mp":
		return 30;
	case "ak74_mp":
		return 40;
	case "ak47_mp":
		return 40;
	case "uzi_mp":
		return 45;
	case "glock_mp":
		return 30;
	case "katana_mp":
		return 30;
	case "crowbar_mp":
		return 30;
	case "axe_mp":
		return 30;
	case "bowie_mp":
		return 30;
	default:
		return 70;
	}
}

damageMod(weapon)
{
	switch(weapon)
	{
	case "springfield_mp":
	case "enfield_scope_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	case "mosin_nagant_mp":
	case "kar98k_mp":
	case "enfield_mp":
	case "tesla_mp":
	case "sig_mp":
	case "remington_mp":
	case "m14_scoped_mp":
	case "m14_mp":
	case "barret_mp":
		return "MOD_RIFLE_BULLET";

	case "m1carbine_mp":
	case "m1garand_mp":
	case "SVT40_mp":
	case "g43_mp":
	case "bar_mp":
	case "bren_mp":
	case "mp44_mp":
	case "thompson_mp":
	case "sten_mp":
	case "greasegun_mp":
	case "mp40_mp":
	case "ppsh_mp":
	case "PPS42_mp":
	case "shotgun_mp":
	case "winchester_mp":
	case "rpd_mp":
	case "benelli_mp":
	case "ak74_mp":
	case "ak47_mp":
	case "uzi_mp":
		return "MOD_RIFLE_BULLET";

	case "TT30_mp":
	case "webley_mp":
	case "colt_mp":
	case "luger_mp":
	case "glock_mp":
	case "katana_mp":
	case "crowbar_mp":
	case "axe_mp":
	case "bowie_mp":
		return "MOD_PISTOL_BULLET";

	case "panzerschreck_mp":
	case "panzerfaust_mp":
		return"MOD_PROJECTILE";

	default:
		return "MOD_UNKNOWN";
	}
}