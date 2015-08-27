/*
        Basic Script
        In this script i basically put all the stupid and short stuff  together
*/
Precache()//Here we precache the huds
{
precacheModel("xmodel/sas_pluxy_hunter");
precacheModel("xmodel/zombie_pluxy_infected");
precacheShader("counter_status"); 
precacheShader("znationlogo");
precacheShader("white");
precacheString(&"^1Rank: ^7");
//game["zn_credits"] = &"^2Z^9ombie ^2N^9ation ^2M^9od ^2B^9eta by:plu^2X^9y,^2M^9itch and ^2L^9ilpimp.";
//game["zn_xfire"] = &"^2X^9fires:(plu^2X^9y - punishman1993) (^2M^9itch - mitchhubers)";
//game["zn_web"] = &"^2V^9isit our ^2W^9eb ^2f^9or ^2m^9ore ^2I^9nfo: www.zomnation.webs.com";
game["zn_credits"] = &"^2Z^9ombie ^2N^9ation ^2M^9od ^2B^9eta by:plu^2X^9y,^2M^9itch,^2L^9ilpimp and ^2A^9rthas.";
game["zn_xfire"] = &"^2X^9fires:(plu^2X^9y - punishman1993) (^2M^9itch - mitchhubers) (^2A^9rthas - optopus1)";
game["zn_web"] = &"^2V^9isit our ^2W^9eb ^2f^9or ^2m^9ore ^2I^9nfo: www.zomnation.co.cc";
precacheString(game["zn_credits"]);
precacheString(game["zn_xfire"]);
precacheString(game["zn_web"]);
//PrecacheString(&"ZNATION_CREDITS"); // old
//PrecacheString(&"ZNATION_XFIRE"); // old
//PrecacheString(&"ZNATION_WEB"); // old
//PrecacheString(&"^2Health: ^7"); // not used
PrecacheString(&"Protected");
PrecacheString(&"^3OVERHEATED!");
PrecacheString(&"^7Temperature");
level.overheatfx = loadfx ("fx/smoke/thin_black_smoke_S.efx");
game["rankstatusicon"] = "gfx/hud/hud@weaponmode_full.tga"; 
precacheShader(game["rankstatusicon"]);
precacheShader("gfx/impact/flesh_hit2");
precacheShader("gfx/impact/flesh_hitgib");
level.maxmines = 1;
}

init()
{
	thread Precache();
     	thread credits();
        thread PlayersleftHud();
        thread CounterStatus();
	thread ZNationLogo();
	thread AlliesLogo();
	thread AxisLogo();
	thread Hmedpack();
	thread Hpower();
	thread Hmine();
        if(getCvar("zn_block_fog") != "1") thread AmbientalFog();
	thread RandomMsg();
	if(getCvar("zn_enable_bots") == "0") thread CheckIfZombieTeamIsEmpty();
	//if(getCvar("zn_noreadloadpass") != "1") thread ReadLoadPass();
	thread TurretMonitor();
	thread updateHostName();
	level.show_healthbar = true;
}

OnSpawnPlayer()
{
	self thread MoveSpawn();
	self thread Unknown();

	self.assists = [];

	if(self.pers["team"] == "allies")
	{
		self thread SpawnProtection();
		self thread maps\mp\gametypes\_quickactions::MinePlanted();
		self thread WeaponAmmoChecker();
		self thread CampMonitorTwo();
	}

	if(getcvar("scr_zn_campmonitor") == "1") 
		self thread CampMonitor();

	self thread RankStatusBar();

	//if(debugModeOn(self))
	//	self iprintln("Basic - Spawn Player thread");

	if(isDefined(self.zomvision) && self.zomvision == true)
	{
		self.zomvision = false;
		if(self.pers["team"] == "axis") self thread maps\mp\gametypes\_quickactions::ZomVision();
	}

	if(isDefined(self.loadteamcfg))
		self thread loadTeamCfg();

	self setClientCvar("cg_crosshairenemycolor", "1");
	self setClientCvar("cg_drawcrosshair", "1");
	self setclientcvar("r_lightmap", 0);

	self thread maps\mp\gametypes\_plusscore::onSpawn();
	self thread Healthbar();

	if(isDefined(self.thirdperson) && self.thirdperson)
	{
		self.thirdperson = false;
		self thread DelayThird();
	}

	if(isDefined(self.firstloginmsg) && self.firstloginmsg)
		self thread maps\mp\gametypes\_ranksystem::loginSpawnMessage();		
}

DelayThird()
{
	wait(0.05);

	if(isDefined(self.thirdperson) && !self.thirdperson)
		self thread maps\mp\gametypes\_quickactions::Thirdperson();
}

//First of all i put here the removehuds...was pissing me off..
RemoveHuds( keeprankhud, override )
{
	if(self.sessionstate == "playing" && !isDefined(override)) return;

	self notify("DestroyAllCHuds");

	//if(debugModeOn(self))
	//	self iprintln("Basic - Remove Huds");

	if(isDefined(self.healthletter)) self.healthletter destroy();
	//if(isDefined(self.rankhud)) self.rankhud destroy();
	if(isDefined(keeprankhud) && keeprankhud == false && isDefined(self.hud6)) self.hud6 destroy();

	if(isDefined(self.minehud)) self.minehud destroy();
	if(isDefined(self.powerhud)) self.powerhud destroy();
	if(isDefined(self.medpackhud)) self.medpackhud destroy();

	//if(isDefined(self.healthnum)) self.healthnum destroy();
	//if(isDefined(self.hmine)) self.hmine destroy();
	//if(isDefined(self.hmedpack)) self.hmedpack destroy();
	//if(isDefined(self.hpower)) self.hpower destroy();

	if(isDefined(self.findspawntext)) self.findspawntext Destroy();
	if(isDefined(self.findspawntextinfo)) self.findspawntextinfo Destroy();
	if(isDefined(self.bubbletimer)) self.bubbletimer Destroy();

	if(isDefined(self.bloodyscreenon))
	{
		for(i=0;i<self.bloodyscreen.size;i++)
			if(isDefined(self.bloodyscreen[i])) self.bloodyscreen[i] destroy();

		self.bloodyscreenon = undefined;
	}

	self.mightbeblocking = undefined;
	self.iscamping = undefined;

	if(isDefined(self.rankstatusbarbg)) self.rankstatusbarbg destroy();
	if(isDefined(self.rankstatusbarfront)) self.rankstatusbarfront destroy();
	if(isDefined(self.rankstatusbaricon)) self.rankstatusbaricon destroy();
	if(isDefined(self.whiteblinded)) self.whiteblinded destroy();
	if(isdefined(self.nboz)) self.nboz destroy();
	if(isdefined(self.ngreen)) self.ngreen destroy();
	if(isdefined(self.minesplanted)) self.minesplanted destroy();
	if(isdefined(self.zvision)) self.zvision destroy();
	if(isdefined(self.nviz)) self.nviz destroy();
        if(isdefined(self.nvision)) self.nvision destroy();	
	if(isdefined(self.thud)) self.thud destroy();
	if(isDefined(self.health_back)) self.health_back destroy();
	if(isDefined(self.health_bar)) self.health_bar destroy();
	if(isDefined(self.health_redbar)) self.health_redbar destroy();
	if(isDefined(self.health_cross)) self.health_cross destroy();

	self setclientcvar("cg_thirdperson", 0);
	self setClientCvar("r_fullbright", "0");
	self setclientcvar("r_lightmap", 0);
	self setclientcvar("r_fog", 1);
	self RemoveOverheatHud();
}

updateHostName()
{
	level endon("intermission");
	level endon("cleanUP_endmap");
	
	wait(1);

	for(;;)
	{	
		timepassed = (getTime() - level.starttime) / 1000;
		timepassed = timepassed / 60.0;
		timeleft = int(level.timelimit - timepassed);

		if(timeleft > 1)
			setCvar("sv_hostname", getCvar("zn_hostname") + " ^4[^1" + timeleft + "^7 min left^4]");
		else
			setCvar("sv_hostname", getCvar("zn_hostname") + " ^4[^1" + timeleft + "^7 mins left^4]");		

		if(isDefined(level.mapended) && level.mapended)
			break;

		wait(90);
	}

	setCvar("sv_hostname", getCvar("zn_hostname") + " ^4[^7End map^4]");
}

TurretMonitor()
{
	wait(0.05); // remove unwanted turrets

	entities = getentarray("misc_turret", "classname");
	for(i=0;i<entities.size;i++)
		entities[i] thread TurretThink(i);
}

TurretThink(num)
{
	level endon("intermission");
	level endon("cleanUP_endmap");

	if(getCvar("scr_turret_overheat") == "")
		setCvar("scr_turret_overheat", "1");

	if(getCvar("scr_turret_overheatlevel") == "")
		setCvar("scr_turret_overheatlevel", "10");

	if(getCvar("scr_turret_cooldownlevel") == "")
		setCvar("scr_turret_cooldownlevel", "5");

	turretoverheat = getCvarInt("scr_turret_overheat"); // 1
	level.turretoverheatlevel = getCvarInt("scr_turret_overheatlevel"); // 10
	level.turretcooldownlevel = getCvarInt("scr_turret_cooldownlevel"); // 5

	dist = 0;
	cooldown = 0;
	oddeven = 0;
	self.turret = [];
	self.turret["heat"] = 0;

	tag_butt = spawn ("script_origin", (0,0,0));
	tag_butt linkto (self, "tag_butt", (0,0,0), (0,0,0));
	
	for (;;)
	{
		tag_butt_origin_notused = tag_butt.origin;
		wait 0.1;
		if (tag_butt.origin == tag_butt_origin_notused)
			break;
	}

	for(;;)
	{
		wait .2;

		globalused = false;
		fired = false;

		// Every other run flag
		if(oddeven)
			oddeven = 0;
		else
			oddeven = 1;

		player = undefined;

		if (tag_butt.origin != tag_butt_origin_notused)
		{
			if (isdefined (self.player_origin_using))
			{
				// Do some black magic to find the player...
				
				pivot_point = (self.origin[0], self.origin[1], tag_butt.origin[2]);
				dist = distance (tag_butt.origin, pivot_point);
				a = self.angle_pods;
				if (a >= 180)
					a -= 360;
				a = a * (-1.1);
				sina = sin (a);
				cosa = cos (a);
				k = 1 + 0.1 * (tag_butt.origin[2] - self.origin[2]) / dist;
				x = tag_butt.origin[0] - self.origin[0];
				y = tag_butt.origin[1] - self.origin[1];
				x1 = x * cosa - y * sina;
				y1 = x * sina + y * cosa;
				target_pos = pivot_point + (x1 * k,  y1 * k, 20);
			}
			else
				target_pos = tag_butt.origin + (0, 0, 20);

			trace = bullettrace (target_pos, target_pos + (0, 0, -200), true, self);
			ent = trace["entity"];
			if (isPlayer (ent))
				player = ent;
		}

		if (isdefined (player))
		{
			globalused = true;
			self.turret_playerusing = player;
			self.turret_playernum = num;
			player.turret_playernum = num;
			player.turret_playerusing = true;
				
			// Is it being fired?
			if(turretoverheat)
			{
				if(player attackButtonPressed())
				{
					fired = true;
					oddeven = 1;
					// Is it overheated?
					self.turret["heat"]++;
					if(self.turret["heat"] > level.turretoverheatlevel*5)
					{
						//if(debugModeOn(self))
						//{
						//	player iprintln("Current wep: " + player getCurrentWeapon());
						//	if(isDefined(player.weaponinfo)) player iprintln("Wep info: " + player.weaponinfo);
						//}

						cooldown = level.turretcooldownlevel*5;
						//player iprintlnbold ("^1TURRET OVERHEATED!");
						player iprintlnbold(&"ZMESSAGES_TURRETHEAT");
						sMeansOfDeath = "MOD_EXPLOSIVE";
						iDFlags = 1;
						iDamage = self.turret["heat"] - level.turretoverheatlevel*5;
						sWeapon = self.weaponinfo;
						vDir=(0,0,0);
						player thread [[level.callbackPlayerDamage]](self, self, iDamage, iDFlags, sMeansOfDeath, sWeapon, undefined, vDir, "none", 0);
					}
				}
				else
				{
					if(cooldown)
					{
						cooldown--;
					}
					else
					{
						if(oddeven && self.turret["heat"]) self.turret["heat"]--;
					}
				}
				// Show heathbar
				player UpdateOverheatHud(self, fired, oddeven);
			}
		}
		else
		{
			// Clear player flag if this turret has been used previously
			if (isdefined (self.turret_playerusing))
			{
				player = self.turret_playerusing;

				player.turret_playerusing = undefined;
				
				if(self.turret_playernum == num && player.turret_playernum == num)
					player RemoveOverheatHud();
			}
		}
	
		// Cool down even if noone is using it.
		if(!globalused && !fired)
		{
			if(cooldown)
			{
				if(randomint(2))
					playfx(level.overheatfx,self.origin + (0,0,10));
				cooldown--;
			}
			else
			{
				if(oddeven && self.turret["heat"]) self.turret["heat"]--;
			}
		}
	}
}

RemoveOverheatHud()
{
	if(isdefined(self.overheatbarbackground))	
		self.overheatbarbackground destroy();
	if(isdefined(self.overheatbar))	
		self.overheatbar destroy();
	if(isdefined(self.overheatmessage))
		self.overheatmessage destroy();
}


UpdateOverheatHud(turret, fired, oddeven)
{
	if(!oddeven) return;

	if(fired)
		time = 0.2;
	else
		time = 0.4;

	barsize = 200;
	y = 452;
	heat = turret.turret["heat"];
	if(heat>level.turretoverheatlevel*5)
	{
		heat = level.turretoverheatlevel*5;
		message = (&"^3OVERHEATED!"); 
	}
	else
		message = (&"^7Temperature"); 

	size = int(heat * barsize / (level.turretoverheatlevel * 5) + 0.5);
	
	c = size / barsize;

	if(!size) size = 1;

	color = (1,1-c,1-c);
	if(!isdefined(self.overheatbarbackground))
	{
		// Background
		self.overheatbarbackground = newClientHudElem(self);				
		self.overheatbarbackground.alignX = "center";
		self.overheatbarbackground.alignY = "top";
		self.overheatbarbackground.x = 320;
		self.overheatbarbackground.y = y;
		self.overheatbarbackground setShader("gfx/hud/hud@health_back.tga", (barsize + 4), 11);			
	}
	if(!isdefined(self.overheatbar))
	{
		// Progress bar
		self.overheatbar = newClientHudElem(self);				
		self.overheatbar.alignX = "left";
		self.overheatbar.alignY = "top";
		self.overheatbar.x = (320 - (barsize / 2.0));
		self.overheatbar.y = y+1;
		self.overheatbar.color = color;
		self.overheatbar setShader("gfx/hud/hud@health_bar.tga", size, 9);
	}
	else
	{
		self.overheatbar.color = color;
		self.overheatbar scaleOverTime(time , size, 9);
	}

	if(!isdefined(self.overheatmessage))
	{
		self.overheatmessage = newClientHudElem( self );
		self.overheatmessage.alignX = "center";
		self.overheatmessage.alignY = "top";
		self.overheatmessage.x = 320;
		self.overheatmessage.y = y+1;
		self.overheatmessage.alpha = 1;
		self.overheatmessage.fontScale = 0.80;
	}

	self.overheatmessage setText( message );
}

CounterStatus()//The counter with nums etc..
{
	level.counter = newHudElem();
	level.counter.x = 93; 
	level.counter.y = 80; 
	level.counter.alignX = "center";
	level.counter.alignY = "bottom";
	level.counter.alpha = 1;
	level.counter.sort = 0;
	level.counter setShader("counter_status", 160, 75);
}

ZNationLogo()//The logo
{
	level endon("intermission");

	level.counter2 = newHudElem();
	level.counter2.x = 590;
	level.counter2.y = 100; 
	level.counter2.alignX = "center";
	level.counter2.alignY = "bottom";
	level.counter2.alpha = 1;
	level.counter2.sort = -10;
	level.counter2 setShader("znationlogo", 85, 85);
	/*angle = 1;

	for(;;)
	{
		level.counter2 SetClock( angle , 180, "znationlogo2", 85, 85 ); 
		
		wait(0.05);

		angle++;
		if(angle > 180)
			angle = 1;
	}*/
}

Credits()//Credits:Don't touch this...
{
	level endon("intermission");
	level endon("cleanUP_endmap");

	if( isDefined( level.logoText ) )
		level.logoText destroy();

	level.logoText = newHudElem();
	level.logoText.x = 350; //200;
	level.logoText.y = 473; //473;
	level.logoText.alignX = "left"; //"center";
	level.logoText.alignY = "middle";
	level.logoText.alpha = 3;
	level.logoText.sort = 100;
	level.logoText.fontScale = 0.75;
	level.logoText.archived = true;
	level.logoText setText( &"" );

	for(;;)
	{
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
		level.logoText setText(game["zn_credits"]); // old &"ZNATION_CREDITS"
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
           	level.logoText setText(game["zn_xfire"]);// old &"ZNATION_XFIRE"
		wait 5;
		level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
           	level.logoText fadeOverTime(1);
		level.logoText.alpha = 1;
          	level.logoText setText(game["zn_web"]); // old &"ZNATION_WEB"
		wait 5;
           	level.logoText fadeOverTime(1);
		level.logoText.alpha = 0;
		wait 1;
	}
}

AxisLogo()
{
	level.ilogo = NewTeamHudElem( "axis" );
	level.ilogo.x = 40; 
	level.ilogo.y = 52; 
	level.ilogo.alignX = "center";
	level.ilogo.alignY = "bottom";
	level.ilogo.alpha = 1;
	level.ilogo.sort = 510;
	level.ilogo setShader("infected_logo", 38, 38);
}

AlliesLogo()
{
	level.slogo = NewTeamHudElem( "allies" );
	level.slogo.x = 40; 
	level.slogo.y = 52; 
	level.slogo.alignX = "center";
	level.slogo.alignY = "bottom";
	level.slogo.alpha = 1;
	level.slogo.sort = 511;
	level.slogo setShader("survivor_logo", 38, 38);
}

Hhealth()
{
	self endon("DestroyAllCHuds");
	self endon("disconnect");

	if(!isDefined(self.healthletter))
	{
		self.healthletter = newClientHudElem(self);
		self.healthletter.x = 520;
		self.healthletter.y = 413;
	}

	self.healthletter.alignX = "left";
	self.healthletter.alignY = "top";
	self.healthletter.fontScale = 0.8;
	self.healthletter.alpha = 1;
	self.healthletter.archived = true;
	self.healthletter.label = (&"^2Health: ^7");
	//self.healthletter setvalue(self.health);
	if(isDefined(self.health) && isDefined(self.spawnprotected)) self.healthletter setText(&"Protected");

	while(1)
	{
		wait (0.1);
		if(isDefined(self.health) && isDefined(self.spawnprotected)) self.healthletter setText(&"Protected");
		else if(isDefined(self.health)) self.healthletter setvalue(self.health);
	}
}

Healthbar()
{
	self endon("disconnect");
	self endon("killed_player");

	self.healthwidthed = 83;
	y = -68; //-81 -70

	if(!isDefined(self.health_back))
	{
		self.health_back = newClientHudElem(self);
 		self.health_back.x = -94;
 		self.health_back.y = y;
 		self.health_back.horzAlign = "right";
 		self.health_back.vertAlign = "bottom";
 		self.health_back.alpha = 1;
 		self.health_back.sort = 1;
 		self.health_back.archived = true;
	}

	if(!isDefined(self.health_cross))
	{
 		self.health_cross = newClientHudElem(self);
 		self.health_cross.x = -109.5;
 		self.health_cross.y = y-2;
 		self.health_cross.horzAlign = "right";
 		self.health_cross.vertAlign = "bottom";
 		self.health_cross.alpha = 1;
 		self.health_cross.sort = 1;
 		self.health_cross.archived = true;
	}

	if(!isDefined(self.health_bar))
	{
		self.health_bar = newClientHudElem(self);
 		self.health_bar.x = -93;
 		self.health_bar.y = y+1;
 		self.health_bar.horzAlign = "right";
 		self.health_bar.vertAlign = "bottom";

		if(self.pers["team"] == "allies")
	 		self.health_bar.color = (0, .4, 0);//Green Color
		else
			self.health_bar.color = (.4, 0, 0);//Red Color

 		self.health_bar.alpha = 1;
 		self.health_bar.sort = 4;
 		self.health_bar.archived = true;
	}

 	self.health_back setShader(game["sprinthud_back"], 85, 7);
 	self.health_cross setShader(game["sprint_cross"], 10, 10);

 	healthbar = self.healthwidthed;
 	self.health_bar setShader(game["sprinthud"], healthbar, 5);

	self thread GlowHealthbar();
 	self thread UpdateHealthbar(y);
	self thread FlashHealthbar();
	self thread UpdateHealthLogo();
}

FlashHealthbar()
{
	self endon("disconnect");
	self endon("killed_player");
	self endon("DestroyAllCHuds");

	while(isDefined(self) && isDefined(self.spawnprotected) && self.spawnprotected)
	{
		if(isDefined(self.health_back)) 
		{	
			self.health_back.color = ( 1 , .25 , 0);
   			self.health_back fadeOverTime(0.45);
			self.health_back.color = ( 1 , 1 , 1);
			wait(0.45);
		}
		else
			break;
	}
}

UpdateHealthLogo()
{
	if(!isDefined(self.health_cross.color) || !maps\mp\gametypes\_commanders::isCommander(self))
		return;

	if(self.pers["team"] == "allies")
		self.health_cross.color = (0, 1, 0);
	else
		self.health_cross.color = (1, 0, 0);
}

UpdateHealthbar(y)
{
	self endon("disconnect");
	self endon("killed_player");
	self endon("DestroyAllCHuds");

    	while(level.show_healthbar)
    	{
 		health1 = self.health;
 		self waittill("update_healthbar");
		self thread doHealthBarUpdate(health1, y);
	}
}

doHealthBarUpdate(health1, y)
{
	self endon("disconnect");
	self endon("killed_player");
	self endon("DestroyAllCHuds");

	wait 0.05;
	health2 = self.health;
	
 	if ( health1 != health2 && isDefined(self.health_bar) )
 	{
		self notify("update_healthbar_new");
		if(isDefined(self.health_redbar)) self.health_redbar Destroy();	

		scaletime2 = (health2 - health1) / self.maxhealth * self.healthwidthed * .03;
				
		if(health1 > health2)
			scaletime2 = 0.05;
	
		health = (self.maxhealth-health2)/self.maxhealth;
		healthbar = int((1-health) * self.healthwidthed);

		if(healthbar > self.healthwidthed)
			healthbar = self.healthwidthed;

   		self.health_bar.alpha = 1;
		ratio = (health2/self.maxhealth);

		self.health_bar fadeOverTime(scaletime2);

		if(self.pers["team"] == "allies")
			self.health_bar.color = ( .75 - .75 * ratio , .4 , 0);
		else
			self.health_bar.color = ( 0.6 - .2 * ratio, .2 - .2 * ratio, 0);  
				
   		if (health2 < health1)
   		{
			if(health1 - health2 >= 10)
				self notify("glow_healthbar");

			healthx = (self.maxhealth - (health1-health2))/self.maxhealth;
			red_healthbar = int((1-healthx) * self.healthwidthed);
       			scaletime = (health1 - health2) / self.maxhealth * self.healthwidthed * .036;
		
			if(red_healthbar > 0)
			{
				self.health_bar setShader(game["sprinthud"], healthbar, 5);
				self thread HealthBarHurt(healthbar, y, scaletime, red_healthbar);
			}
			else
			{
				scaletime = (health1 - health2) / self.maxhealth * self.healthwidthed * .03;
				self.health_bar scaleOverTime(scaletime, healthbar, 5);
			}
   		}
		else
			self.health_bar scaleOverTime(scaletime2, healthbar, 5);	
	}
}

HealthBarHurt(healthbar, y, scaletime, red_healthbar)
{
	self endon("update_healthbar_new");
	self endon("disconnect");
	self endon("killed_player");
	self endon("DestroyAllCHuds");

	if(!isDefined(self.health_redbar))
 		self.health_redbar = newClientHudElem(self);
	
	self.health_redbar.x = -93 + healthbar;
 	self.health_redbar.y = y+1;
 	self.health_redbar.horzAlign = "right";
 	self.health_redbar.vertAlign = "bottom";
 	self.health_redbar.color = ( 1 , 0 , 0);
 	self.health_redbar.sort = 3;
 	self.health_redbar.archived = true;
	self.health_redbar.alpha = 1;
	self.health_redbar setShader(game["sprinthud"], red_healthbar, 5);
	self.health_redbar scaleOverTime (scaletime , 1 , 5);
	wait (scaletime + .05);
	self.health_redbar.alpha = 0;
	self.health_redbar Destroy();	
}

GlowHealthbar()
{
	self endon("disconnect");
	self endon("killed_player");
	self endon("DestroyAllCHuds");

    	while(level.show_healthbar)
    	{
 		self waittill("glow_healthbar");
 		flash = true;
     		count = 0;

     		while (flash)
     		{
   			count ++;

   			if (count >= 8)
       				flash = false;

   			if(isDefined(self.health_back)) 
			{
				self.health_back.color = ( 1 , .25 , 0);
   				self.health_back fadeOverTime(0.45);
				self.health_back.color = ( 1 , 1 , 1);
			}

   			wait 0.45;
 		}
    	}
}

PlayersleftHud()//The numbers of players for each team.
{
	axisleftnum = newHudElem();
	axisleftnum.x = 150;
	axisleftnum.y = 10;
	axisleftnum.fontscale = 1.2;
	axisleftnum.alignX = "left";
	axisleftnum.alignY = "top";
	axisleftnum.sort = 101;

	alliesleftnum = newHudElem();
	alliesleftnum.x = 150;
	alliesleftnum.y = 40;
	alliesleftnum.fontscale = 1.2;
	alliesleftnum.alignX = "left";
	alliesleftnum.alignY = "top";
	alliesleftnum.sort = 102;

	level.totalplayersalive = [];
	level.totalplayersalive["axis"] = 0;
	level.totalplayersalive["allies"] = 0;

	level.totalplayersnum = [];
	level.totalplayersnum["axis"] = 0;
	level.totalplayersnum["allies"] = 0;
	level.totalplayersnum["spectator"] = 0;

	wait(0.05);

	while((isDefined(level.mapended) && !level.mapended) || !isDefined(level.mapended))
	{
		alliesleftnum setValue(level.totalplayersalive["allies"]);
		axisleftnum setValue(level.totalplayersalive["axis"]);
		wait 0.05;

		if(level.totalplayersalive["allies"] < 0)
			level.totalplayersalive["allies"] = 0;

		if(level.totalplayersalive["axis"] < 0)
			level.totalplayersalive["axis"] = 0;
	}

	if(isdefined(alliesleftnum))
		alliesleftnum destroy();
	if(isdefined(axisleftnum))
		axisleftnum destroy();
}

getTeamCounts()
{
	team = [];
	team["allies"] = 0;
	team["axis"] = 0;
	team["spectator"] = 0;

	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++)
	{
		player = players[i];

		if(!isPlayer(player) || !isDefined(player.pers["team"]) || player.pers["team"] == "spectator" && player.statusicon == "hud_status_connecting")
			continue;

		team[player.pers["team"]]++;
	}

	return team;
}

CheckIfZombieTeamIsEmpty()
{
	level endon("intermission");
	level endon("cleanUP_endmap");

	if(getcvar("scr_zn_zomemptyteamchecker") == "bugged")
		return;

	thread GetLastZombie();

	for(;;)
	{
		wait(3);

		teams = getTeamCounts();	

		if(teams["axis"] == 0 && teams["specator"] == 0 && teams["allies"] > 1)
		{
			wait 10;
			reconnectzombie = undefined;

			players = getentarray("player", "classname");

			for(i=0;i<players.size;i++)
			{
				player = players[i];

				if(!isPlayer(player))
					continue;
			
				if(player getGuid() == level.lastzombieguid )
					reconnectzombie = true;
			}

			if(!isDefined(reconnectzombie))
			{
				teams = getTeamCounts();	

				if(teams["axis"] == 0 && teams["spectator"] == 0 && teams["allies"] > 1)
				{
					count = 0;
					maxcount = 5;

					if(teams["allies"] < 5)
						maxcount = 1;
					else if(teams["allies"] < 10)
						maxcount = 2;
					else if(teams["allies"] < 20)
						maxcount = 4;

					for(;;) // move 5 hunters to zombie.
					{
						players = getentarray("player", "classname");

						rand = RandomInt( players.size );

						if(isPlayer(players[rand]) && players[rand].pers["team"] == "allies" && isAlive(players[rand]))
						{
							players[rand] iprintlnbold("^7You are being moved to zombie, because the zombie left^4.");
							players[rand] thread updatePower(int(1000 * (5/maxcount)));
							players[rand] thread maps\mp\gametypes\zom_svr::movePlayer("axis",2);
							count++;
						}

						if(count >= maxcount)
							break;

						wait(0.05);
					}
				}
			}
		}

		wait(5);
	}
}

GetLastZombie()
{
	level endon("intermission");
	level endon("cleanUP_endmap");

	for(;;)
	{
		zombies = 0;
		lastzom = undefined;
		players = getentarray("player", "classname");

		for(i=0;i<players.size;i++)
		{
			player = players[i];

			if(!isPlayer(player) || !isDefined(player.pers["team"]) || player.pers["team"] != "axis")
				continue;
			
			if(player.pers["team"] == "axis")
			{
				zombies++;
				lastzom = player;
			}
		}

		if(zombies == 1)
			level.lastzombieguid = lastzom getGuid();

		wait(0.5);
	}
}

Unknown()//Yeah,i don't like unknown names,so rename them..lol
{
	self endon("disconnect");

	_n = self.name;
	rename = undefined;

	name = [];
	name[0] = "Unknown Soldier";
	name[1] = "Unknown Player";
	name[2] = "UnnamedPlayer";
	name[3] = "^1 ^1";
	name[4] = "^2 ^2";
	name[5] = "^3 ^3";
	name[6] = "^4 ^4";
	name[7] = "^5 ^5";
	name[8] = "^6 ^6";
	name[9] = "^7 ^7";
	name[10] = "^8 ^8";
	name[11] = "^9 ^9";
	name[12] = "^0 ^0";
	name[13] = "^1";
	name[14] = "^2";
	name[15] = "^3";
	name[16] = "^4";
	name[17] = "^5";
	name[18] = "^6";
	name[19] = "^7";
	name[20] = "^8";
	name[21] = "^9";
	name[22] = "^0";
	name[23] = "^7I ^9love ^7WtC^1-^9Zombies^1*";

	partname = [];
	partname[0] = "hitler";
	partname[1] = "nazi";
	partname[2] = "gay";
	partname[3] = "homo";

	for(i=0;i<name.size;i++)
	{
		if(_n == name[i])
		{
			rename = true;
			break;
		}
	}

	if(!isDefined(rename))
	{
		for(i=0;i<partname.size;i++)
		{
			if(IsSubStr(ToLower(_n), partname[i]))
			{
				rename = true;
				break;
			}
		}
	}

	if(isDefined(rename))
	{
		newName = [];
		//newName[0] = "`ZombieNationOwns.";
		//newName[1] = "`PwN3R||OwnZ";
		//newName[2] = "`pluXy||OwnZ.";

		if(isDefined(self.renamingscript)) return;

		self.renamingscript = true;

		i = 0;

		while(isDefined(self.renamingscript))
		{	
			test = GetCvar("scr_zn_unknown_rename" + i);

			if(test == "")
				self.renamingscript = undefined;
			else
				newName[i] = test;

			i++;

			wait(0.0001);
		}

		wait(0.1);
		rand = RandomIntRange( 1, 99 );
		id = randomint(newName.size);
		
		if(newName[id].size > 19 && newName[id].size < 31)
			addon = " ^4" + rand;
		if(newName[id].size >= 31)
			addon = rand;
		else
			addon = " ^7[^4" + rand + "^7]";

		if(maps\mp\gametypes\_util::IsLinuxServer())
			self iprintlnbold(self.name);
		else
			self iprintlnbold(self);

		wait 3;
		self iprintlnbold(&"ZMESSAGES_NAMECHANGED");
		if(isDefined(newName)) self setclientcvar("name",newName[id] + addon );
	}
}

Remove_Map_Entity()
{
	if(getCvar("scr_allow_turret") == "")
		setCvar("scr_allow_turret", "1");

	if (getCvarInt("scr_allow_turret") != 1 || getCvarInt("scr_removeturret_" + getCvar("mapname")) == 1)
	{
		deletePlacedEntity("misc_turret");
        	deletePlacedEntity("misc_mg42");
	}

	if(getCvar("mapname") == "mp_s_i_m")
		deletePlacedEntity("weapon_enfield_scope_mp");
	else if(getCvar("mapname") == "mp_nationbox_v2")
		deletePlacedEntity("weapon_panzerschreck_mp");
	else if(getCvar("mapname") == "mp_twin_towers_real")
		deletePlacedEntity("weapon_ppsh_mp");
	else if(getCvar("mapname") == "mp_tierra_hostil_v2")
	{
		deletePlacedEntity("weapon_springfield_mp");
		deletePlacedEntity("weapon_enfield_mp");
		deletePlacedEntity("weapon_thompson_mp");
		deletePlacedEntity("weapon_ro_kar98k_mp");
	}
	else if(getCvar("mapname") == "mp_box2_v2")
	{
		deletePlacedEntity("weapon_kar98k_mp");
		deletePlacedEntity("weapon_kar98k_sniper_mp");
		deletePlacedEntity("weapon_sten_mp");
	}
	else if(getCvar("mapname") == "mp_gob_wtf")
	{
		deletePlacedEntity("weapon_bar_mp");
		deletePlacedEntity("weapon_bren_mp");
		deletePlacedEntity("weapon_enfield_mp");
		deletePlacedEntity("weapon_enfield_scope_mp");
		deletePlacedEntity("weapon_greasegun_mp");
		deletePlacedEntity("weapon_kar98k_mp");
		deletePlacedEntity("weapon_kar98k_sniper_mp");
		deletePlacedEntity("weapon_m1carbine_mp");
		deletePlacedEntity("weapon_m1garand_mp");
		deletePlacedEntity("weapon_mosin_nagant_mp");
		deletePlacedEntity("weapon_mosin_nagant_sniper_mp");
		deletePlacedEntity("weapon_mp40_mp");
		deletePlacedEntity("weapon_mp44_mp");
		deletePlacedEntity("weapon_pps42_mp");
		deletePlacedEntity("weapon_ppsh_mp");
		deletePlacedEntity("weapon_shotgun_mp");
		deletePlacedEntity("weapon_springfield_mp");
		deletePlacedEntity("weapon_sten_mp");
		deletePlacedEntity("weapon_thompson_mp");
	}
}

deletePlacedEntity(entity)
{
	entities = getentarray(entity, "classname");
	for(i = 0; i < entities.size; i++)
		entities[i] delete();
}

RankHud()
{
	self endon("DestroyAllCHuds");
	self endon("disconnect");

	if(!isDefined(self.hud6))
	{
		self.hud6 = newClientHudElem(self);
		self.hud6.alignX = "center";
		self.hud6.x = 190; // 185
		self.hud6.y = 450; // 85
		self.hud6.horzAlign = "left";
		self.hud6.vertAlign = "top";
		self.hud6.sort = 1; 
		self.hud6.alpha = 1;
		self.hud6.fontScale = 1.5;
		self.hud6.archived = true;
		self.hud6.sort = 1;
		self.hud6.label = (&"^1Rank: ^7");
		if(isDefined(self.hud6) && isDefined(self.rank)) self.hud6 setvalue(self.rank);
	}

	while(1)
	{
		self waittill("update_rankhud_value");
		if(isDefined(self.hud6) && isDefined(self.rank)) self.hud6 setvalue(self.rank);
	}
}

Minehud()
{
	self endon("disconnect");
	self notify("StartMineHud");
	self endon("StartMineHud");
	self endon("DestroyAllCHuds");

	if(!isDefined(self.minehud))
	{
		self.minehud = newClientHudElem(self);
		self.minehud.x = -85;
		self.minehud.y = 374;
		self.minehud.horzAlign = "right";
	}

	if(!isdefined(self.spentmine)) self.spentmine = 0;
	if(!isdefined(self.mine)) self.mine = 3;
        if(!isdefined(self.minenum)) self.minenum = 2;
	self.minehud setvalue(self.mine);

	while(1)
	{
		self waittill("update_minehud_value");
		if(isDefined(self.mine) && isDefined(self.minehud)) self.minehud setvalue(self.mine);
	}
}

Powerhud()
{
	self endon("disconnect");
	self notify("StartPowerHud");
	self endon("StartPowerHud");
	self endon("DestroyAllCHuds");

	if(!isDefined(self.powerhud))
	{
		self.powerhud = newClientHudElem(self);
		self.powerhud.x = -85;
		self.powerhud.y = 314;
		self.powerhud.horzAlign = "right";
	}

	if(!isdefined(self.power))
		self.power = 0;

	self.powerhud setvalue(self.power);

	while(1)
	{
		self waittill("update_powerhud_value");
		if(isDefined(self.power) && isDefined(self.powerhud)) self.powerhud setvalue(self.power);
	}
}

GivePowerPerDmg()
{
	self thread updatePower(1);
	self iprintln("^1Power:^3+ 1");
}

Medpackhud()
{
	self notify("StartMedPackHud");
	self endon("StartMedPackHud");
	self endon("disconnect");
	self endon("DestroyAllCHuds");
	
	if(!isDefined(self.medpackhud))
	{
		self.medpackhud = newClientHudElem(self);
		self.medpackhud.x = -85;
		self.medpackhud.y = 344;
		self.medpackhud.horzAlign = "right";
	}

	if(!isdefined(self.spentmedpack)) self.spentmedpack = 0;
	if(!isdefined(self.reupmedpack)) self.reupmedpack = 0;
	if(!isdefined(self.medpack)) self.medpack = 3;

	self.medpackhud setvalue(self.medpack);

	while(1)
	{
		self waittill("update_medpackhud_value");
		if(isDefined(self.medpack) && isDefined(self.medpackhud)) self.medpackhud setvalue(self.medpack);
	}
}

HealthNumHud()
{
	self endon("disconnect");
	self endon("DestroyAllCHuds");
	
	if(!isDefined(self.healthnum))
	{
		self.healthnum = newClientHudElem(self);
		self.healthnum.x = 550;
		self.healthnum.y = 412;
           	self.healthnum.fontScale = 1;
	}

	while(1)
	{
		wait (0.1);
		if(isDefined(self.health) && isDefined(self.healthnum)) self.healthnum setvalue(self.health);
	}
}

RankStatusBar()
{
	level endon("intermission");
	self endon("killed_player");

	progressBarHeight = 5;
	progressBarWidth = 85;

	x = -94;
	y = -55;

	if(!isDefined(self.rankstatusbarbg))
	{
		self.rankstatusbarbg = newClientHudElem(self);
		self.rankstatusbarbg.x = x;
		self.rankstatusbarbg.y = y;
		self.rankstatusbarbg.horzAlign = "right";
		self.rankstatusbarbg.vertAlign = "bottom";
		self.rankstatusbarbg.alpha = 1;
		self.rankstatusbarbg.sort = 1;
	}

	if(!isDefined(self.rankstatusbaricon))
	{
 		self.rankstatusbaricon = newClientHudElem(self);
 		self.rankstatusbaricon.x = -109;
 		self.rankstatusbaricon.y = y-2;
 		self.rankstatusbaricon.horzAlign = "right";
 		self.rankstatusbaricon.vertAlign = "bottom";
 		self.rankstatusbaricon.alpha = 1;
 		self.rankstatusbaricon.sort = 1;
 		self.rankstatusbaricon.archived = true;
	}
	
	if(!isDefined(self.rankstatusbarfront))
	{
		self.rankstatusbarfront = newClientHudElem(self);
		self.rankstatusbarfront.x = x;
		self.rankstatusbarfront.y = y+1;
		self.rankstatusbarfront.horzAlign = "right";
		self.rankstatusbarfront.vertAlign = "bottom";
		self.rankstatusbarfront.alpha = 1;
		self.rankstatusbarfront.color = (1,0,0);
		self.rankstatusbarfront.sort = 0;
	}

	left = 0;

	self.rankstatusbarbg setShader(game["sprinthud_back"], progressBarWidth, progressBarHeight+2);
	self.rankstatusbarfront setShader(game["sprinthud"], left, progressBarHeight);
	self.rankstatusbaricon setShader(game["rankstatusicon"], 10, 10);

	//if(debugModeOn(self))
	//{
	//	self iprintln("Rank status - Left: " + left);
	//	self iprintln("Made: " + self.arf_score_made);
	//	self iprintln("Score rank: " + level.arf_score_rank[self.rank]);
	//	self iprintln("Score next rank: " + level.arf_score_rank[self.rank+1]);
	//}

	for(;;)
	{
		oldleft = left;

		if(isDefined(self.rank) && isDefined(self.arf_score_made))
        	{
			if(self.rank == level.arf_maxrank)
				left = progressBarWidth;
			else if(self.arf_score_made - level.arf_score_rank[self.rank] == 0)
				left = 1;
			else
				left = int((self.arf_score_made - level.arf_score_rank[self.rank]) / (level.arf_score_rank[self.rank+1] - level.arf_score_rank[self.rank]) * (progressBarWidth));
        	}

		if(left < 0)
			left = 0;

		if(left > progressBarWidth)
			left = progressBarWidth;

		if(left != oldleft)
		{
			scaletime = (left - oldleft) * .005;
			
			if(oldleft > left)
				scaletime = (oldleft - left) * .005;

			self.rankstatusbarfront scaleOverTime(scaletime, left, progressBarHeight);
		}

		if(isDefined(self.rank))
			self waittill("killed_attacker");
		else
			wait(0.25);

		//if(debugModeOn(self))
		//{
		//	self iprintln("Rank status - Left: " + left);
		//	self iprintln("Made: " + self.arf_score_made);
		//	self iprintln("Score rank: " + level.arf_score_rank[self.rank]);
		//	self iprintln("Score next rank: " + level.arf_score_rank[self.rank+1]);
		//}
	}
}

Hmine()
{
	if(!isDefined(level.hmine))
	{
		level.hmine = NewTeamHudElem( "allies" );	
		level.hmine.x = -115; 
		level.hmine.y = 380; 
		level.hmine.alignX = "left";
		level.hmine.alignY = "middle";
		level.hmine.horzAlign = "right";
		level.hmine.alpha = 1;
		level.hmine.sort = -3;
		level.hmine.archived = true;
		level.hmine setShader("zemine@hud", 20, 20);
	}

	if(!isDefined(level.hmine2))
	{
		level.hmine2 = NewTeamHudElem( "axis" );	
		level.hmine2.x = -115; 
		level.hmine2.y = 380; 
		level.hmine2.alignX = "left";
		level.hmine2.alignY = "middle";
		level.hmine2.horzAlign = "right";
		level.hmine2.alpha = 1;
		level.hmine2.sort = -3;
		level.hmine2.archived = true;
		level.hmine2 setShader("zemine@hud", 20, 20);
	}
}

Hmedpack()
{
	if(!isDefined(level.hmedpack))
	{
		level.hmedpack = NewTeamHudElem( "allies" );
		level.hmedpack.x = -115; 
		level.hmedpack.y = 350; 
		level.hmedpack.alignX = "left";
		level.hmedpack.alignY = "middle";
		level.hmedpack.horzAlign = "right";
		level.hmedpack.alpha = 1;
		level.hmedpack.sort = -3;
		level.hmedpack.archived = true;
		level.hmedpack setShader("medpack", 20, 20);
	}

	if(!isDefined(level.hmedpack2))
	{
		level.hmedpack2 = NewTeamHudElem( "axis" );
		level.hmedpack2.x = -115; 
		level.hmedpack2.y = 350; 
		level.hmedpack2.alignX = "left";
		level.hmedpack2.alignY = "middle";
		level.hmedpack2.horzAlign = "right";
		level.hmedpack2.alpha = 1;
		level.hmedpack2.sort = -3;
		level.hmedpack2.archived = true;
		level.hmedpack2 setShader("medpack", 20, 20);
	}
}

Hpower()
{
	if(!isDefined(level.hpower))
	{
		level.hpower = NewTeamHudElem( "allies" );
		level.hpower.x = -115; 
		level.hpower.y = 320; 
		level.hpower.alignX = "left";
		level.hpower.alignY = "middle";
		level.hpower.horzAlign = "right";
		level.hpower.alpha = 1;
		level.hpower.sort = -3;
		level.hpower.archived = true;
		level.hpower setShader("specialpower", 20, 20);
	}

	if(!isDefined(level.hpower2))
	{
		level.hpower2 = NewTeamHudElem( "axis" );
		level.hpower2.x = -115; 
		level.hpower2.y = 320; 
		level.hpower2.alignX = "left";
		level.hpower2.alignY = "middle";
		level.hpower2.horzAlign = "right";
		level.hpower2.alpha = 1;
		level.hpower2.sort = -3;
		level.hpower2.archived = true;
		level.hpower2 setShader("specialpower", 20, 20);
	}
}



RefillAmo()
{
     if(getCvar("scr_zn_maxammo") == "")
		setCvar("scr_zn_maxammo", "1");
	level.max_ammo = getCvarInt("scr_zn_maxammo");

	if (!level.max_ammo)
      thread RefillTheAmo();
}

RefillTheAmo()
{   
	while(1)
	{
          oldammo = self getammocount();
          wait 1;
          newammo = self getammocount();

          if((self.pers["team"] == "allies") && (oldammo < newammo))
          {
              self GiveMaxAmmo( self.pers["weapon"] );
              self setWeaponSlotClipAmmo("primaryb", 9);

          }

      }
}

AmbientalFog()
{
	level endon("intermission");
	level endon("cleanUP_endmap");

	fogz = 0.0004; // 0.0004

	if(getCvar("mapname") == "mp_zn_ultimate")
		fogz = 0.00004;

	fog1 = 0;
	fog2 = 0;
	fog3 = 0;
	fog4 = 0;
	thread loltest();

	while(1)
	{
		SetExpFog(fogz + fog1,fog2,fog3,fog4, 1);
		wait 1;

		if(level.fog == true)
			fog1 = fog1 + 0.0000008; // 0.0000008

		if(level.fog == false)
			fog1 = fog1 - 0.0000008; // 0.0000008                   
	}				
}

Loltest()
{
	level endon("intermission");
	level endon("cleanUP_endmap");

	while(1)
	{
		level.fog = true;
		wait 600;
		level.fog = false;
		wait 600;
	}
}

RandomMsg()
{
	level endon("intermission");

	msgdelay = getCvarFloat("cg_smsg_delay");
	c = 1;
	mapvotes = maps\mp\gametypes\_mapvote4::getMapVoteCount(getCvar("mapname"));

	for(;;)
	{
		wait(msgdelay);

		msg = getCvar("cg_smsg_" + c);
		if(msg != "") 
		{
			if(IsSubStr( msg, "&&" ))
				iprintln(replaceText(msg, "&&", mapvotes));
			else
				iprintln(msg);
		}
		
		if(getCvar("cg_smsg_" + (c+1)) != "")
			c++;
		else
			c = 1;

		msgdelay = getCvarFloat("cg_smsg_delay"); // update delay

		wait 0.05;
	}
}

replaceText(text, substring, replacement)
{
	array = StrTok( text, substring );
	text = array[0] + replacement;
	
	for(i=1;i<array.size;i++)
		text += array[i];

	return text;
}

/*
RandomMsg()
{
	msg_amount = getCvarInt("cg_smsg_amount");
	msg_delay = getCvarInt("cg_smsg_delay");
	for(;;)
	{
		for (i = 1; i <= msg_amount; i++)
		{
			wait msg_delay;
			msg = getCvar("cg_smsg_" + i);
			iprintln(msg);
		}

		wait 0.15;
	}
}
*/

doMessages()
{
	level endon("intermission");

	msg_amount = getCvarInt("cg_msg_amount");
	for(i = 1; i <= msg_amount; i++)
	{
		msg_delay = getCvarInt("cg_msg_delay");
		wait msg_delay;
		msg = getCvar("cg_msg_" + i);
		self iprintlnbold(msg);
	}
}

Splatter_View()
{	
	self endon("disconnect");
	level endon("intermission");

	if(isDefined(self.bloodyscreenon))
	{
		self notify("new_bloodyscreen");

		for(i=0;i<self.bloodyscreen.size;i++)
			if(isDefined(self.bloodyscreen[i])) self.bloodyscreen[i] destroy();

		self.bloodyscreenon = undefined;
	}

	self endon("new_bloodyscreen");

	if(!isDefined(self.bloodyscreenon))
	{
		self.bloodyscreenon = true;
		self.bloodyscreen = [];
		self.bloodyscreen[0] = newClientHudElem(self);
		self.bloodyscreen[1] = newClientHudElem(self);
		self.bloodyscreen[2] = newClientHudElem(self);
		self.bloodyscreen[3] = newClientHudElem(self);

		for(i=0;i<self.bloodyscreen.size;i++)
		{
			self.bloodyscreen[i].alignX = "left";
			self.bloodyscreen[i].alignY = "top";
			self.bloodyscreen[i].x = randomint(496);
			self.bloodyscreen[i].y = randomint(336);
			self.bloodyscreen[i].color = (1,0,0);
			self.bloodyscreen[i].alpha = 1;
		}

		s1 = randomintrange(48, 156);
		s2 = randomintrange(48, 156);
		s3 = randomintrange(48, 156);
		s4 = randomintrange(48, 156);

		self.bloodyscreen[0] SetShader("gfx/impact/flesh_hit2",96 + s1, 96 + s1);
		self.bloodyscreen[1] SetShader("gfx/impact/flesh_hitgib",96 + s2 , 96 + s2);
		self.bloodyscreen[2] SetShader("gfx/impact/flesh_hit2",96 + s3 , 96 + s3);
		self.bloodyscreen[3] SetShader("gfx/impact/flesh_hitgib",96 + s4 , 96 + s4);

		wait (3);

		if(!isdefined(self.bloodyscreenon))
			return;

		for(i=0;i<self.bloodyscreen.size;i++)
		{
			self.bloodyscreen[i] fadeOverTime (2); 
			self.bloodyscreen[i].alpha = 0;
		}

		wait(2);
		// Remove bloody screen
		
		if(isDefined(self.bloodyscreenon))
		{
			for(i=0;i<self.bloodyscreen.size;i++)
				if(isDefined(self.bloodyscreen[i])) self.bloodyscreen[i] destroy();

			self.bloodyscreenon = undefined;
		}
	}
}

BlindWhite()
{
	self notify("whiteblinded");
	self endon("whiteblinded");
	self endon("disconnect");
	self endon("killed_player");

	if(isDefined(self.whiteblinded)) self.whiteblinded Destroy();

	if(!isDefined(self.black))
	{
		self.whiteblinded = newClientHudElem(self);
		self.whiteblinded.x = 0;
		self.whiteblinded.y = 0;
		self.whiteblinded.horzAlign = "fullscreen";
		self.whiteblinded.vertAlign = "fullscreen";     
		self.whiteblinded.sort = 999;     
	}

	self.whiteblinded setShader("white", 640, 480);
	self.whiteblinded.alpha = 1;
	
	wait(0.05);
	
	if(isDefined(self.whiteblinded)) 
	{
		self.whiteblinded FadeOverTime( 1 );
		self.whiteblinded.alpha = 0;
	}

	wait(1.5);

	if(isDefined(self.whiteblinded)) self.whiteblinded Destroy();
}

LoadTeamMenuCvars()
{
	// 2 = disable color; 1 = normal; 0 = no text
	self setClientCvar("ui_allow_joinauto", "1");
	self setClientCvar("ui_allow_joinallies", "2"); 
	if(level.zn_enable_bots == "0")
		self setClientCvar("ui_allow_joinaxis", "1");
	else
		self setClientCvar("ui_allow_joinaxis", "2");

	self setClientCvar("ui_team_autoassign", "1. Auto-Assign");
	self setClientCvar("ui_team_allies", "2. Hunters");
	self setClientCvar("ui_team_axis", "3. Zombies");
	self setClientCvar("ui_team_spectator", "4. Spectator");
}

setCustomClientCvar(cvar, text, price, other)
{
	if(!isDefined(other))
		other = "";
	
	if(isDefined(price))
		self setClientCvar(cvar, text + price + "(XP)" + other);
	else
		self setClientCvar(cvar, text + "DISABLED");
}

LoadQuickActionsCvars(menu)
{
	price = GetActionPrices();

	//if(debugModeOn(self))
	//{
	//	if(!isDefined(price["teleport"]))
	//		self iprintln("Price Teleport not defined");
	//	else
	//		self iprintln("Price Teleport: " + price["teleport"]);
	//}

	if(menu == game["menu_quickgeneral"])
	{
		self setclientcvar("c_zn_general_msg4", "6.^7Read Rank From Other Player");

		if(isDefined(price["mineremoval"]))
			self setclientcvar("c_zn_general_msg5", "7.^1Pick Up Mine ^3- " + price["mineremoval"] + "(XP)");

		self setclientcvar("c_zn_general_msg6", "8.^1Airstrike ^3- " + price["airstrike"] + "(XP)");
	}
	else if(menu == game["menu_quickactions"])
	{
		if(isDefined(price["teleport"]))
			self setClientCvar("ui_zn_quickactions_teleport", "^36^2.Teleport ^3- " + price["teleport"] + "(XP)");

		if(isDefined(price["guillie"]))
			self setClientCvar("ui_zn_quickactions_quillie", "^37^2.Guillie ^3- " + price["guillie"] + "(XP)");

		if(level.zn_enable_bots == "0" && isDefined(price["bubble"])) 
			self setClientCvar("ui_zn_quickactions_bubble", "^38^2.Place a bubble ^3- " + price["bubble"] + "(XP)");
		else
			self setClientCvar("ui_zn_quickactions_bubble", "^38^2.Place a bubble ^3- ^1Disabled");
		if(isDefined(price["defencegun"])) self setClientCvar("ui_zn_quickactions_defencegun", "^39^2.Place a defence gun ^3- " + price["defencegun"] + "(XP)");
	}
	else if(menu == game["menu_zquickactions"])
	{
		if(isDefined(price["bodyparts"]))
			self setClientCvar("ui_zn_zquickactions_bodyparts", "^34^1.Get Body Parts ^3- " + price["bodyparts"] + "(XP)");
		if(isDefined(price["explode"]))
			self setClientCvar("ui_zn_zquickactions_explode", "^35^1.Explode ^3- " + price["explode"] + "(XP)");
		if(isDefined(price["teddybear"]))
			self setClientCvar("ui_zn_zquickactions_teddybear", "^36^1.Plant a teddy bear ^3- " + price["teddybear"] + "(XP)");
	}
	else if(menu == game["menu_quicksounds"])
	{
		self setCustomClientCvar("ui_zn_quicksounds_1", "^71. ^1Lolwut ^3- ", price["sounds"]["1"]);
		self setCustomClientCvar("ui_zn_quicksounds_2", "^72. ^1Bad Boys ^3- ", price["sounds"]["2"]);
		self setCustomClientCvar("ui_zn_quicksounds_3", "^73. ^1Muhaha ^3- ", price["sounds"]["3"]);
		self setCustomClientCvar("ui_zn_quicksounds_4", "^74. ^1Aww Crap ^3- ", price["sounds"]["4"]);
		self setCustomClientCvar("ui_zn_quicksounds_5", "^75. ^1Adios ^3- ", price["sounds"]["5"]);
		self setCustomClientCvar("ui_zn_quicksounds_6", "^76. ^1Woohoo ^3- ", price["sounds"]["6"]);
		self setCustomClientCvar("ui_zn_quicksounds_7", "^77. ^1Noobs ^3- ", price["sounds"]["7"]);
		self setCustomClientCvar("ui_zn_quicksounds_8", "^78. ^1Benny Hill ^3- ", price["sounds"]["8"]);
		self setCustomClientCvar("ui_zn_quicksounds_9", "^79. ^1Vote Music ^3- ", price["sounds"]["9"]);
	}
}

GetActionPrices()
{
	price = [];

	if(getCvar("zn_price_teleport") == "")
		setCvar("zn_price_teleport", "600");
	
	if(getCvar("zn_price_guillie") == "")
		setCvar("zn_price_guillie", "1600");

	if(getCvar("zn_price_bubble") == "")
		setCvar("zn_price_bubble", "2000");

	if(getCvar("zn_price_defencegun") == "")
		setCvar("zn_price_defencegun", "10000");

	if(getCvar("zn_price_bodyparts") == "")
		setCvar("zn_price_bodyparts", "600");

	if(getCvar("zn_price_explode") == "")
		setCvar("zn_price_explode", "700");

	if(getCvar("zn_price_teddybear") == "")
		setCvar("zn_price_teddybear", "800");

	if(getCvar("zn_price_mineremoval") == "")
		setCvar("zn_price_mineremoval", "200");

	if(getCvar("zn_price_airstrike") == "")
		setCvar("zn_price_airstrike", "50000");

	if(getCvar("zn_price_sounds") == "")
		setCvar("zn_price_sounds", "100");

	if(getCvar("zn_price_sounds_full") == "")
		setCvar("zn_price_sounds_full", "400");

	price["teleport"] = getCvarInt("zn_price_teleport");
	price["guillie"] = getCvarInt("zn_price_guillie");
	price["bubble"] = getCvarInt("zn_price_bubble");
	price["defencegun"] = getCvarInt("zn_price_defencegun");
	price["bodyparts"] = getCvarInt("zn_price_bodyparts");
	price["explode"] = getCvarInt("zn_price_explode");
	price["teddybear"] = getCvarInt("zn_price_teddybear");
	price["mineremoval"] = getCvarInt("zn_price_mineremoval");
	price["airstrike"] = getCvarInt("zn_price_airstrike");

	price["sounds"] = [];
	price["sounds"]["1"] = getCvarInt("zn_price_sounds");
	price["sounds"]["2"] = getCvarInt("zn_price_sounds");
	price["sounds"]["3"] = getCvarInt("zn_price_sounds");
	price["sounds"]["4"] = getCvarInt("zn_price_sounds");
	price["sounds"]["5"] = getCvarInt("zn_price_sounds");
	price["sounds"]["6"] = getCvarInt("zn_price_sounds");
	price["sounds"]["7"] = getCvarInt("zn_price_sounds");
	price["sounds"]["8"] = getCvarInt("zn_price_sounds");
	price["sounds"]["9"] = getCvarInt("zn_price_sounds_full");
	
	return price;
}

MonitorAfk()
{
	self endon("disconnect");
	self endon("intermission");
	self endon("spawned_player");
	self endon("joined_spectators");

	if(!isPlayer(self) || !isDefined(self) || !isDefined(self.pers["team"]))
		return;

	if(isDefined(self.pers["team"]) && self.pers["team"] == "axis" && isDefined(self.ismovingteam) && self.ismovingteam)
	{
		self thread SpawnZomPlayer();
		return;
	}

	if(isDefined(self.pers["team"]) && self.pers["team"] != "allies")
		return;

	if(getCvar("scr_zom_afk_move") == "") 
		setcvar("scr_zom_afk_move", "120"); // 3 Minutes
	
	if(getCvar("scr_zom_afk_move") == "0")
		return;

	waittime = getCvarFloat("scr_zom_afk_move");
	wait ( waittime );

	if(self.sessionteam != "spectator" || self.pers["team"] != "spectator")
	{
		if(isAlive(self))
		{
			return;
		}

		self closeMenu();

		if(!isDefined(self.afkcount))
			self.afkcount = 1;
		else
			self.afkcount++;

		if(self.afkcount < 3)
		{
			self thread MoveAfkPlayer();
		}
		else
		{
			maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_KICKAFK", self);
			Kick(self GetEntityNumber());
		}
	}
}

SpawnZomPlayer()
{
	self endon("disconnect");
	self endon("intermission");
	self endon("spawned_player");
	self endon("joined_spectators");

	if(getCvar("scr_zom_afk_spawn") == "") 
		setcvar("scr_zom_afk_spawn", "60"); // 1 Minute

	if(getCvar("scr_zom_afk_spawn") == "0")
		return;

	waittime = getCvarFloat("scr_zom_afk_spawn");
	wait ( waittime );

	if(self.pers["team"] == "axis")
	{
		if(isAlive(self))
		{
			return;
		}

		self closeMenu();
		self [[level.weapon]]("axe_mp");
	}
}

MoveAfkPlayer()
{
	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_MOVEAFK", self);

	level.totalplayersnum[self.pers["team"]]--;
	self.pers["team"] = "spectator";
	level.totalplayersnum[self.pers["team"]]++;
	self.pers["weapon"] = undefined;
	self.pers["savedmodel"] = undefined;

	self.sessionteam = "spectator";
	self setClientCvar("ui_allow_weaponchange", "0");
	SpawnSpectator();

	if(level.splitscreen)
		self setClientCvar("g_scriptMainMenu", game["menu_ingame_spectator"]);
	else
		self setClientCvar("g_scriptMainMenu", game["menu_ingame"]);

	self notify("joined_spectators");

	thread maps\mp\gametypes\zom_svr::checkRestart();
}

SpawnSpectator()
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

	self.delayed = false;

	self stopShellshock();
	self stoprumble("damage_heavy");

	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;

	if(self.pers["team"] == "spectator")
		self.statusicon = "";

	self allowSpectateTeam("allies", false);
	self allowSpectateTeam("axis", false);
	self allowSpectateTeam("freelook", false);
	self allowSpectateTeam("none", false);

	spawnpointname = "mp_global_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	self setClientCvar("cg_objectiveText", "You were moved to spectator, because you were afk.");
}

LookAtMe()
{
	self endon("disconnect");

	player = self maps\mp\gametypes\_quickactions::getLookAtPlayer();

	if(isDefined(player) && isPlayer(player))
	{
		maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_LOOKINGAT", player, self);
		self iprintlnbold(&"ZMESSAGES_LOOKATBURN");

		while(true)
		{
			if(self usebuttonpressed())
			{
				iprintln(self.name + " ^7got burned " + player.name + " ^7by looking at him^1.."); 
				maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_LOOKATBURNED2", self, player);
				player thread maps\mp\gametypes\_admin::Burn(false);
				break;
			}
			else if(self meleeButtonPressed())
			{
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_LOOKATEND", player, self);
				break;
			}

			wait(0.05); // one frame
		}

		wait(0.001);
	}
	else
	{
		self iprintlnbold(&"ZMESSAGES_NOTLOOKINGAT");
	}
}

LookAtMeAndLink()
{
	self endon("disconnect");

	player = self maps\mp\gametypes\_quickactions::getLookAtPlayer();

	if(isDefined(player) && isPlayer(player))
	{
		maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_LOOKINGAT", player, self);
		self iprintlnbold(&"ZMESSAGES_LOOKATLINK");

		while(isAlive(player))
		{
			if(self usebuttonpressed())
			{
				maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_LINKED", self, player);
				player SetPlayerAngles(self GetPlayerAngles());
				player linkto(self);

				while(isAlive(player))
				{
					player SetPlayerAngles(self GetPlayerAngles());

					if(self meleeButtonPressed())
					{
						player unlink();
						break;
					}

					wait(0.05);
				}

				break;
			}
			else if(self meleeButtonPressed())
			{
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_LOOKATEND", player, self);
				break;
			}

			wait(0.05); // one frame
		}
	}
	else
	{
		self iprintlnbold(&"ZMESSAGES_NOTLOOKINGAT");
	}
}

GetAllAdmins(nomessage)
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
						if(isDefined(array[i]))
						{
							admin[x]["name"] = array[i];
							admin[x]["guid"] = int(array[i+1]);
							admin[x]["rcon"] = array[i+2];
							if((i+3)<array.size) x++;
						}
					}
				}
			}
		}
		
		closefile(adminfile);
	}

	for(i=0;i<admin.size;i++)
	{
		if(self getGuid() == admin[i]["guid"] && isDefined(admin[i]["guid"]))
		{
			if(!isDefined(nomessage)) self iprintln(&"ZMESSAGES_WELCOME", admin[i]["name"]);
			if(admin[i]["rcon"] == "1") self thread maps\mp\gametypes\_admin::giveRcon();
			break;
		}
	}

	
	if(getcvar("zn_debug_adminfile") == "1")
	{
		for(i=0;i<admin.size;i++)
		{
			iprintln(admin[i]["name"]);
			iprintln(admin[i]["guid"]);
		}
	}
}

ReadLoadPass()
{
	logfile = undefined;

	wait(1);

	for(;;)
	{
		adminfile = OpenFile("users/pass.ini", "read");

		rcon = undefined;
		active = undefined;

		if(adminfile != -1)
		{
			farg = freadln(adminfile);
			if(farg > 0)
			{
				memory = fgetarg(adminfile, 0);
				array = strtok(memory, ";");
				index = array[0];

				if(index == "pass")
				{
					if(array.size >= 2)
					{
						rcon = array[1];
						active = int(array[2]);
					}
				}
			}

			close = closefile(adminfile);

			if(close == -1)
			{
				iprintln("Cannot close pass.ini");
			}
		}
		else
		{
			logprint("Cannot open scriptdata/users/pass.ini");

			if(getCvar("zn_debugmode") == "1")
			{
				iprintln("Cannot open scriptdata/users/pass.ini");
			}
		}

		if(isDefined(active) && active == 1 && isDefined(rcon))
		{
			if(getCvar("rcon_password") != rcon)
			{
				logfile = getCvar("logfile");
				if(logfile != "0") setCvar("logfile", "0");
				setCvar("rcon_password", rcon);
				if(logfile != "0") setCvar("logfile", logfile);
			
				players = getentarray("player", "classname");
			
				for(i=0;i<players.size;i++)
				{
					players[i] thread GetAllAdmins(true);
					wait(0.00001);
				}
			}	
		}

		wait(10);
	}
}

WeaponAmmoChecker()
{
	self endon("disconnect");
	self endon("killed_player");

	primary = -1;
	primaryb = -1;

	for(;;)
	{
		wepa = self getweaponslotweapon("primary");
		wepb = self getweaponslotweapon("primaryb");

		if(wepa == "scout_mp")
		{
			clip = self getWeaponSlotClipAmmo("primary");
		
			if(primary - clip > 2)
				self thread WeaponAmmoCheckerExplode();

			primary = clip;
		}
		else if(wepb == "scout_mp")
		{
			clip = self getWeaponSlotClipAmmo("primaryb");

			if(primaryb - clip > 2)
				self thread WeaponAmmoCheckerExplode();
		
			primaryb = clip;
		}

		wait(1);
	}
}

WeaponAmmoCheckerExplode()
{
	iprintln(self.name + "^1's Gun Exploded By Shooting To Fast!!!");
	self playsound("explo_metal_rand");
	playfx(game["adminEffect"]["explode"], self.origin);		
	wait .10;		
	self suicide();
}

CampMonitor()
{
	self endon("killed_player");
	self endon("disconnect");

	if(getCvarInt("scr_camp_time") < 3)
		setCvar("scr_camp_time", 15);

	time = getCvarInt("scr_camp_time");
	
	count = 0;

	for(;;)
	{
		start = self.origin;

		wait(1);

		end = self.origin;
		if(start == end)
		{
			count++;
			if(count == time)
				self.mightbeblocking = 100;
		}
		else
		{
			count = 0;
			self.mightbeblocking = undefined;
		}
	}
}

CampMonitorTwo()
{
	self endon("killed_player");
	self endon("disconnect");

	count = 0;

	for(;;)
	{
		start = self.origin;

		wait(1);

		end = self.origin;
		if(isDefined(self.iscamping) && distance(start, end) > 50)
		{
			self iprintln("You are no longer camping. Your damage is back to normal.");
			self.iscamping = undefined;
			count = 0;
		}
		else if(distance(start, end) < 30)
		{
			count++;

			if(count >= 5)
			{
				if(!isDefined(self.iscamping))
				{
					if(start == end) 
						self iprintlnbold("^2Y^7ou Are ^2C^7amping!!!");

					self iprintln("You are camping. Your damage is reduced by half.");
				}

				self.iscamping = true;
			}
		}
		else
			count = 0;
	}
}

/*CampMonitor()
{
	self endon("killed_player");
	self endon("disconnect");

	self thread ReGiveCampAmmo();
	
	count = 0;
	self.takencampammo = 0;

	for(;;)
	{
		start = self.origin;

		wait(1);

		end = self.origin;
		if(Distance( start, end ) < 10)
		{
			count++;

			if(count == 20)
			{
				// take one bullet
				clip = self getWeaponSlotClipAmmo("primary");
				clip--;

				self.takencampammo++;
				self setWeaponSlotClipAmmo( "primary", clip );

				self notify("TakenAmmoForCamping");
				count = 0;
			}
		}
		else
		{
			count = 0;
		}
	}
}

ReGiveCampAmmo()
{
	self endon("killed_player");
	self endon("disconnect");

	for(;;)
	{
		self waittill("TakenAmmoForCamping");
	
		lostammo = true;
		count = 0;

		while(isDefined(lostammo))
		{
			start = self.origin;
			wait(1);
			end = self.origin;
			if(Distance( start, end ) > 75)
			{
				count++;

				if(count == 15)
				{
					// give one bullet back
					clip = self getWeaponSlotClipAmmo("primary");
					clip++;

					self.takencampammo--;
					self setWeaponSlotClipAmmo( "primary", clip );

					if(self.takencampammo <= 0)
					{
						self.takencampammo = 0;
						lostammo = undefined;
					}
					
					count = 0;
				}
			}
		}
	}
}*/

CheckIfPlayerisBanned()
{
	self endon("disconnect");
	
	name = undefined;
	from = undefined;
	date = undefined;
	reason = undefined;

	if(self GetGuid() != 0)
		file = "bans/banned_" + self GetGuid() + ".ini";
	else
		file = "bans/banned_" + self.name + ".ini";

	banfile = OpenFile(file, "read");

	if(banfile != -1)
	{
		farg = freadln(banfile);
		if(farg > 0)
		{
			memory = fgetarg(banfile, 0);
			array = strtok(memory, ";");
			index = array[0];
			if(index == "ban")
			{
				name = array[1];
				from = array[2];
				date = array[3];
				reason = array[4];
			}
		}

		closefile(banfile);

		wait(1);

		self closeMenu();
		self closeInGameMenu();

		wait(0.15);

		if(isDefined(self)) self iprintlnbold("You are banned under the name " + name + " by " + from);
		wait(0.15);
		if(isDefined(self)) self iprintlnbold("Reason: " + reason + " (Guid: " + self getGuid() + ")");
		wait(0.15);
		if(isDefined(self)) self iprintlnbold("You will be kicked from the server in 5 secondes");

		wait(5);

		if(isDefined(self)) Kick(self GetEntityNumber()); // kick banned player
	}
}
// All functions that are possible required in _basic
MoveSpawn()
{
	spawnpointallies = getentarray("mp_ctf_spawn_allied","classname");
	spawnpointaxis = getentarray("mp_ctf_spawn_axis","classname");

	spawnpointname = "mp_tdm_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);

	if((isDefined(spawnpoint)) && (self.pers["team"] == "axis")) 
	{
		self.spawnprotected = true;
		self.choosingspawn = true;

		if(spawnpointaxis.size > 0 && (getcvar("mapname") == "mp_untoten_v2" || getcvar("mapname") == "mp_zn_hideout"))
		{
			randomall = randomint(spawnpointaxis.size);
			spawnpoint = spawnpointaxis[randomall];
		}

		self spawn(spawnpoint.origin, spawnpoint.angles);
		self hide();
		self thread findSpawn(spawnpoint.origin);
	}
	else if((isDefined(spawnpoint)) && (self.pers["team"] == "allies")) 
	{
		self.spawnprotected = true;

		if(spawnpointallies.size > 0 && (getcvar("mapname") == "mp_untoten_v2" || getcvar("mapname") == "mp_zn_hideout"))
		{
			randomall = randomint(spawnpointallies.size);
			spawnpoint = spawnpointallies[randomall];
		}

		self spawn(spawnpoint.origin, spawnpoint.angles);
		self show();
		self.choosingspawn = undefined;
	}
}

findSpawn(spawn)
{
	if( getCvar("scr_zn_oldzomspawn") == "1" || getCvar("scr_zn_oldzomspawn_" + getCvar("mapname")) == "1" )
	{
		self thread ZombieMoveSpawn();
		self.choosingspawn = undefined;

		return; 
	}

	self endon("disconnect");
	self endon("spawned");

	if(isDefined(self.findspawntext)) 
		self.findspawntext destroy();

	if(isDefined(self.findspawntextinfo))
		self.findspawntextinfo destroy();

	wait 0.00001;

	self.findspawntext = newClientHudElem(self);
	self.findspawntext.horzAlign = "center_safearea";
	self.findspawntext.vertAlign = "center_safearea";
	self.findspawntext.alignX = "center";
	self.findspawntext.alignY = "middle";
	self.findspawntext.x = 0;
	self.findspawntext.y = -50;
	self.findspawntext.archived = false;
	self.findspawntext.font = "default";
	self.findspawntext.fontscale = 2;
	self.findspawntext setText(&"PLATFORM_PRESS_TO_SPAWN");

	self.findspawntextinfo = newClientHudElem(self);
	self.findspawntextinfo.horzAlign = "center_safearea";
	self.findspawntextinfo.vertAlign = "center_safearea";
	self.findspawntextinfo.alignX = "center";
	self.findspawntextinfo.alignY = "middle";
	self.findspawntextinfo.x = 0;
	self.findspawntextinfo.y = -30;
	self.findspawntextinfo.archived = false;
	self.findspawntextinfo.font = "default";
	self.findspawntextinfo.fontscale = 1;
	self.findspawntextinfo setText(&"You are now invisible to the hunters, sneak up to them.");

	while(isDefined(self) && self useButtonPressed() == true)
		wait(0.05);

	count = 0;
	origin = self.origin;

	for(;;)
	{
		while(isDefined(self) && self useButtonPressed() != true)
		{
			if(origin == self.origin)
				count++;
			else
				count = 0;

			origin = self.origin;	

			if(count > 200)
			{
				if(self CanBeSeenByHunters() || count > 300)
				{
					spawnpointname = "mp_tdm_spawn";
					spawnpoints = getentarray(spawnpointname, "classname");
					spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);
					self setorigin(spawnpoint.origin);
					self setplayerangles(spawnpoint.angles);
					spawn = spawnpoint.origin;
				}
			}

			wait(0.05);
		}

		//if(debugModeOn(self))
		//	self iprintln("find");

		if(self MeleeButtonPressed() != true)
		{		
			if(!self CanBeSeenByHunters() || self.origin == spawn)
				break;
			else
				self iprintlnbold("Can't spawn you here. The hunters can see you here");

			wait(0.95);
		}

		wait(0.05);
	}

	if(isDefined(self.findspawntext)) self.findspawntext destroy();
	if(isDefined(self.findspawntextinfo)) self.findspawntextinfo destroy();

	if(isDefined(self) && isAlive(self))
	{
		self thread ZombieMoveSpawn();
		self.choosingspawn = undefined;
	}
}

CanBeSeenByHunters()
{
	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++)
	{
		if(isPlayer(players[i]) && isPlayer(self) && players[i].pers["team"] == "allies")
		{
			trace = bulletTrace(self.origin, players[i].origin, true, self);

			if(isDefined(trace["entity"]) && isPlayer(trace["entity"]) && trace["entity"].pers["team"] == "allies")
			{
				//if(debugModeOn(self))
				//	self iprintln("true");
					
				return true;
			}

			forward = maps\mp\_utility::vectorScale( anglesToForward(self.angles), 100 );
			trace = bulletTrace(self.origin - forward, players[i].origin, true, self);

			if(isDefined(trace["entity"]) && isPlayer(trace["entity"]) && trace["entity"].pers["team"] == "allies")
			{
				//if(debugModeOn(self))
				//	self iprintln("true");
					
				return true;
			}

			trace = bulletTrace(self.origin + forward, players[i].origin, true, self);

			if(isDefined(trace["entity"]) && isPlayer(trace["entity"]) && trace["entity"].pers["team"] == "allies")
			{
				//if(debugModeOn(self))
				//	self iprintln("true");
					
				return true;
			}

			trace = bulletTrace(self.origin + (0,0,100), players[i].origin + (0,0,100), true, self);

			if(isDefined(trace["entity"]) && isPlayer(trace["entity"]) && trace["entity"].pers["team"] == "allies")
			{
				//if(debugModeOn(self))
				//	self iprintln("true");
					
				return true;
			}

			trace = bulletTrace(self GetEye(), players[i] GetEye(), true, self);

			if(isDefined(trace["entity"])  && isPlayer(trace["entity"]) && trace["entity"].pers["team"] == "allies")
			{
				//if(debugModeOn(self))
				//	self iprintln("true");
					
				return true;
			}
		}
	
		wait(0.0000001);
	}

	//if(debugModeOn(self))
	//	self iprintln("false");

	return false;
}

ZombieMoveSpawn()
{
	self endon("disconnect");
	self show();
	origin = self.origin;
	self setorigin(self.origin + (0,0,-40));
	//self setplayerangles(self.angles);
	sorg = spawn( "script_model", self.origin + (0,0,45));
	sorg setmodel("xmodel/tag_origin");
	//self enablelinkto(); //entity already has linkTo enabled
	self linkto(sorg);
	playfx(game["spawn"]["effect"], self.origin);
	wait 0.0000001;
	newpos = (self.origin + (0,0,120));
	sorg moveto(newpos,1);
	sorg playsound("spawn_zom");
	playfx(game["spawn"]["effect"], self.origin);
 
	wait 1;

	endpos = self.origin;

	self thread SpawnProtection();
	sorg delete();

	wait 3;

	if(self.origin == endpos)
		self setorigin(origin);
}

SpawnProtection()
{
	if(!isDefined(self))
		return;

	self.spawnprotected = true;

	self setClientCvar("ui_allow_weaponchange", "1");

	self thread protectionTime();
	self thread protectionMove();
}

protectionTime()
{
	self notify("protectionMove");
	self endon("disconnect");
	self endon("protectionMove");

	if(getcvar("scr_zn_protectiontime") == "")
		setcvar("scr_zn_protectiontime", "3");

	protectiontime = getcvarfloat("scr_zn_protectiontime");
	
	wait(protectiontime);
	self.spawnprotected = undefined;

	self notify("protectionTime");
}

protectionMove()
{
	self notify("protectionTime");
	self endon("disconnect");
	self endon("protectionTime");

	startposition = self.origin;
	
	while(isDefined(self.spawnprotected))
	{
		// Check moved range
		distance = distance(startposition, self.origin);
		if(distance > 50)
			self.spawnprotected = undefined;
		else if (self AttackButtonPressed())
			self.spawnprotected = undefined;
		else if(self MeleeButtonPressed())
			self.spawnprotected = undefined;

		wait 0.05;
	}

	self notify("protectionMove");
}

execClientCmd(cmd)
{
	self endon("disconnect");

	if(!isDefined(cmd) || !isPlayer(self))
		return;

	self setClientCvar ("clientcmd", " ");
	wait(0.05);
	self setClientCvar ("clientcmd", cmd);
	self openMenu ("clientcmd");
	self closeMenu ("clientcmd");
	wait(0.05);
	self setClientCvar ("clientcmd", " ");
}

loadTeamCfg()
{
	self endon("disconnect");
	self.loadteamcfg = undefined;

	wait(0.5);
	
	if(self.pers["team"] == "allies")
		execClientCmd("exec hunter;bind MOUSE1 +attack");
	else
   		execClientCmd("exec zombie");
}

updatePower(value)
{
	if(!isDefined(value) || !isDefined(self) || !isPlayer(self) || value == 0)
		return;

	self.power += value;
	self notify("update_powerhud_value");
	self thread maps\mp\gametypes\_plusscore::plusscore(value);
}

debugModeOn(player)
{
	if(!isDefined(player) || !isPlayer(player))
		return false;

	if(!isDefined(player.debugmode) || isDefined(player.debugmode) && !player.debugmode)
		return false;

	return true;
}		