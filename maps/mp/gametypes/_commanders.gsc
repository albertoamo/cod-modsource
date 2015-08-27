Commander()
{
	if(getcvar("zn_select_no_commander") == "1") return;

	level.bounty = [];

	wait(45);

	for(;;)
	{
		players = getentarray("player", "classname");

   	 	teamPlayers = [];
  	 	teamPlayers["allies"] = [];
  	 	teamPlayers["axis"] = [];

  		for(i=0;i<players.size; i++)
  	 	{
    	 		plr = players[i];
      
    	  		if(isDefined(plr.pers["team"]) && isDefined(teamPlayers[plr.pers["team"]]) && plr.sessionstate == "playing")
   	      			teamPlayers[plr.pers["team"]][teamPlayers[plr.pers["team"]].size] = plr;
  	 	}

		if(teamPlayers["allies"].size > 0)
   	 	{
    			level.bounty["allies"] = teamPlayers["allies"][randomInt(teamPlayers["allies"].size)];
    			level.bounty["allies"] thread AlliedCommander();
			level.bounty["allies"] waittill("disconnect");
  	 	}
	 	else
	 	{
			if(teamPlayers["axis"].size > 0)
   	 		{
				level.bounty["axis"] = teamPlayers["axis"][randomInt(teamPlayers["axis"].size)];
				level.bounty["axis"] thread AxisCommander();
				level.bounty["axis"] waittill("disconnect");
  	        	}
		}

		wait(0.05); // one frame
	}
}

AlliedCommander()
{
	self endon("disconnect");

	if(!isAlive(self))
		self waittill("spawned_player");

	self iprintlnbold(&"ZMESSAGES_HUNTERCOMMANDER");
	self iprintlnbold(&"ZMESSAGES_COMMANDERHEALTH");
	wait 1;
	self iprintlnbold(&"ZMESSAGES_HUNTERCOMMANDER2");
	wait 1;
   	maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_ISHUNTERCOMMANDER", self);

	self giveAlliesStuff();

	self maps\mp\gametypes\_basic::UpdateHealthLogo();

	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ISHUNTERCOMMANDER", self);

	self thread GiveStuffOnSpawn();
}

AxisCommander()
{
	self endon("disconnect");

	if(!isAlive(self))
		self waittill("spawned_player");	

	self iprintlnbold(&"ZMESSAGES_ZOMBIECOMMANDER");
	self iprintlnbold(&"ZMESSAGES_COMMANDERHEALTH");

	wait 1;

	self giveAxisStuff();

	self maps\mp\gametypes\_basic::UpdateHealthLogo();

	maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_ISZOMBIECOMMANDER", self);
	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ISZOMBIECOMMANDER", self);

	self thread GiveStuffOnSpawn();
}

giveAxisStuff()
{
	self.maxhealth = self.maxhealth + 100;
	self.health = self.maxhealth;
	self notify("update_healthbar");
}

giveAlliesStuff()
{
	wait(0.05);

	if(getCvar("zn_cmd_notesla") == "0")
	{
		self setWeaponSlotWeapon("primary", "tesla_mp");
		self SwitchToWeapon("tesla_mp");
		self iprintlnbold("^1You are now armed with Tesla Raygun");
		self.pers["weapon"] = "tesla_mp";
   	}

   	if(!isdefined(self.mine)) 
		self.mine = 3;
	
	if(!isdefined(self.medpack)) 
		self.medpack = 3;

   	self.maxhealth = self.maxhealth + 80;
	self.health = self.maxhealth;
	self notify("update_healthbar");

	self.mine = self.mine + 1;
	self.medpack = self.medpack + 1;
	self notify("update_medpackhud_value");
	self notify("update_minehud_value");
}

GiveStuffOnSpawn()
{
 	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");

		if(self.pers["team"] == "allies")
			self giveAlliesStuff();
		else
			self giveAxisStuff();
	}
}

isCommander(player)
{
	if(!isDefined(level.bounty))
		return false;
	else if(isDefined(level.bounty["allies"]) && level.bounty["allies"] == player)
		return true;
	else if(isDefined(level.bounty["axis"]) && level.bounty["axis"] == player)
		return true;
	else
		return false;
}

init()
{
	if(getcvar("zn_no_cmdhq") == "1" || getCvar("zn_enable_bots") == "1") return;
	
	//custom radio colors for different nationalities
	if(game["allies"] == "american")
		game["radio_model"] = "xmodel/military_german_fieldradio_green_nonsolid";
	else if(game["allies"] == "british")
		game["radio_model"] = "xmodel/military_german_fieldradio_tan_nonsolid";
	else if(game["allies"] == "russian")
		game["radio_model"] = "xmodel/military_german_fieldradio_grey_nonsolid";
	assert(isdefined(game["radio_model"]));

	precacheShader("objpoint_A");
	precacheShader("objpoint_B");
	precacheModel(game["radio_model"]);
	precacheString(&"MP_ESTABLISHING_HQ");
	precacheString(&"MP_DESTROYING_HQ");

	level._effect["radioexplosion"] = loadfx("fx/explosions/grenadeExp_blacktop.efx");

	level.progressBarHeight = 12;

	if(level.splitscreen)
		level.progressBarWidth = 152;
	else
		level.progressBarWidth = 192;

	game["radio_objpoint"][0] = "objpoint_A";
	game["radio_objpoint"][1] = "objpoint_B";

	getCmdRadios(getcvar("mapname"));

	wait(60);

	if(isDefined(level.cmdradio))
	{
		max = level.cmdradio.size;

		if(max > 2)
			max = 2;

		for(i=0;i<max;i++) level thread cmd_radio_think(level.cmdradio[i], i + 1);
	}
}

getCmdRadios(map)
{
	if(getcvar("zn_no_cmdhq_" + map) == "1") return;

	if(map == "mp_xyzzbeta")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-2516.8, 752.981, 272.125));
		level.cmdradio[0].angles = (0,270,0);
		level.cmdradio[1] = spawn("script_model", (1109.3, -24.5328, 128.125));
		level.cmdradio[1].angles = (0,90,0);
	}
	else if(map == "mp_govas")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-1733.63, 1503.06, 16.125));
		level.cmdradio[0].angles = (0,180,0);
		level.cmdradio[1] = spawn("script_model", (-115.644, 842.709, 1232.13));
		level.cmdradio[1].angles = (0,90,0);
	}
	else if(map == "mp_zomvladom")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (1789.58, 645.36, 320.125));
		level.cmdradio[0].angles = (0,90,0);
		level.cmdradio[1] = spawn("script_model", (738.7, -1513.49, 192.125));
		level.cmdradio[1].angles = (0,0,0);
	}
	else if(map == "mp_undertrad")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-140.672, 1315.45, 528.125));
		level.cmdradio[0].angles = (0,180,0);
		level.cmdradio[1] = spawn("script_model", (-66.1014, -1942, -95.875));
		level.cmdradio[1].angles = (0,0,0);
	}
	else if(map == "mp_questie_v4")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-761.349, 2050.96, 16.125));
		level.cmdradio[0].angles = (0,180,0);
		level.cmdradio[1] = spawn("script_model", (-19.8224, 164.475, 64.125));
		level.cmdradio[1].angles = (0,0,0);
	}
	else if(map == "mp_gangzap")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-1273.56, 2685.03, 16.125));
		level.cmdradio[0].angles = (0,0,0);
		level.cmdradio[1] = spawn("script_model", (-787.975, -270.451, 16.125));
		level.cmdradio[1].angles = (0,180,0);
	}
	else if(map == "mp_zombiezone_v3")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (150.837, 52.4172, 800.125));
		level.cmdradio[0].angles = (0,0,0);
		level.cmdradio[1] = spawn("script_model", (82.3478, 1168.49, -63.875));
		level.cmdradio[1].angles = (0,0,0);
	}
	else if(map == "mp_trofsta")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-1886.14, 906.839, 256.125));
		level.cmdradio[0].angles = (0,-90,0);
		level.cmdradio[1] = spawn("script_model", (1443.21, 499.272, 256.125));
		level.cmdradio[1].angles = (0,0,0);
	}
	else if(map == "mp_urban")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-2972.14, 1904.32, 376.125));
		level.cmdradio[0].angles = (0,-90,0);
		level.cmdradio[1] = spawn("script_model", (-884.158, -1479.93, 1672.13));
		level.cmdradio[1].angles = (0,0,0);
	}
	else if(map == "mp_bsf_arena")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-2446.04, -828.824, 448.125));
		level.cmdradio[0].angles = (0,0,0);
		level.cmdradio[1] = spawn("script_model", (-543.076, 102.265, 64.125));
		level.cmdradio[1].angles = (0,90,0);
	}
	else if(map == "mp_zn_underground")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (356.361, 120.174, 1008.13));
		level.cmdradio[0].angles = (0,0,0);
		level.cmdradio[1] = spawn("script_model", (-6082.45, -16085.6, 559.125));
		level.cmdradio[1].angles = (0,-90,0);
	}
	else if(map == "mp_zn_underground_v2")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (356.361, 120.174, 1008.13));
		level.cmdradio[0].angles = (0,0,0);
		level.cmdradio[1] = spawn("script_model", (-4503.67, -9332.86, -21.875));
		level.cmdradio[1].angles = (0,90,0);
	}
	else if(map == "mp_zn_house")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-1068.35, 2374.59, 176.125));
		level.cmdradio[0].angles = (0,180,0);
		level.cmdradio[1] = spawn("script_model", (-125.178, 535.879, 465.125));
		level.cmdradio[1].angles = (0,0,0);
	}
	else if(map == "mp_toujane")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (1144.47, 839.761, 198.125));
		level.cmdradio[0].angles = (0,0,0);
		level.cmdradio[1] = spawn("script_model", (2272.35, 2475.82, 71.5672));
		level.cmdradio[1].angles = (0,100,0);
	}
	else if(map == "mp_zombiemania")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (795.578, 404.637, -455.875));
		level.cmdradio[0].angles = (0,90,0);
		level.cmdradio[1] = spawn("script_model", (-772.922, -121.532, 208.125));
		level.cmdradio[1].angles = (0,270,0);
	}
	else if(map == "mp_zn_bunker")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (-7615.64, -1678.44, 537.125));
		level.cmdradio[0].angles = (0,0,0);
		level.cmdradio[1] = spawn("script_model", (77.8038, -3501.95, 0.124999));
		level.cmdradio[1].angles = (0,-90,0);
	}
	else if(map == "mp_nationbox_v2")
	{
		level.cmdradio = [];
		level.cmdradio[0] = spawn("script_model", (255.983, 2387.85, -7.875));
		level.cmdradio[0].angles = (0,0,0);
		level.cmdradio[1] = spawn("script_model", (-98.9653, -4368.35, 2792.13));
		level.cmdradio[1].angles = (0,180,0);
	}
}

cmd_radio_think(radio, id)
{
	level endon("cleanUP_endmap");
	level endon("intermission");

	holdtime_allies = 0;
	holdtime_axis = 0;

	radio setmodel(game["radio_model"]);
	radio hide();
	radio.planted = undefined;

	while(1)
	{
		players = getentarray("player", "classname");

		allies = 0;
		axis = 0;

		for(i=0;i<players.size;i++)
		{
			if(players[i].pers["team"] == "allies" && !isDefined(players[i].spawnprotected))
			{
				if(((distance(players[i].origin,radio.origin)) <= 120) && (distance((0,0,players[i].origin[2]),(0,0,radio.origin[2])) <= 72) && players[i].sessionstate == "playing")
					allies++;
			}

			if(players[i].pers["team"] == "axis" && !isDefined(players[i].spawnprotected))
			{
				if(((distance(players[i].origin,radio.origin)) <= 120) && (distance((0,0,players[i].origin[2]),(0,0,radio.origin[2])) <= 72) && players[i].sessionstate == "playing")
					axis++;
			}

			playerisbounty = isCommander(players[i]);

			if(isDefined(players[i].pers["team"]) && players[i].pers["team"] != "allies" && playerisbounty)
				players[i] thread DestroyCmdObjPoint();	

			if((distance(players[i].origin,radio.origin) <= 120) && (distance((0,0,players[i].origin[2]),(0,0,radio.origin[2])) <= 72))
				players[i].inhqrange = true;

			if(!isDefined(level.cmdradiodelayed) && !isDefined(radio.planted) && isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies" && players[i].sessionstate == "playing" && playerisbounty)
			{
				if(id == 1)
					if(!isDefined(players[i].cmdobjpoint)) players[i] thread addObjpoint(radio.origin, id, game["radio_objpoint"][id-1]);
				else if(id == 2)
					if(!isDefined(players[i].cmdobjpoint2)) players[i] thread addObjpoint(radio.origin, id, game["radio_objpoint"][id-1]);

				if((distance(players[i].origin,radio.origin) <= 120) && (distance((0,0,players[i].origin[2]),(0,0,radio.origin[2])) <= 72))
				{
					players[i].inhqrange = true;

					if(!isdefined(players[i].progressbar_capture))
					{
						players[i].progressbar_capture = newClientHudElem(players[i]);
						players[i].progressbar_capture.x = 0;

						if(level.splitscreen)
							players[i].progressbar_capture.y = 70;
						else
							players[i].progressbar_capture.y = 104;

						players[i].progressbar_capture.alignX = "center";
						players[i].progressbar_capture.alignY = "middle";
						players[i].progressbar_capture.horzAlign = "center_safearea";
						players[i].progressbar_capture.vertAlign = "center_safearea";
						players[i].progressbar_capture.alpha = 0.5;
					}

					players[i].progressbar_capture setShader("black", level.progressBarWidth, level.progressBarHeight);

					if(!isdefined(players[i].progressbar_capture2))
					{
						players[i].progressbar_capture2 = newClientHudElem(players[i]);
						players[i].progressbar_capture2.x = ((level.progressBarWidth / (-2)) + 2);

						if(level.splitscreen)
							players[i].progressbar_capture2.y = 70;
						else
							players[i].progressbar_capture2.y = 104;

						players[i].progressbar_capture2.alignX = "left";
						players[i].progressbar_capture2.alignY = "middle";
						players[i].progressbar_capture2.horzAlign = "center_safearea";
						players[i].progressbar_capture2.vertAlign = "center_safearea";
						players[i].progressbar_capture2.color = (0,0,1);
					}

					players[i].progressbar_capture2 setShader("white", holdtime_allies, level.progressBarHeight - 4);

					if(!isdefined(players[i].progressbar_capture3))
					{
						players[i].progressbar_capture3 = newClientHudElem(players[i]);
						players[i].progressbar_capture3.x = 0;

						if(level.splitscreen)
							players[i].progressbar_capture3.y = 16;
						else
							players[i].progressbar_capture3.y = 50;

						players[i].progressbar_capture3.alignX = "center";
						players[i].progressbar_capture3.alignY = "middle";
						players[i].progressbar_capture3.horzAlign = "center_safearea";
						players[i].progressbar_capture3.vertAlign = "center_safearea";
						players[i].progressbar_capture3.archived = false;
						players[i].progressbar_capture3.font = "default";
						players[i].progressbar_capture3.fontscale = 2;
						players[i].progressbar_capture3 settext(&"MP_ESTABLISHING_HQ");
					}
				}
				else
				{
					if(!isDefined(players[i].inhqrange))
					{
						if(isdefined(players[i].progressbar_capture))
							players[i].progressbar_capture Destroy();
						if(isdefined(players[i].progressbar_capture2))
							players[i].progressbar_capture2 Destroy();
						if(isdefined(players[i].progressbar_capture3))
							players[i].progressbar_capture3 Destroy();
					}

					players[i].inhqrange = undefined;
				}
			}
			else if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "axis" && players[i].sessionstate == "playing" && isDefined(radio.planted))
			{
				if((distance(players[i].origin,radio.origin) <= 120) && (distance((0,0,players[i].origin[2]),(0,0,radio.origin[2])) <= 72))
				{
					players[i].inhqrange = true;

					if(!isdefined(players[i].progressbar_capture))
					{
						players[i].progressbar_capture = newClientHudElem(players[i]);
						players[i].progressbar_capture.x = 0;

						if(level.splitscreen)
							players[i].progressbar_capture.y = 70;
						else
							players[i].progressbar_capture.y = 104;

						players[i].progressbar_capture.alignX = "center";
						players[i].progressbar_capture.alignY = "middle";
						players[i].progressbar_capture.horzAlign = "center_safearea";
						players[i].progressbar_capture.vertAlign = "center_safearea";
						players[i].progressbar_capture.alpha = 0.5;
					}

					players[i].progressbar_capture setShader("black", level.progressBarWidth, level.progressBarHeight);

					if(!isdefined(players[i].progressbar_capture2))
					{
						players[i].progressbar_capture2 = newClientHudElem(players[i]);
						players[i].progressbar_capture2.x = ((level.progressBarWidth / (-2)) + 2);

						if(level.splitscreen)
							players[i].progressbar_capture2.y = 70;
						else
							players[i].progressbar_capture2.y = 104;

						players[i].progressbar_capture2.alignX = "left";
						players[i].progressbar_capture2.alignY = "middle";
						players[i].progressbar_capture2.horzAlign = "center_safearea";
						players[i].progressbar_capture2.vertAlign = "center_safearea";
						players[i].progressbar_capture2.color = (0.58,0.09,0.09);
					}

					players[i].progressbar_capture2 setShader("white", holdtime_axis, level.progressBarHeight - 4);

					if(!isdefined(players[i].progressbar_capture3))
					{
						players[i].progressbar_capture3 = newClientHudElem(players[i]);
						players[i].progressbar_capture3.x = 0;

						if(level.splitscreen)
							players[i].progressbar_capture3.y = 16;
						else
							players[i].progressbar_capture3.y = 50;

						players[i].progressbar_capture3.alignX = "center";
						players[i].progressbar_capture3.alignY = "middle";
						players[i].progressbar_capture3.horzAlign = "center_safearea";
						players[i].progressbar_capture3.vertAlign = "center_safearea";
						players[i].progressbar_capture3.archived = false;
						players[i].progressbar_capture3.font = "default";
						players[i].progressbar_capture3.fontscale = 2;
						players[i].progressbar_capture3 settext(&"MP_DESTROYING_HQ");
					}
				}	
				else
				{
					if(!isDefined(players[i].inhqrange))
					{
						if(isdefined(players[i].progressbar_capture))
							players[i].progressbar_capture destroy();
						if(isdefined(players[i].progressbar_capture2))
							players[i].progressbar_capture2 destroy();
						if(isdefined(players[i].progressbar_capture3))
							players[i].progressbar_capture3 destroy();
					}

					players[i].inhqrange = undefined;
				}
			}
			else
			{
				if(!isDefined(players[i].inhqrange))
				{
					if(isdefined(players[i].progressbar_capture))
						players[i].progressbar_capture destroy();
					if(isdefined(players[i].progressbar_capture2))
						players[i].progressbar_capture2 destroy();
					if(isdefined(players[i].progressbar_capture3))
						players[i].progressbar_capture3 destroy();
				}

				players[i].inhqrange = undefined;
			}
		}

		if(!isDefined(level.cmdradiodelayed) && !isDefined(radio.planted))
		{
			if(allies == 0)
				holdtime_allies = int(.667 + (holdtime_allies - 1));
			else
			{		
				holdtime_allies = int(.667 + (holdtime_allies + (allies * 1)));

				if(holdtime_allies >= (level.progressBarWidth - 4))
				{
					level.cmdradiodelayed = true;
					level cmd_radio_capture(radio, id);
					holdtime_allies = 0;
				}
			}
		}
	
		if(isDefined(radio.planted))
		{
			if(axis == 0)
				holdtime_axis = int(.667 + (holdtime_axis - 1));
			else
				holdtime_axis = int(.667 + (holdtime_axis + (axis * 1)));

			if(holdtime_axis < 0)
				holdtime_axis = 0;

			if(holdtime_axis >= (level.progressBarWidth - 4))
			{
				level notify("cmd_hq_destroy");
				playFX(level._effect["radioexplosion"], radio.origin);
				radio playsound("explo_plant_no_tick");
				radio hide();
				radio.planted = undefined;
				holdtime_axis = 0;

				thread DelayNewHQ(30);
			}
		}

		wait(0.05);
	}	
}

cmd_radio_capture(radio, id)
{
	level endon("cleanUP_endmap");
	level endon("intermission");

	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++)
	{
		playerisbounty = isCommander(players[i]);

		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies" && players[i].sessionstate == "playing" && playerisbounty)
		{
			if(isdefined(players[i].progressbar_capture))
				players[i].progressbar_capture destroy();
			if(isdefined(players[i].progressbar_capture2))
				players[i].progressbar_capture2 destroy();
			if(isdefined(players[i].progressbar_capture3))
				players[i].progressbar_capture3 destroy();

			players[i] thread DestroyCmdObjPoint();			

			players[i] iprintlnbold("You set up the commander HQ^4.");
			wait(0.25);
			players[i] iprintlnbold("Protect the HQ^4!");
		}

		if(players[i].pers["team"] == "allies")
			players[i] iprintln("^7The commander set up a HQ^4. ^7Protect it^4!");
		else if(players[i].pers["team"] == "axis")
			players[i] iprintln("^7The commander set up a HQ^4. ^7Destroy it^4!");
	}

	radio show();
	radio.planted = true;

	level thread cmd_radio_holding(radio);

}

cmd_radio_holding(radio)
{
	level endon("cmd_hq_destroy");
	level endon("cleanUP_endmap");
	level endon("intermission");

	if(getcvar("zn_cmd_hqtime") == "")
		setCvar("zn_cmd_hqtime", "5");

	time = 60*getcvarint("zn_cmd_hqtime");

	if(time < 10)
		time = 10;

	wait(time);

	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++)
	{
		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies" && players[i].sessionstate == "playing")
		{
			if(((distance(players[i].origin,radio.origin)) <= 120) && (distance((0,0,players[i].origin[2]),(0,0,radio.origin[2])) <= 72))
			{
				players[i] GiveStartAmmo( players[i].pers["weapon"] );
				players[i] iprintlnbold("You earned ammo for protecting the commander HQ^4!");
			}

			players[i] iprintln("The commander HQ has been successful protected^4!");
		}

		wait(0.001);
	}

	radio hide();
	radio.planted = undefined;

	thread DelayNewHQ(180);
}

DelayNewHQ(time)
{
	level endon("cleanUP_endmap");
	level endon("intermission");

	wait(time);
	level.cmdradiodelayed = undefined;
}

addObjpoint(origin, name, material)
{	
	objpoint = spawnstruct();
	objpoint.name = name;
	objpoint.x = origin[0];
	objpoint.y = origin[1];
	objpoint.z = origin[2];
	objpoint.archived = false;

	if(isdefined(material))
		objpoint.material = material;
	else
		objpoint.material = "objpoint_default";
					
	newobjpoint = newClientHudElem(self);
	newobjpoint.name = objpoint.name;
	newobjpoint.x = objpoint.x;
	newobjpoint.y = objpoint.y;
	newobjpoint.z = objpoint.z;
	newobjpoint.alpha = .61;
	newobjpoint.archived = objpoint.archived;
	newobjpoint setShader(objpoint.material, level.objpoint_scale, level.objpoint_scale);
	newobjpoint setwaypoint(true);

	if(name == 1)
		self.cmdobjpoint = newobjpoint;
	else if(name == 2)
		self.cmdobjpoint2 = newobjpoint;
}

DestroyCmdObjPoint()
{
	if(isdefined(self.cmdobjpoint)) 
		self.cmdobjpoint Destroy();

	if(isdefined(self.cmdobjpoint2)) 
		self.cmdobjpoint2 Destroy();
}