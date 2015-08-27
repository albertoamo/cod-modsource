Init() // this doesn't get loaded (check quickmessages)
{
	Precache();
}

Precache()//Too many precached things here..lol
{	
      precacheHeadIcon("talkingicon");
      precacheModel("xmodel/infected_mine");
      precacheModel("xmodel/sas_pluxy_hunter");
      precacheModel("xmodel/zombie_pluxy_infected");
      precacheModel("xmodel/tag_origin");
      precacheModel("xmodel/crate01");
      precacheModel("xmodel/prop_bear_detail_sitting");
      precacheModel("xmodel/health_large"); 
      precacheModel("xmodel/health_medium");
      precacheModel("xmodel/grasstuftgroup_test");
      precacheModel("xmodel/prop_tombstone1");
      precacheModel("xmodel/prop_tombstone2");
      precacheModel("xmodel/prop_tombstone3");
      precacheModel("xmodel/prop_tombstone4");
      precacheModel("xmodel/prop_tombstone5");
      precacheModel("xmodel/zombiex_box");
      precacheModel("xmodel/zombiexbox_lid");
      precacheModel("xmodel/bubble1");
      precacheModel("xmodel/rpd_w");
      precacheModel("xmodel/ak47_w");
      precacheModel("xmodel/winchester_model");
      precacheModel("xmodel/viewmodel_sig");
      precacheModel("xmodel/viewmodel_barret");
      precacheShader("cross_third");
      precacheShader("box_icon");
      precacheShader("medpack_hicon");
      precacheShader("nvg");  
      precacheShader("nvision");  
      precacheShader("nboz");
      precacheShader("zomevision");
      precacheString(&"^3Mine Planted");
      precacheString(&"Press[USE]to purchase the magic box(^3950 - XP^1)"); 
      precacheshellshock("default");
      precacheitem("rpd_mp");

     game["flashlight"]["light"]= loadfx("fx/misc/flashlight.efx");
     game["mineEffect"]["explode"]	= loadfx("fx/explosions/default_explosion.efx");
     game["splats"]["zom"]= loadfx("fx/misc/splats.efx");
     game["respawn"]["light2"]= loadfx("fx/misc/respawn_effect2.efx");
     game["acid"]["effect"]= loadfx("fx/misc/acid_effect.efx");
     game["vomit"]["effect"]= loadfx("fx/misc/vomit.efx");
     game["flashlight"]["light"]= loadfx("fx/misc/flashlight.efx");
    game["zom"]["explode"]= loadfx("fx/misc/zom_explode.efx");
     game["bubble"]["create"]= loadfx("fx/misc/bubble_create.efx");
     game["bubble"]["hit"]= loadfx("fx/misc/bubble_hit.efx");

     game["chose_medpack"] = "chose_medpack";
     precacheMenu(game["chose_medpack"]);
}

getLookAtPlayer()
{
	startOrigin = self getEye() + (0,0,20);
	forward = anglesToForward(self getplayerangles());
	forward = maps\mp\_utility::vectorScale(forward, 100000);
	endOrigin = startOrigin + forward;

	trace = BulletTrace( startOrigin, endOrigin, true, self );

	player = undefined;
	
	if(isDefined(trace["entity"]) && isPlayer(trace["entity"]))
	{
		player = trace["entity"];
	}

	return player;
}

SayOtherPlayerRank()
{
	player = self getLookAtPlayer();

	if(!isDefined(player))
		self iprintlnbold(&"ZMESSAGES_NOTLOOKINGAT");
	else
		self iprintlnbold(player.name + "^7 is rank ^1" + player.rank); 
}

GivePowerAwayCmd(response)
{
	self endon("disconnect");

	player = undefined;
	power = int(response);

	if(power <= 0)
		return;	

	player = self getLookAtPlayer();

	if(!isDefined(player))
	{
		player = self maps\mp\gametypes\_quickadmins::AdminHud(false);

		while(self meleeButtonPressed() || self usebuttonpressed())
			wait(0.05);
	}

	if(isPlayer(player))
	{
		self iprintlnbold("^7Give ^1" + power + " ^7Power Away To " + player.name);
		self iprintlnbold(&"ZMESSAGES_GIVEPOWERCMDCONFIRM");

		transferred = false;

		while(isAlive(self) && isAlive(player))
		{
			if(self meleeButtonPressed())
				break;
			else if(self usebuttonpressed())
			{
				transferred = true;
				PowerTransfer(self, player, power);
				break;
			}

			wait(0.09);
		}

		if(!transferred)
			self iprintlnbold(&"ZMESSAGES_GIVEPOWERCMDSTOP");		
	}
}

GivePowerAway()
{
	if(isDefined(self) && isDefined(self.givepoweraway)) return;

	self endon("disconnect");

	lookingat = false;
	player = undefined;
	power = 100;

	wait(0.001);

	player = self getLookAtPlayer();

	if(!isDefined(player))
		self iprintlnbold(&"ZMESSAGES_NOTLOOKINGAT");
	else
	{	
       		self.givepoweraway = newClientHudElem(self);
		self.givepoweraway.horzAlign = "center";
		self.givepoweraway.vertAlign = "middle";
		self.givepoweraway.x = -140;
		self.givepoweraway.y = -60;
		self.givepoweraway.fontScale = 1;
		self.givepoweraway.alpha = 1;
		self.givepoweraway setText(&"^1MELEE ^7to add more power ^4| ^1ATTACK ^7to cancel ^4| ^1F ^7to confirm");

		length = digit_length(power);

       		self.givepoweraway2 = newClientHudElem(self);
		self.givepoweraway2.horzAlign = "center";
		self.givepoweraway2.vertAlign = "middle";
		self.givepoweraway2.x = -54 - (length * 3) - int(2.5 * player.name.size);
		self.givepoweraway2.y = -40;
		self.givepoweraway2.fontScale = 1;
		self.givepoweraway2.alpha = 1;
		self.givepoweraway2.label = (&"^7Give ^1");
		self.givepoweraway2 SetValue(power);

       		self.givepoweraway3 = newClientHudElem(self);
		self.givepoweraway3.horzAlign = "center";
		self.givepoweraway3.vertAlign = "middle";
		self.givepoweraway3.fontScale = 1;
		self.givepoweraway3.alpha = 1;
		self.givepoweraway3.label = (&"^7Power Away To ");
		self.givepoweraway3 SetPlayerNameString(player);
		self.givepoweraway3.x = -30 + (length * 3) - int(2.5 * player.name.size);
		self.givepoweraway3.y = -40;

		while(isAlive(self) && isAlive(player))
		{
			if(self meleeButtonPressed() && self attackButtonPressed())
			{
				player2 = self getLookAtPlayer();

				if(isDefined(player2))
					player = player2;

				if(isDefined(self.givepoweraway2)) self.givepoweraway2.x = -54 - (length * 3) - int(2.5 * player.name.size);
				if(isDefined(self.givepoweraway3)) self.givepoweraway3 SetPlayerNameString(player);
				if(isDefined(self.givepoweraway3)) self.givepoweraway3.x = -30 + (length * 3) - int(2.5 * player.name.size);
			}
			else
			{
				if(self meleeButtonPressed())
				{
					power += 100;
					length = digit_length(power);
					if(isDefined(self.givepoweraway3)) self.givepoweraway3.x = -30 + (length * 3) - int(2.5 * player.name.size);
					if(isDefined(self.givepoweraway2)) self.givepoweraway2 SetValue(power);
				}
				else if(self usebuttonpressed())
				{
					PowerTransfer(self, player, power);
					break;
				}

				if(self attackButtonPressed())
				{
					break;
				}
			}

			if(isDefined(self.givepoweraway2)) self.givepoweraway2.x = -54 - (length * 3) - int(2.5 * player.name.size);
			if(isDefined(self.givepoweraway3)) self.givepoweraway3.x = -30 + (length * 3) - int(2.5 * player.name.size);

			wait(0.09);
		}

		if(isDefined(self.givepoweraway3)) self.givepoweraway3 Destroy();
		if(isDefined(self.givepoweraway2)) self.givepoweraway2 Destroy();
		if(isDefined(self.givepoweraway)) self.givepoweraway Destroy();
	}
}

PowerTransfer(from, to, power)
{
	if(self.power < power)
		self iprintlnbold(&"ZMESSAGES_NOTENOUGHPOWER");

	if(from.power < power || !isAlive(from) || !isAlive(to))
		return;

	if(power > 10000 && from.rank < 25) {
		self iprintlnbold("^1You Cannot Transfer More Than 10000 Below Rank 25!!!");
		return;
	}

	if(power > 100000 && from.rank < 50) {
		self iprintlnbold("^1You Cannot Transfer More Than 100000 Below Rank 50!!!");
		return;
	}

	if(power > 1000000 && from.rank < 100) {
		self iprintlnbold("^1You Cannot Transfer More Than 1000000 Below Rank 100!!!");
		return;
	}

	if(isDefined(from.isbanned) && from.isbanned) {
		self iprintlnbold("^1BANNED ACCOUNT CANNOT TRANSFER POWER");
		return;
	}

	from thread maps\mp\gametypes\_basic::updatePower(power * -1);
	to thread maps\mp\gametypes\_basic::updatePower(power);

	from iprintlnbold("You gave ^1" + power + "^7 power to " + to.name);
	to iprintln("You received ^1" + power + "^7 power from " + from.name);
	logPrint("PT;" + from.pers["guid"] + ";" + from.name + ";" + to.pers["guid"] + ";" + to.name + ";" + power + "\n");
}

Thirdperson()
{
	if(!isdefined(self.thirdperson))
	{
		self.thirdperson = false;
	}

	if(self.thirdperson)
     	{
		self.thirdperson = false;
		self setclientcvar("cg_thirdperson", 0);
		if(isdefined(self.thud))
			self.thud destroy();  
	}
	else
	{
		self.thirdperson = true;
		self setclientcvar("cg_thirdperson", 1);
            	self.thud = newClientHudElem(self);	
            	self.thud.x = 320;
		self.thud.y = 240;
		self.thud.alignX = "center";
		self.thud.alignY = "middle";
		self.thud.sort = 10;
		self.thud.alpha = 1;
		self.thud setShader("cross_third", 20, 20);
      	}
}

Plantmine()
{
	if(self.sessionstate == "dead" && self.pers["team"] == "allies")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't plant mines!!! ");
		return;
	}

	if(level.zn_enable_bots == "1")
	{
		self iprintlnbold(&"ZMESSAGES_FUNCTIONDISABLED");
		return;
	}

	minetooclose = isTooCloseToSpawn();

	if((self.pers["team"] == "allies") && (self.mine >= 1) && (self.minenum > 1) && !isDefined(minetooclose))
        {
        	self.spentmine+=1;
           	self.minenum = self.minenum - 1;
           	self thread MinePlanted();
		self.mine = self.mine - 1;
		self notify("update_minehud_value");
        	self thread Mine();
        	maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_YOUPLANTEDMINE", self, self);
         	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_PLANTEDMINE", self);
        }
        else if(self.mine <= 0)
         	self iprintlnbold(&"ZMESSAGES_NOMINESLEFT");
	else if(self.minenum == 1)
		self iprintlnbold(&"ZMESSAGES_ALREADYPLANTEDMINE");
	else if(isDefined(minetooclose))
		self iprintlnbold(&"ZMESSAGES_TOOCLOSETOSPAWN");
        else 
        	self iprintlnbold(&"ZMESSAGES_CANTPLANTMINEYET");
}

isTooCloseToSpawn()
{
	trace = bullettrace(self.origin, self.origin + (0,0,-10000), false, self);

	spawnpointname = "mp_tdm_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	for (j = 0; j < spawnpoints.size; j++)
	{
		if(distance(spawnpoints[j].origin, trace["position"]) <= 20)
		{
			return true;
		}	
	}

	spawnpoints = getentarray("enter", "targetname");

	if(spawnpoints.size > 0)
	{
		for (j = 0; j < spawnpoints.size; j++)
		{
			end = getent(spawnpoints[j].target, "targetname");
			tele = bullettrace(end.origin, end.origin + (0,0,-10000), false, self);
			
			if(distance(tele["position"], trace["position"]) <= 20)
			{
				return true;
			}	
		}
	}

	spawnpoints = getentarray("teleporter", "targetname");

	if(spawnpoints.size > 0)
	{
		for (j = 0; j < spawnpoints.size; j++)
		{
			end = getent(spawnpoints[j].target, "targetname");
			tele = bullettrace(end.origin, end.origin + (0,0,-10000), false, self);
			
			if(distance(tele["position"], trace["position"]) <= 20)
			{
				return true;
			}	
		}
	}

	return undefined;
}

MinePlanted()
{
	if((isdefined(self.minenum)) && (self.minenum == 1))
	{
       		self.minesplanted = newClientHudElem(self);
		self.minesplanted.x = -170;
		self.minesplanted.y = 375;
		self.minesplanted.alignX = "left";
		self.minesplanted.alignY = "top";
		self.minesplanted.horzAlign = "right";
		self.minesplanted.fontScale = 0.8;
		self.minesplanted.alpha = 1;
		self.minesplanted.archived = true;
		self.minesplanted setText(&"^3Mine Planted");
      	}
}

Mine()
{
	mine = spawn( "script_model", self.origin + (0,0,43));
	mine setmodel("xmodel/infected_mine");
	mine playsound("explo_plant_rand");
	angles = self GetAnglesTrace();
	trace = bullettrace(self.origin, self.origin + (0,0,-10000), false, self);
	mineplace = trace["position"];
	mine.angles = angles.angles;
	mine.targetname = "mine";
	mine.owner = self;
	mine moveto(mineplace + (0,0,1),0.2);
	mine waittill("movedone");
 
	mineactive = true;
	radiustrigmine = spawn( "trigger_radius", mine.origin - (12,0,0), 10, 15, 50);
	mine.radiustrig = radiustrigmine;
	mineactive = true;

	if(isDefined(trace["entity"]) && trace["entity"].classname == "script_brushmodel" && isDefined(trace["entity"].targetname))
	{
		radiustrigmine enableLinkTo();
		radiustrigmine linkto(mine);	
		mine linkto(trace["entity"]);
		mine.islinked = true;
	}
	
	mine endon("minekilled");
	self endon("killed_player");

	self thread MineonKilled(mine, radiustrigmine);

	while(mineactive)
	{
		radiustrigmine waittill("trigger",player);

  		if(player.pers["team"] == "axis" && !isDefined(player.choosingspawn)) 
  		{
			player.isonmine = true;
   			if(isDefined(mine)) mine playsound("player_out_of_ammo");
  			wait(0.01);
   			if(isDefined(mine)) mine moveZ(40, .3);
   			wait(0.2);

			if(isDefined(mine)) 
			{
				mine thread MineDamage(100, 1500, player);
				mine playsound("explo_metal_rand");
				playfx(game["mineEffect"]["explode"], mine.origin);
				earthquake(0.5,1.4,mine.origin,600);
				wait(0.1);
				mine setmodel("xmodel/tag_origin");
			}

			mineactive = false;
			if(isPlayer(player)) player.isonmine = undefined;
 		}
	}

	RemoveMine(self, mine, radiustrigmine);
}

MineDamage(maxdist, maxdmg, p)
{
	players = getentarray("player", "classname");

	if(isPlayer(p))
		p thread [[level.callbackPlayerDamage]](self, self.owner, int(maxdmg/3), 0, "MOD_GRENADE_SPLASH", "mine_mp", self.origin, vectornormalize(p.origin + (0,0,20) - self.origin), "none", 0);  

	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(!isPlayer(player) || !isAlive(player) || !isDefined(player.pers["team"]) || player.pers["team"] != "axis")
			continue;

		if(player.pers["team"] == "axis")
		{
			dist = distance(self.origin, player.origin);
	
			if(dist <= maxdist)
			{
				dmg = (maxdist - dist) / maxdist * maxdmg;
			
				if(dmg < 5)
					dmg = 5;

				dmg = int(dmg);  

				player thread [[level.callbackPlayerDamage]](self, self.owner, dmg, 0, "MOD_GRENADE_SPLASH", "mine_mp", self.origin, vectornormalize(player.origin + (0,0,20) - self.origin), "none", 0);                      
                	}
		}
	}    
}

MineonKilled(mine, radiustrigmine)
{
	self endon("mine_cleanup");
	self waittill("killed_player");	
	RemoveMine(self, mine, radiustrigmine);
}

Medpack()
{
	 if(self.medpack >= 1)
         {
		if(!isDefined(self.delayusemedpack))
		{
			self.delayusemedpack = true;
         		self thread regainHealth();
		}
         }
         else
         	self iprintlnbold(&"ZMESSAGES_NOHEALTHPACKS");

}

regainHealth()
{
	self endon("disconnect");
	regainhealth = 35;
	maxhealthaxis = 425;
	//maxhealthallies = 100;
	maxhealthallies = self.maxhealth;

	if( (self.health >= maxhealthaxis && self.pers["team"] == "axis") || (self.health >= maxhealthallies && self.pers["team"] == "allies"))
	{
		self.delayusemedpack = undefined;
   		return;
	}
		
	self.spentmedpack+= 1;
	self.medpack-= 1;
	self notify("update_medpackhud_value");
	self.health+= regainhealth;
     	self playsound("medpack_use");

	if(self.pers["team"] == "axis")
	{
		if(self.health >= maxhealthaxis)
   		{
			self.health = maxhealthaxis;
			self iprintlnbold(&"ZMESSAGES_REACHEDMAXHEALTH");
   		}
	}
	if(self.pers["team"] == "allies")
	{
		if(self.health >= maxhealthallies)
   		{
			self.health = maxhealthallies;
			self iprintlnbold(&"ZMESSAGES_REACHEDMAXHEALTH");
   		}
	}

	self notify("update_healthbar");
	wait(0.25);
	self.delayusemedpack = undefined;
}


Nightvision()
{
	if(!isdefined(self.nightvision))
	{
		self.nightvision = false;
	}

	if(self.nightvision)
     	{
	    self.nightvision = false;
            self setclientcvar("r_lightmap", 0);
	    self setclientcvar("r_fog", 1);
            self playsound("nvg_on");
            if(isdefined(self.nboz))
            self.nboz destroy();
            if(isdefined(self.ngreen))
            self.ngreen destroy();
            if(isdefined(self.nvision))
            self.nvision destroy();
            
          
	}
	else
	{
	   self.nightvision = true;
           self setclientcvar("r_lightmap", 1);
	   self setclientcvar("r_fog", 0);
           self thread NightvisionHuds();
           self playsound("nvg_on");
      	}
}

NightvisionHuds()
{
	self endon("DestroyAllCHuds");

	self.ngreen = newClientHudElem(self);	
	self.ngreen.alignX = "center";
	self.ngreen.alignY = "middle";
	self.ngreen.horzAlign = "fullscreen";
	self.ngreen.vertAlign = "fullscreen";
	self.ngreen.x = 320;
	self.ngreen.y = 240;
	self.ngreen.sort = 1; 
	self.ngreen.alpha = 2;
	self.ngreen setShader("nboz", 756, 756);

	self.nvision = newClientHudElem(self);	
	self.nvision.alignX = "center";
	self.nvision.alignY = "middle";
	self.nvision.horzAlign = "fullscreen";
	self.nvision.vertAlign = "fullscreen";
	self.nvision.x = 320;
	self.nvision.y = 240;
	self.nvision.sort = 10; 
	self.nvision.alpha = 0.3;
	self.nvision setShader("nvision", 756, 756);

	self.nboz = newClientHudElem(self);	
	self.nboz.alignX = "center";
	self.nboz.alignY = "middle";
	self.nboz.horzAlign = "fullscreen";
	self.nboz.vertAlign = "fullscreen";
	self.nboz.x = 320;
	self.nboz.y = 240;
	self.nboz.sort = 10; 
	self.nboz.alpha = 0.6;
	self.nboz setShader("nvg", 756, 756);

	while(isDefined(self.nightvision) && self.nightvision == true)
	{
		if(isDefined(self.nvision)) self.nvision fadeOverTime(1);
		if(isDefined(self.nvision)) self.nvision.alpha = 0.75;
		wait 0.1;
		if(isDefined(self.nvision)) self.nvision fadeOverTime(1);
		if(isDefined(self.nvision)) self.nvision.alpha = 0;
		wait 0.1;
		if(isDefined(self.nvision)) self.nvision fadeOverTime(1);
		if(isDefined(self.nvision)) self.nvision.alpha = 0.75;
		wait 12;
		if(isDefined(self.nvision)) self.nvision fadeOverTime(1);
		if(isDefined(self.nvision)) self.nvision.alpha = 0;
		wait 0.1;
		if(isDefined(self.nvision)) self.nvision fadeOverTime(1);
		if(isDefined(self.nvision)) self.nvision.alpha = 0.75;
		wait 12;
		if(isDefined(self.nvision)) self.nvision fadeOverTime(1);
		if(isDefined(self.nvision)) self.nvision.alpha = 0;
		wait 0.1;
       }
}

GuillieZom()
{
	if(self.sessionstate == "dead" && self.pers["team"] == "axis")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't dress like a zombie!!! ");
		return;
	}

	if(isDefined(self.delayguillieonzombie))
	{
		self iprintlnbold(&"ZMESSAGES_ALREADYDRESSEDASHUNTER");
		return;
	}

	price = maps\mp\gametypes\_basic::GetActionPrices();

	if(self.pers["team"] == "axis" && self.power >= price["guillie"])
	{
		self.delayguillieonzombie = true;
		self thread GuillieOnZom(price["guillie"]);
	}
	else if(self.pers["team"] == "axis" && self.power < price["guillie"])  
	{ 
		self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");

	}
}

Guillie()
{
	if(self.sessionstate == "dead" && self.pers["team"] == "allies")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't dress like a zombie!!! ");
		return;
	}

	if(isDefined(self.delayguillieonhunter))
	{
		self iprintlnbold(&"ZMESSAGES_ALREADYDRESSEDASZOMBIE");
		return;
	}

	price = maps\mp\gametypes\_basic::GetActionPrices();

	if(self.pers["team"] == "allies" && self.power >= price["guillie"])
	{
		self.delayguillieonhunter = true;
		self thread GuillieOn(price["guillie"]);
	}
	else if(self.pers["team"] == "allies" && self.power < price["guillie"])  
	{ 
		self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");

	}
}

GuillieOn(price)
{
	self endon("killed_player");
	self thread CleanGuillieOnKilled();

	if(self.pers["team"] == "allies") 
	{
		self maps\mp\gametypes\_quickmessages::saveHeadIcon();
		self iprintlnbold(&"ZMESSAGES_DRESSING");
		wait 2;
		self thread maps\mp\gametypes\_basic::updatePower(price * -1);

		if(getcvar("zn_zom_dresstime") == "")
			setCvar("zn_zom_dresstime", "15");

		dresstime = GetCvarInt("zn_zom_dresstime");

		self iprintlnbold(&"ZMESSAGES_DRESSEDASZOMBIE");
		self iprintlnbold(&"ZMESSAGES_DRESSEDTIME", dresstime);
		maps\mp\gametypes\_util::iprintlnFIXED( &"ZMESSAGES_USINGGUILLIE", self);
		self detachall();
		[[game["axis_model"] ]]();
		self.sessionteam = "axis";
		self.headicon = game["headicon_axis"];
		self.headiconteam = "axis";
	
		self.dresstext = newClientHudElem(self);
		self.dresstext.x = 522;
		self.dresstext.y = 160;
		self.dresstext.alignX = "left";
		self.dresstext.alignY = "top";
		self.dresstext.fontScale = 0.8;
		self.dresstext.alpha = 1;
		self.dresstext.archived = true;
		self.dresstext.label = (&"Time dressed left: ");
		self.dresstext setValue(dresstime);

		time = dresstime;

		self.dresstext thread UpdateDressTime(dresstime, self);

		wait time;
		self detachall();
		[[game["allies_model"] ]]();
		self.headicon = game["headicon_allies"];
		self.sessionteam = "allies";
		self maps\mp\gametypes\_quickmessages::restoreHeadIcon();
		if(isDefined(self.dresstext)) self.dresstext destroy();
		self.delayguillieonhunter = undefined;
		self notify("Guillie_Ended");
      }        
}

CleanGuillieOnKilled()
{
	self endon("Guillie_Ended");
	self waittill("killed_player");
	if(isDefined(self.dresstext)) self.dresstext destroy();
	self.delayguillieonhunter = undefined;
}

GuillieOnZom(price)
{
	self endon("killed_player");
	self thread CleanGuillieOnKilledZom();

	if(self.pers["team"] == "axis") 
	{
		self iprintlnbold(&"ZMESSAGES_DRESSING");
		wait 2;

		self thread maps\mp\gametypes\_basic::updatePower(price * -1);

		if(getcvar("zn_zom_dresstime") == "")
			setCvar("zn_zom_dresstime", "15");

		dresstime = GetCvarInt("zn_zom_dresstime");

		self iprintlnbold(&"ZMESSAGES_DRESSEDASHUNTER");
		self iprintlnbold(&"ZMESSAGES_DRESSEDTIME", dresstime);
		maps\mp\gametypes\_util::iprintlnFIXED( &"ZMESSAGES_USINGZOMGUILLIE", self);
		//self PlaySound("");
		self detachall();
		[[game["allies_model"] ]]();
	
		self.dresstext = newClientHudElem(self);
		self.dresstext.x = 522;
		self.dresstext.y = 160;
		self.dresstext.alignX = "left";
		self.dresstext.alignY = "top";
		self.dresstext.fontScale = 0.8;
		self.dresstext.alpha = 1;
		self.dresstext.archived = true;
		self.dresstext.label = (&"Time dressed left: ");
		self.dresstext setValue(dresstime);

		time = dresstime;

		self.dresstext thread UpdateDressTime(dresstime, self);

		wait time;
		self detachall();
		[[game["axis_model"] ]]();
		if(isDefined(self.dresstext)) self.dresstext destroy();
		self.delayguillieonzombie = undefined;
		self notify("Guillie_Ended");
      }        
}

CleanGuillieOnKilledZom()
{
	self endon("Guillie_Ended");
	self waittill("killed_player");
	if(isDefined(self.dresstext)) self.dresstext destroy();
	self.delayguillieonzombie = undefined;
}

UpdateDressTime(dresstime, player)
{
	while(isDefined(self) && isAlive(player))
	{
		wait(1);
		dresstime--;
		if(isDefined(self)) self setValue(dresstime);
	}

	dresstime = undefined;
}

PlantDrone()
{
   	if(self.sessionstate == "dead" && self.pers["team"] == "allies")
   	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't plant a drone!!! ");
		return;
	}

	price = maps\mp\gametypes\_basic::GetActionPrices();

	if(self.pers["team"] == "allies" && self.power >= price["defencegun"])
	{
		if(isDefined(self.delaydroneonhunter)) return;

		angles = self GetAnglesTrace();
		if(angles.angles == (0,0,0))
		{
			self.delaydroneonhunter = true;
			self thread DroneOn();
			self thread maps\mp\gametypes\_basic::updatePower(price["defencegun"] * -1);
		}
		else
		{
			self iprintlnbold(&"ZMESSAGES_DRONEBADGROUND");
		}
	}
	else if(self.pers["team"] == "allies" && self.power < price["defencegun"])
	{ 
		self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");
	}
}

DroneOn()
{
	trace = bullettrace(self.origin, self.origin + (0,0,-10000), false, self);

	angles = self GetAnglesTrace();

	dronebase = spawn("script_model", trace["position"] + (0,0,0));
	dronebase setModel("xmodel/turretbase");
	dronebase.angles = angles.angles;

	direction = anglesToForward(angles.angles + (0,90,0));
	backwards = maps\mp\_utility::vectorScale( vectorNormalize(direction), 0 );

	dronemain = spawn("script_model", trace["position"] + (0,0,5) + backwards);
	dronemain setModel("xmodel/turretmain");
	dronemain.angles = angles.angles;

	forward = maps\mp\_utility::vectorScale( vectorNormalize(direction), 11.5 );

	dright = AnglesToRight(angles.angles + (0,90,0));
	right = maps\mp\_utility::vectorScale( vectorNormalize(dright), -4.0 );

	dronegun = spawn("script_model", trace["position"] + (0,0,17.5) + forward + right);
	dronegun setModel("xmodel/turretcannon");
	dronegun.angles = angles.angles;

	dright = AnglesToRight(angles.angles + (0,90,0));
	right = maps\mp\_utility::vectorScale( vectorNormalize(dright), 4.8 );

	dronegun2 = spawn("script_model", trace["position"] + (0,0,17.5) + forward + right);
	dronegun2 setModel("xmodel/turretcannon");
	dronegun2.angles = angles.angles;
	
	wait(0.5);
	
	active = true;
	player = undefined;
	tracepeople = true;
	dronemain.shotdmg = 50;
	dronemain.shots = 160;
	dronemain.dronegunendonendmap = undefined;
	dronemain.maxdmgondronegun = undefined;
	dronemain.ondronekilled = undefined;

	dronemain thread DamageDroneGunOnBash(dronemain);
	dronemain thread EndOnEndMap();
	dronemain thread DroneOnKilled(self);

	while(isDefined(active) && isDefined(self))
	{
		if(isDefined(dronemain.maxdmgondronegun))
		{
			if(self.pers["team"] == "allies") self iprintlnbold(&"ZMESSAGES_DRONEDESTROYED");
			active = undefined;
		}

		if(isDefined(dronemain.ondronekilled))
			active = undefined;

		players = getentarray("player", "classname");

		for(i=0;i<players.size;i++)
		{
			if(!isPlayer(players[i]) || !isDefined(players[i].pers["team"]))
				continue;

			if(isPlayer(players[i]) && players[i].pers["team"] != "axis")
				continue;

			if(isPlayer(players[i]) && isDefined(players[i].delayguillieonzombie))
				continue;

			trace = bullettrace(dronemain.origin + (0,0,18), (players[i].origin[0], players[i].origin[1], dronemain.origin[2]) + (0,0,18), tracepeople, dronemain);

			if(isPlayer(trace["entity"]))
			{
				player = trace["entity"];
				
				if(player.pers["team"] == "axis" && !isDefined(player.choosingspawn))
				{
					keepshooting = true;
				
					while(isAlive(players[i]) && isDefined(active) && Distance(dronegun.origin, players[i].origin) < 2000 && isDefined(keepshooting))
					{
						keepshooting = DroneGunMainFirePart(dronegun, dronegun2, players[i], tracepeople, dronemain, undefined);

						if(isDefined(dronemain.maxdmgondronegun))
						{
							if(self.pers["team"] == "allies") self iprintlnbold("Your defence gun got destroyed by the zombies^4.");
							active = undefined;
						}
						
						if(dronemain.shots <= 0)
						{
							if(self.pers["team"] == "allies") self iprintlnbold("Your defence gun is out of ammo^4.");
							active = undefined;
						}

						if(isDefined(dronemain.dronegunendonendmap) || isDefined(dronemain.ondronekilled))
						{
							active = undefined;
						}
					}
				}
			}

			wait(0.000001);
		}

		wait(0.05);
	}

	dronemain notify("delete_dronegun");

	dronegun2 hide();
	dronegun hide();
	dronemain hide();
	dronebase hide();

	wait(0.05); // let all the scripts die

	dronegun2 delete();
	dronegun delete();
	dronemain delete();
	dronebase delete();

	if(isDefined(self)) self.delaydroneonhunter = undefined;
}

DroneGunMainFirePart(dronegun, dronegun2, player, tracepeople, dronemain, bot)
{
	angle = vectortoangles(player.origin - dronemain.origin);

	angle -= (0, 90, 0); // model correction

	if(angle[1] > dronemain.angles[1])
		movementangles = angle[1] - dronemain.angles[1];
	else
		movementangles = dronemain.angles[1] - angle[1];

	if(movementangles > 0) 
		time = movementangles/360*0.4;
	else
		time = 0.4;

	if(time <= 0)
		time = 0.4;

	dronegun notify("dronegun_stopped_firing");
	dronegun2 notify("dronegun_stopped_firing");

	dronegun linkto(dronemain);
	dronegun2 linkto(dronemain);
						
	dronemain RotateTo((dronemain.angles[0], angle[1], dronemain.angles[2]), time);
	dronemain waittill("rotatedone");

	keepshooting = true;

	if(isDefined(player))
	{
		direction = anglesToForward( dronemain.angles + (0, 90,0) );
		temp = maps\mp\_utility::vectorScale( direction, 10000000 );
		trace = bullettrace(dronemain.origin + (0,0,18), dronemain.origin + direction + temp + (0,0,18), tracepeople, dronemain);

		dronegun unlink();
		dronegun2 unlink();

		dronegun thread RotateGunsWhileFiring();
		dronegun2 thread RotateGunsWhileFiring();

		if(isPlayer(trace["entity"]) || (isDefined(bot) && isDefined(trace["entity"])))
		{
			player = trace["entity"];

			if(isPlayer(player) && player.pers["team"] == "axis" || isDefined(bot) && isDefined(player))
			{
				if(Distance( dronemain.origin, (player.origin[0],player.origin[1],dronemain.origin[2]) ) > 26)
				{
					direction = anglesToForward( dronemain.angles + (0, 90,0) );
					firePos = dronemain getOrigin();
					fireForward = trace["position"];
					dist = fireForward - firePos;

					playfx( level._effect["20mm_tracer_flash"],dronegun.origin + direction,vectorNormalize(dist) );
					playfx( level._effect["20mm_tracer_flash"],dronegun2.origin + direction,vectorNormalize(dist) );

					impactTime = ( 1.5 / 13020 );
	
					bulletTime = 4;
					fx = level._effect["20mm_wallexplode"];
					nextPos 	= trace["position"];
					distance 	= distance( firePos, nextPos );
					waitTime 	= ( impactTime * (distance ) );
								
					time = waitTime - (1 / distance);	

					if(time <= 0)
						time = 0.1;								

					wait( time );

					temp = maps\mp\_utility::vectorScale( direction, 10000000 );

					trace = bullettrace(dronegun.origin + direction, dronegun.origin + direction + temp, tracepeople, dronegun);
					playFX(fx, trace["position"]);
					thread maps\mp\gametypes\_admin::PlaySoundAtLocation("rocket_explode_flesh", trace["position"], 3);
					dronemain.shots -= 2;

					trace2 = bullettrace(dronegun2.origin + direction, dronegun2.origin + direction + temp, tracepeople, dronegun2);
					playFX(fx, trace2["position"]);
					thread maps\mp\gametypes\_admin::PlaySoundAtLocation("rocket_explode_flesh", trace2["position"], 3);

					if(isPlayer(trace["entity"]) || isPlayer(trace2["entity"]) || isDefined(bot) && isDefined(trace["entity"]))
					{
						if(isPlayer(trace["entity"]) || isDefined(bot) && isDefined(trace["entity"]))
							player = trace["entity"];
						else
							player = trace2["entity"];	

						if(isDefined(player) && isPlayer(player) && isAlive(player) && player.pers["team"] == "axis")
							player thread [[level.callbackPlayerDamage]](self, self, dronemain.shotdmg * 2, 1, "MOD_RIFLE_BULLET", "drone_mp", dronegun.origin,temp, "none",0);
						else 
							player notify("dmg", dronemain.shotdmg * 2, self, "drone_mp", trace["position"], "MOD_RIFLE_BULLET");
					}
				}
			}
		}
		else
		{
			keepshooting = undefined; // look for next target
		}
	}
	else
	{
		keepshooting = undefined; // look for next target
	}
	
	wait(0.25);

	dronegun waittill("dronegun_stopped_firing_round");
	dronegun notify("dronegun_stopped_firing");

	dronegun2 waittill("dronegun_stopped_firing_round");
	dronegun2 notify("dronegun_stopped_firing");

	return keepshooting;
}

DroneOnKilled(player)
{
	self endon("delete_dronegun");
	self.ondronekilled = undefined;

	player waittill("killed_player");

	self.ondronekilled = true;
}

RotateGunsWhileFiring()
{
	self endon("dronegun_stopped_firing");

	while(1)
	{
		self RotateTo(self.angles + (180,0,0), 0.2);
		self waittill("rotatedone");
		self notify("dronegun_stopped_firing_round");
	}	
}

DamageDroneGunOnBash(dronemain)
{
	dmg = 0;
	limit = 20;
	self.maxdmgondronegun = undefined;

	self endon("delete_dronegun");

	while(1)
	{
		players = getentarray("player", "classname");
		
		for(i=0;i<players.size;i++)
		{
			if(isDefined(dronemain))
			{
				if(isDefined(players[i]) && players[i] meleeButtonPressed() && !isDefined(players[i].dmgmeleeing) && distance(players[i].origin, dronemain.origin) < 100 && players[i].pers["team"] == "axis" && !isDefined(players[i].spawnprotected))
				{
					players[i].dmgmeleeing = true;
					dmg++;
					players[i] thread DamageDroneGunOnBashMeleeing();
				}

				if(dmg >= limit)
				{	
					self.maxdmgondronegun = true;
					playfx(level._effect["radioexplosion"], dronemain.origin);
					self notify("delete_dronegun");
				}
			}
		}

		wait(0.10);
	}
}

DamageDroneGunOnBashMeleeing()
{
	while(self meleeButtonPressed())
		wait(0.05);

	if(isDefined(self)) self.dmgmeleeing = undefined;
}

EndOnEndMap()
{
	self endon("delete_dronegun");
	level waittill("cleanUP_endmap");

	self.dronegunendonendmap = true;
}

Respawn()
{
	if(self.sessionstate == "dead" && self.pers["team"] == "allies")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't use the respawn ability!!! ");
		return;
   	}

	if(level.mapended)
	{
		return;
	}

	price = maps\mp\gametypes\_basic::GetActionPrices();

   	if(self.pers["team"] == "allies" && self.power >= price["teleport"])
   	{
		if(isDefined(self.delayrespawnonhunter)) 
		{	
			self iprintlnbold(&"ZMESSAGES_RESPAWNBUSY");
			return;
		}

      		self.delayrespawnonhunter = true;

		self thread RespawnOn();
		self thread maps\mp\gametypes\_basic::updatePower(price["teleport"] * -1);
	}
	else if(self.pers["team"] == "allies" && self.power < price["teleport"])
	{ 
		self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");
	}
}

RespawnOn()
{
	self endon("disconnect");

	if(self.pers["team"] == "allies")
	{
		self.spawnprotected = true;
		spawnpointallies = getentarray("mp_ctf_spawn_allied","classname");
		spawnpointname = "mp_tdm_spawn";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);

		if(spawnpointallies.size > 0 && (getcvar("mapname") == "mp_untoten_v2" || getcvar("mapname") == "mp_zn_hideout"))
		{
			randomall = randomint(spawnpointallies.size);
			spawnpoint = spawnpointallies[randomall];
		}

		playfx(game["respawn"]["light"], self.origin);
		wait 0.01;
		self playsound("explo_radio");
		self setorigin(spawnpoint.origin);
		self SetPlayerAngles(spawnpoint.angles);
		playfx(game["respawn"]["light2"], self.origin);
		self iprintlnbold(&"ZMESSAGES_TELEPORTED");
        	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_USEDRESPAWN", self);
		wait(1);
		self.spawnprotected = undefined;
	
		wait(30);

		self.delayrespawnonhunter = undefined;

		if(self.pers["team"] == "allies")
			self iprintln(&"ZMESSAGES_TELEPORTRECHARGED");
	}
}

Gmedpack()
{
	if(self.pers["team"] == "allies" && self.medpack >= 1)
	{
		self thread GmedOpenMenu();
		self openMenu(game["chose_medpack"]);
		//scriptMainMenu = game["chose_medpack"];
		//self setClientCvar("g_scriptMainMenu", scriptMainMenu);	

	}
	else
		self iprintlnbold(&"ZMESSAGES_NOHEALTHPACKS");
}

GmedOpenMenu()
{
	self endon("disconnect");
	self endon("killed_player");

	self waittill("menuresponse", menu, response);
	if( menu == game["chose_medpack"] && response != "close_chose_medpack")
	{
		switch(response)
		{
			case "chose_yes":        
			self iprintlnbold(&"ZMESSAGES_GIVINGAWAYMED"); 
			thread PlantingGmedpack();        
			break;

			case "chose_no":
			self iprintlnbold(&"ZMESSAGES_NOPROBLEM");                     
			break;

			default:
			break;
		}

		self closeMenu();
	}
}

PlantingGmedpack()
{
	if(!isDefined(level.gmedpack))
		level.gmedpack = [];

   	gmedpack = spawn( "script_model", self.origin + (0,0,-1));
        gmedpack setmodel("xmodel/health_large");
        trace = bullettrace(self.origin, self.origin + (0,0,-10000), true, self);
        gmedplace = trace["position"];
        gmedpack moveto(gmedplace + (0,0,0),0.2);
        self.medpack -= 1;
	self notify("update_medpackhud_value");
	gmedpack.from = self.name; // save giver's name

	nr = 0;
	number = maps\mp\gametypes\zom_svr::GetNextObjNum();
	mekplant = self GetEntityNumber(); // so that you don't pick up your own medpacks.

        wait 0.3;
        //After the medpack arrive to the floor we set the radius.
        if(number != -1) Objective_Add(number, "current", gmedpack.origin, "medpack_hicon");
	if(number != -1) Objective_Team(number, "allies" );
        gmedactive = true;
      	gradiustrigmed = spawn( "trigger_radius", gmedpack.origin, 10, 10, 35);
        //wait 5;

	while(gmedactive == true)
	{
  		gradiustrigmed waittill("trigger",player);

  		if(player.pers["team"] == "allies" && player GetEntityNumber() != mekplant)
  		{
			gmedpack playsound("health_pickup_small");
                    	player.medpack += 1;
                    	player iprintlnbold(&"ZMESSAGES_MEDRECEIVED", gmedpack.from);
                   	player SayAll("^3Thank you " + gmedpack.from);
			player notify("update_medpackhud_value");
			gmedactive = false;
                    	if(number != -1) Objective_Delete( number );
			if(number != -1) level.objused[(number)] = undefined;
			number = undefined; 
		        mekplant = undefined;
 		}
        }

	gmedpack delete();
        gradiustrigmed delete();
}

Airstrike()
{
	if(self.pers["team"] != "allies")
		return;

	price = maps\mp\gametypes\_basic::GetActionPrices();

	if(self.sessionstate == "dead" && self.pers["team"] == "allies")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't call airstrikes!! ");
		return;
	}

	if(isdefined(self.spamdelayairstrike))
		return;

	//self iprintlnbold("Airstrike costs: ^1" + price["airstrike"]);	

	self.spamdelayairstrike = true;

	if((self.pers["team"] == "allies") && (self.power >= price["airstrike"]))
        {
           	self thread maps\mp\gametypes\_airstrike::CallAirstrike();
        }
	else
         	self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");

	self.spamdelayairstrike = undefined;
}
    

Bubble()
{
	if(!isDefined(self.plantedbubbles)) self.plantedbubbles = 0;

	price = maps\mp\gametypes\_basic::GetActionPrices();

	if(self.sessionstate == "dead" && self.pers["team"] == "allies")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't deploy a defence bubble!!! ");
		return;
	}

	if(isdefined(self.spamdelaybubble))
		return;

	self.spamdelaybubble = true;

	if(self.pers["team"] == "allies" && self.power >= price["bubble"] && self.plantedbubbles < 3)
        {
		self.bubbleplantdelay = true;
           	self thread maps\mp\gametypes\_basic::updatePower(price["bubble"] * -1);
        	self thread BubbleX();
		self.plantedbubbles++;
        	maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_DEPLOYEDBUBBLE", self, self);
         	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_PLACEDBUBBLE", self);
        }
	else if((self.pers["team"] == "allies") && (self.power >= price["bubble"]) && self.plantedbubbles >= 3)
	{
		self iprintlnbold(&"ZMESSAGES_ENOUGHBUBBLES");
	}
        else
         	self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");

	self.spamdelaybubble = undefined;
}


BubbleX()
{
	bubble = spawn( "script_model", self.origin + (0,0,0));
	bubble setmodel("xmodel/bubble1");

	trace = bullettrace(self.origin, self.origin + (0,0,-10000), true, self);
	bubbleplace = trace["position"];
	bubble.targetname = "bubble";
	bubble.owner = self;
	bubble moveto(bubbleplace + (0,0,3),0.2);
	wait 0.3;
	bubble playLoopSound("bubble_loop");
	playfx(game["bubble"]["create"], bubble.origin);

	time = 15;
	range = 100;
	origin = bubbleplace + (0,0,33);

	currenttime = GetTime();
	bubble rotatepitch(3600,time);

	if(!isDefined(self.bubbletimer))
	{
		self.bubbletimer = newClientHudElem(self);
		self.bubbletimer.x = 0;
		self.bubbletimer.y = 30;
	}

 	self.bubbletimer.horzAlign = "center";
 	self.bubbletimer.vertAlign = "top";
	self.bubbletimer.alignX = "center";
	self.bubbletimer.alignY = "middle";
	self.bubbletimer.fontScale = 3;
	self.bubbletimer.color = (0,1,0);
	self.bubbletimer.alpha = 1;
	self.bubbletimer.archived = true;
	self.bubbletimer.starttime = currenttime;
	self.bubbletimer SetTenthsTimer( time );

	while(1)
	{
		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(player.pers["team"] == "axis" && Distance(origin, player.origin) <= range && !isDefined(player.bubbleblockmovement))
			{
				if(isPlayer(player) && isAlive(player)) player thread moveplayerback( self, origin );
			}
			else if(player.pers["team"] == "allies" && Distance(origin, player.origin) <= range && !isDefined(player.inbubble))
			{
				if(isPlayer(player) && isAlive(player)) player thread inBubble(origin, bubble, range);
			} 
		}

		wait(0.001);
		
		if( ( GetTime() >= currenttime + time * 1000 ) && ( getcvar("zn_debug_b") != "1" ) )
			break;
		else if( getTime() >= currenttime + time * 1000 )
			bubble rotatepitch(3600,time);

		if( GetTime() >= currenttime + 4000 )
			self.bubbleplantdelay = undefined;
	}

	bubble StopLoopSound();
	bubble hide();
	bubble delete();
	if(isDefined(self.bubbletimer) && self.bubbletimer.starttime == currenttime) self.bubbletimer Destroy();
	wait(5);
	if(isDefined(self)) self.plantedbubbles--;
}

inBubble(origin, bubble, range)
{
	self.inbubble = true;

	while(isDefined(bubble) && Distance(origin, self.origin) <= range && isAlive(self))
		wait(0.05);

	self.inbubble = undefined;	
}

moveplayerback( owner, trigger )
{
	self.bubbleblockmovement = true;
	angles = vectortoangles(self.origin - trigger);

	forward = AnglesToForward( angles );

	if(getcvar("zn_debug_b") == "1") 
	{
		self iprintlnbold(angles);
		self iprintlnbold(forward);
	}

	x = forward;

	if(self.origin[2] > (trigger[2] + 40))
	{
		x = AnglesToUp( self GetPlayerAngles() );
	}

	x = maps\mp\_utility::vectorScale(x, 100);

	bubbleDmg = 2200;
	self.health = self.health + bubbleDmg;

	if(!isPlayer(owner) || !isDefined(owner) || isPlayer(owner) && owner.pers["team"] == "axis")
		owner = self;

	if(isPlayer(self) && isDefined(self))
		self FinishPlayerDamage( owner, owner, bubbleDmg , 1, "MOD_EXPLOSIVE", "none", self.origin, x, "none", 0 );

	if(isPlayer(self) && isDefined(self))
		self.bubbleblockmovement = undefined;

	self notify("update_healthbar");
}

//From here all the Zombie Habilities

Pounce()
{
	if(self.sessionstate == "dead" && self.pers["team"] == "axis")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't pounce!!! ");
		return;
	}

	if(self.pers["team"] == "axis" && !isdefined(self.nospam))
	{    
		self.nospam = undefined;
	}

	if(self.pers["team"] == "axis" && !isDefined(self.nospam))
	{
		self iprintlnbold(&"ZMESSAGES_POUNCEMSG", 5);
		self thread Jump();
		self.nospam = true;
	}
}

Jump()
{
	self.nospam = true;

	//pouncepoint = ( self.origin + (0,0,-1) );
	pounceDmg = 2000;
	self.health = ( self.health + pounceDmg );
	
	max = 29;

	if(getCvar("mapname") == "mp_tcheadquarters")
		max = 40;

	if(getCvar("mapname") == "mp_elevation_v2")
		max = 45;

	rand = RandomIntRange( 24, max );
	jumpdir = (0,0,rand);

	//if(maps\mp\gametypes\_basic::debugModeOn(self))
	//	self iprintln(jumpdir);

	self FinishPlayerDamage( self, self, pounceDmg , 1, "MOD_EXPLOSIVE", "none", self.origin, jumpdir, "none", 0 );
	wait(0.05);
	self notify("update_healthbar");	
	wait (5);

	self.nospam = undefined;
}

ZomVision()
{
	self endon("DestroyAllCHuds");

	if(self.sessionstate == "dead" && self.pers["team"] == "axis")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't turn zomvision on!!! ");
		return;
	}

	//if(maps\mp\gametypes\_basic::debugModeOn(self))
	//	self iprintln("Start - ZomVision");

	if(!isdefined(self.zomvision))
		self.zomvision = false;

	if(self.zomvision)
     	{
		self.zomvision = false;
		self setclientcvar("r_lightmap", 0);
		self setclientcvar("r_fog", 1);
		if(isdefined(self.zvision))
			self.zvision destroy();
		if(isdefined(self.nviz))
			self.nviz destroy();

		//if(maps\mp\gametypes\_basic::debugModeOn(self))
		//	self iprintln("Off - ZomVision");        
	}
	else
	{
		self.zomvision = true;
		self setclientcvar("r_lightmap", 1);
		self setclientcvar("r_fog", 0);
		self.zvision = newClientHudElem(self);	
		self.zvision.x = 320;
		self.zvision.y = 240;
		self.zvision.alignX = "center";
		self.zvision.alignY = "middle";
		self.zvision.horzAlign = "fullscreen";
		self.zvision.vertAlign = "fullscreen";
		self.zvision.sort = 10; 
		self.zvision.alpha = 1;
		self.zvision setShader("zomevision", 640, 480);

          	self.nviz = newClientHudElem(self);	
	     	self.nviz.alignX = "center";
	     	self.nviz.alignY = "middle";
		self.nviz.horzAlign = "fullscreen";
		self.nviz.vertAlign = "fullscreen";
          	self.nviz.x = 320;
	     	self.nviz.y = 240;
	     	self.nviz.sort = 10;
          	self.nviz.color = (1,0,0); 
	     	self.nviz.alpha = 0.6;
	     	self.nviz setShader("nvg", 756, 756);

		//if(maps\mp\gametypes\_basic::debugModeOn(self))
		//	self iprintln("On - ZomVision");  

		while(isDefined(self.zomvision) && self.zomvision == true)
		{
			if(isDefined(self.zvision)) self.zvision ScaleOverTime( 4, 680, 520 );
			wait 6;
			if(isDefined(self.zvision)) self.zvision ScaleOverTime( 2, 660, 500 );
			wait 8;
			if(isDefined(self.zvision)) self.zvision ScaleOverTime( 3, 690, 530 );
			wait 6;
			if(isDefined(self.zvision)) self.zvision ScaleOverTime( 2, 660, 500 );
		}
	}
}

Explode()
{
	price = maps\mp\gametypes\_basic::GetActionPrices();

	if(self.sessionstate == "dead" && self.pers["team"] == "axis")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't explode!!! ");
		return;
	}

	if(self.pers["team"] == "axis" && self.power >= price["explode"] && !isDefined(self.spawnprotected))
	{
		if(isDefined(self.delayexplodezombies)) return;

		self.delayexplodezombies = true;

		self thread ExplodeOn(price["explode"]);
	}
	else if(self.pers["team"] == "axis" && self.power < price["explode"])
	{ 
		self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");
	}
}

ExplodeOn(price)
{
	explode = self ExplodeProgressBar();

	if(isDefined(explode) && isDefined(self) && isAlive(self))
	{
		self thread maps\mp\gametypes\_basic::updatePower(price * -1);

    		playfx(game["zom"]["explode"], self.origin);
     		self playsound("grenade_explode_layer");
     		self playsound("zom_explode");
     		self thread Explote();
     		wait 0.01;
     		if(isDefined(self) && isAlive(self)) 
			self suicide();

		if(level.totalplayersnum["axis"] == 1)
			wait(10);
		else if(level.totalplayersnum["axis"] <= 5)
			wait(15);
		else
     			wait(20);

		if(isDefined(self) && self.pers["team"] == "axis")
			self iprintln(&"ZMESSAGES_EXPLODECHARGED");
	}

	if(isDefined(self))
		self.delayexplodezombies = undefined;
}

Explote()
{
	players = getentarray("player", "classname");

	for(i = 0; i < players.size; i++)
	{
		if(players[i].pers["team"] == "allies")
		{
			dist = distance(self.origin, players[i].origin);
			players[i] playsound("shellshock_loop");
			
  			if(dist < 400 && !isDefined(players[i].inbubble))
			{
				time = 1;
			
				if(dist <= 150)
					time = 3;
				else if(dist < 300)
					time = 2;

				players[i] ShellShock( "default", time );
			}

			earthquake(0.5,1.4,self.origin,600);
			dir = vectortoangles(self.origin - players[i].origin);
			dir = ((dir[0] / 360), (dir[1] / 360), (dir[2] / 360));		
			if(dist <= 240 && !isDefined(players[i].inbubble))
			{
				dmg = (240 - dist) / 240 * 60;
			
				if(dmg < 5)
					dmg = 5;

				dmg = int(dmg);       
 
				players[i] thread [[level.callbackPlayerDamage]](self, self, dmg, 1, "MOD_PROJECTILE_SPLASH", "none", self.origin, dir, "none", 0);                         
                	}
		}
	}    
}

Bodypart()
{
	if(self.sessionstate == "dead" && self.pers["team"] == "axis")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't use bodyparts!!! ");
		return;
	}

	if(isDefined(self.delaybodypartzombies))
		return;

	price = maps\mp\gametypes\_basic::GetActionPrices();

	if(self.pers["team"] == "axis" && self.power >= price["bodyparts"]) // && !isDefined(self.spawnprotected))
	{
		self thread BodypartOn();
		self thread maps\mp\gametypes\_basic::updatePower(price["bodyparts"] * -1);
		self.delaybodypartzombies = true;
	}
	else if(self.pers["team"] == "axis" && self.power < price["bodyparts"])
	{ 
		self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");
	}
}

BodypartOn()//this gives the bodyparts to the zoms...lol.
{
	if(self.pers["team"] == "axis")
	{
		zombienade = "bodypart_mp";
		zombienadenum = 3;
		self giveWeapon(zombienade);
		self setWeaponClipAmmo(zombienade, zombienadenum);
		self iprintlnbold(&"ZMESSAGES_BODYPARTARMED", zombienadenum);
	}

	wait(5);

	self.delaybodypartzombies = undefined;
}

Teddy()
{
	if(!isDefined(self.plantedteddys)) self.plantedteddys = 0;

	if(self.sessionstate == "dead" && self.pers["team"] == "axis")
	{
		if(getCvar("scr_zn_actionsdead") == "1") self iprintlnbold(" ^1Dead people can't use a teddy!!! ");
		return;
	}

	price = maps\mp\gametypes\_basic::GetActionPrices();

	origin = self.origin;
	trace = bullettrace(origin + (0,0,45), origin + (0,0,-10000), false, self);

	if(self.pers["team"] == "axis" && self.power >= price["teddybear"] && !isTeddy(trace) && self.plantedteddys < 5 && !isDefined(self.spawnprotected))
	{
		self thread TeddyOn(origin, trace);
		self thread maps\mp\gametypes\_basic::updatePower(price["teddybear"] * -1);
		self.plantedteddys++;
		self notify("update_powerhud_value");
	}
	else if(self.pers["team"] == "axis" && self.power >= price["teddybear"] && self.plantedteddys >= 5)
		self iprintlnbold(&"ZMESSAGES_ENOUGHTEDDIES");
	else if(self.pers["team"] == "axis" && self.power < price["teddybear"])
		self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");
	else if(!isDefined(self.spawnprotected))
		self iprintlnbold("^1You cannot plant here.");
}

isTeddy(trace)
{
	ent = trace["entity"];

	if(isDefined(ent) && isDefined(ent.targetname) && ent.targetname == "bear")
		return true;

	return false;
}

TeddyOn(origin, trace)
{
     	teddy = spawn( "script_model", origin + (0,0,45));
     	teddy setmodel("xmodel/prop_bear_detail_sitting");
	bearplace = trace["position"];
     	teddy.targetname = "bear";
	teddy.owner = self;
	teddy moveto(bearplace + (0,0,0),0.2);
	wait 0.3;
      	self iprintlnbold(&"ZMESSAGES_PLANTEDTEDDY");

	radiustrigbear = spawn( "trigger_radius", teddy.origin, 10, 10, 35);

	if(isDefined(trace["entity"]) && trace["entity"].classname == "script_brushmodel" && isDefined(trace["entity"].targetname))
	{
		radiustrigbear enableLinkTo();
		radiustrigbear linkto(teddy);	
		teddy linkto(trace["entity"]);
	}

	bearactive = true;

	while(bearactive)
	{
  		radiustrigbear waittill("trigger",player);

  		if(player.pers["team"] == "allies" && player.sessionteam == "allies") 
  		{
   			teddy playsound("explo_metal_rand");
   			playfx(game["mineEffect"]["explode"], teddy.origin);
                	earthquake(0.5,1.4,teddy.origin,100);
			
			if(isPlayer(player))
			{
                		player ShellShock( "default", 4 );
                		player iprintlnbold(&"ZMESSAGES_TEDDYSTUNNED");

				if(isPlayer(self) && self.pers["team"] != "allies")
   					player thread [[level.callbackPlayerDamage]](teddy, self, 30, 0, "MOD_GRENADE_SPLASH", "teddy_mp", teddy.origin, vectornormalize(player.origin + (0,0,20) - teddy.origin), "none", 0);
				else
					player thread [[level.callbackPlayerDamage]](teddy, player, 30, 0, "MOD_GRENADE_SPLASH", "teddy_mp", teddy.origin, vectornormalize(player.origin + (0,0,20) - teddy.origin), "none", 0);
			}

               		teddy setmodel("xmodel/tag_origin");
			bearactive = false;
 		}
	}

        teddy delete();
        radiustrigbear delete();
	if(isDefined(self)) self.plantedteddys--;
}

//From here all the admincontrols

ByebyeZombies()
{
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		player = players[i];

   		if(player.pers["team"] == "axis")
			player suicide();
	}		
}

ByebyeHunters()
{
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		player = players[i];

   		if(player.pers["team"] == "allies")
			player suicide();
	}
}

Power()
{
	powerz = 1000;
	self thread maps\mp\gametypes\_basic::updatePower(powerz);
}

DeathStreak()
{
	self endon("disconnect");

	if(isPlayer(self))
	{
		if(!isDefined(self.deathstreak))
			self.deathstreak = 0;

	 	self.deathstreak++;

		switch(self.deathstreak)
		{
			case 5:
				self iprintlnbold("^1You Are On a 5 DeathStreak!!!");
				self thread maps\mp\gametypes\_basic::updatePower(250);
				break;
				
			case 15:
				self iprintlnbold("^1You Are On a 15 DeathStreak!!!");
				self thread maps\mp\gametypes\_basic::updatePower(500);
				break;
				
			case 30:
				self iprintlnbold("^1You Are On a 30 DeathStreak!!!");
				self thread maps\mp\gametypes\_basic::updatePower(1000);
				break;

			default:
				break;
		}
	}
}

KillStreak()
{
	self endon("disconnect");
	
	if(isPlayer(self))
	{
		if(!isDefined(self.killstreak))
			self.killstreak = 0;

	 	self.killstreak++;
	 
		switch(self.killstreak)
		{
			case 3:
				self iprintlnbold(&"ZMESSAGES_KILLSTREAK3");
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ONKILLSTREAK3", self);
                     		if(self.pers["team"] == "allies")
				{
					self iprintlnbold(&"ZMESSAGES_EARNEDMEDPACK");
                     			self.medpack = self.medpack + 1;
					self notify("update_medpackhud_value");
				}
				break;

			case 6:
				self SayTeam( "^2M^9ulti^2K^9ill^2!!!" );
				self iprintlnbold(&"ZMESSAGES_KILLSTREAK6");
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ONKILLSTREAK6", self);
                     		if(self.pers["team"] == "allies")
				{
                     			self iprintlnbold(&"ZMESSAGES_EARNEDAMMO");
                      			self GiveStartAmmo( self getweaponslotweapon("primary") );
                   			self GiveStartAmmo( self getweaponslotweapon("primaryb") );
				}
				break;
				
			case 15:
				self SayTeam( "^2O^9ver^2K^9ill^2!!!" );
				self iprintlnbold(&"ZMESSAGES_KILLSTREAK15");
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ONKILLSTREAK15", self);
                     		if(self.pers["team"] == "allies")
				{
					self iprintlnbold(&"ZMESSAGES_EARNEDMINE");
                     			self.mine = self.mine + 1;
					self notify("update_minehud_value");
				}
				break;
				
			case 25:
				self SayTeam( "^2M^9onster^2K^9ill^2!!!" );
				self iprintlnbold(&"ZMESSAGES_KILLSTREAK25");
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ONKILLSTREAK25", self);
                     		if(self.pers["team"] == "allies")
				{			
                     			self iprintlnbold(&"ZMESSAGES_EARNEDMONEYAMMO", 2000);
                     			self thread maps\mp\gametypes\_basic::updatePower(2000);
                     			self GiveStartAmmo( self getweaponslotweapon("primary") );
				}
				break;
				
			case 50:
				self SayTeam( "^2G^9ODLIKE^2!!!" );
				self iprintlnbold(&"ZMESSAGES_KILLSTREAK50");
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ONKILLSTREAK50", self);
                     		if(self.pers["team"] == "allies")
				{
                     			self iprintlnbold(&"ZMESSAGES_EARNEDPOWERAMMOMED", 2000);
			     		self thread maps\mp\gametypes\_basic::updatePower(2000);
                     			self GiveStartAmmo( self getweaponslotweapon("primary") );
					self GiveStartAmmo( self getweaponslotweapon("primaryb") );
                     			self.medpack = self.medpack + 1;
					self notify("update_medpackhud_value");
				}
				break;

			case 75:
				self iprintlnbold(&"ZMESSAGES_KILLSTREAK75");
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ONKILLSTREAK75", self);
                     		if(self.pers["team"] == "allies") //&& getCvar("zn_disabled_airstrike") != "1")
				{
					self iprintlnbold(&"ZMESSAGES_EARNEDAMMOTWOMEDMINE", 5000);
			     		self thread maps\mp\gametypes\_basic::updatePower(5000);
					self GiveStartAmmo( self getweaponslotweapon("primary") );
                     			self.mine = self.mine + 1;
                     			self.medpack = self.medpack + 2;
					self notify("update_medpackhud_value");
					self notify("update_minehud_value");
					//self iprintlnbold(&"ZMESSAGES_EARNEDAIRSTRIKE");
					//wait(1.5);
					//self thread maps\mp\gametypes\_airstrike::MortarOnLocation();
					//self thread maps\mp\gametypes\_airstrike::CallAirstrike();
					//self.gotfreeairstrike = true;
				}
				break;
				
			case 100:
				self iprintlnbold(&"ZMESSAGES_KILLSTREAK100");
				maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ONKILLSTREAK100", self);
				if(self.pers["team"] == "allies")
				{
					self iprintlnbold(&"ZMESSAGES_EARNEDAIRSTRIKE");
					self GiveStartAmmo( self getweaponslotweapon("primaryb") );
					wait(2);
					self thread maps\mp\gametypes\_airstrike::Nuclear();
				}
				break;
		}
	}
}

MineRemoval()
{
	price = maps\mp\gametypes\_basic::GetActionPrices();

	if((self.pers["team"] == "axis" || self.pers["team"] == "allies") && self.power >= price["mineremoval"] && !isDefined(self.spawnprotected))
	{
		if(isDefined(self.delaymineremoval)) return;

		self.delaymineremoval = true;
		self thread MineRemovalDo(price["mineremoval"]);
	}
	else if((self.pers["team"] == "axis" || self.pers["team"] == "allies") && self.power < price["mineremoval"])
	{ 
		self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");
	}
}

MineRemovalDo(price)
{
	mine = undefined;
	radiustrig = undefined;
	owner = undefined;

	starts = [];
	starts[0] = self.origin + (0,0,66); // stand
	starts[1] = self getEye(); // sit
	starts[2] = self getEye() - (0,0,30); // lay

	for(i=0;i<starts.size;i++)
	{
		start = starts[i];
		end = start + maps\mp\_utility::vectorScale(AnglesToForward(self getplayerangles()), 1000000);
		trace = BulletTrace( start, end, false, self );

		if(isDefined(trace["entity"]))
		{
			//if(maps\mp\gametypes\_basic::debugModeOn(self)) self iprintln("Found entity [" + i + "]");

			if(isDefined(trace["entity"].targetname) && trace["entity"].targetname == "mine")
			{
				//if(maps\mp\gametypes\_basic::debugModeOn(self)) self iprintln("Found entity with targetname mine");
				mine = trace["entity"];
				owner = mine.owner;
				radiustrig = mine.radiustrig;
				break;
			}
		}
	}

	if(!isDefined(mine))
	{
		self iprintlnbold(&"ZMESSAGES_NOMINEFOUND");
		self.delaymineremoval = undefined;
		return;
	}

	if(self.pers["team"] == "allies" && owner != self)
	{
		self iprintlnbold(&"ZMESSAGES_OWNMINEHUNTER");
		self.delaymineremoval = undefined;
		return;
	}

	self iprintlnbold(&"ZMESSAGES_HOLDREMOVEMINE");

	while(!self useButtonPressed() && isAlive(self))
		wait(0.05);

	completed = self progressBar(mine, price);

	if(isDefined(completed) && isDefined(mine) && self.power >= price)
	{
		//if(maps\mp\gametypes\_basic::debugModeOn(self)) self iprintln("Removed cash for mine pickup");
		self thread maps\mp\gametypes\_basic::updatePower(price * -1);

		mine notify("minekilled");

		RemoveMine(owner, mine, radiustrig);		

		if(isDefined(self))
		{
			self.mine = self.mine + 1;
			self notify("update_minehud_value");
		}
	}

	self.delaymineremoval = undefined;
}

GetAnglesTrace()
{
	start = self.origin + (0, 0, 10);

	range = 11;
	forward = anglesToForward(self.angles);
	forward = maps\mp\_utility::vectorScale(forward, range);

	traceorigins[0] = start + forward;
	traceorigins[1] = start;

	besttracefraction = undefined;
	besttraceposition = undefined;

	trace = bulletTrace(traceorigins[0], (traceorigins[0] + (0, 0, -18)), false, undefined);
	if(trace["fraction"] < 1) 
	{		
		temp = spawnstruct();
		temp.origin = trace["position"];
		temp.angles = maps\mp\_utility::orientToNormal(trace["normal"]);
		return temp;
	}

	trace = bulletTrace(traceorigins[1], (traceorigins[1] + (0, 0, -18)), false, undefined);
	if(trace["fraction"] < 1)
	{

		temp = spawnstruct();
		temp.origin = trace["position"];
		temp.angles = maps\mp\_utility::orientToNormal(trace["normal"]);
		return temp;
	}

	traceorigins[2] = start + (16, 16, 0);
	traceorigins[3] = start + (16, -16, 0);
	traceorigins[4] = start + (-16, -16, 0);
	traceorigins[5] = start + (-16, 16, 0);

	for(i = 0; i < traceorigins.size; i++)
	{
		trace = bulletTrace(traceorigins[i], (traceorigins[i] + (0, 0, -1000)), false, undefined);

		if(!isdefined(besttracefraction) || (trace["fraction"] < besttracefraction))
		{
			besttracefraction = trace["fraction"];
			besttraceposition = trace["position"];
		}
	}

	if(!isdefined(besttracefraction))
		return undefined;
	
	if(besttracefraction == 1)
		besttraceposition = self.origin;
	
	temp = spawnstruct();
	temp.origin = besttraceposition;
	temp.angles = maps\mp\_utility::orientToNormal(trace["normal"]);
	return temp;
}

RemoveMine(owner, mine, radiustrigmine)
{
	if(isDefined(owner)) 
	{
		owner.spentmine-=1;

		if(owner.spentmine<0)
			owner.spentmine = 0;

		if(isdefined(owner.minesplanted))
			owner.minesplanted destroy();

		owner.minenum = owner.minenum + 1;

		if(owner.minenum > level.maxmines+1)
			owner.minenum = level.maxmines+1;
	}
 
	if(isDefined(mine) && isDefined(mine.islinked))
	{
		radiustrigmine unlink();
		mine unlink();
	}

	if(isDefined(radiustrigmine)) radiustrigmine delete();
	if(isDefined(mine)) mine delete();
	if(isDefined(owner)) owner notify("mine_cleanup");
}

ExplodeProgressBar()
{
	planttime = 0.05;
	barsize = 192;

	if(!isdefined(self.explodeprogressbackground))
	{
		self.explodeprogressbackground = newClientHudElem(self);
		self.explodeprogressbackground.x = 0;
		self.explodeprogressbackground.y = 54;
		self.explodeprogressbackground.alignX = "center";
		self.explodeprogressbackground.alignY = "middle";
		self.explodeprogressbackground.horzAlign = "center_safearea";
		self.explodeprogressbackground.vertAlign = "center_safearea";
		self.explodeprogressbackground.alpha = 0.5;
	}

	self.explodeprogressbackground setShader("black", (barsize + 4), 12);

	if(!isdefined(self.explodeprogressbar))
	{
		self.explodeprogressbar = newClientHudElem(self);
		self.explodeprogressbar.x = int(barsize / (-2.0));
		self.explodeprogressbar.y = 54;
		self.explodeprogressbar.alignX = "left";
		self.explodeprogressbar.alignY = "middle";
		self.explodeprogressbar.horzAlign = "center_safearea";
		self.explodeprogressbar.vertAlign = "center_safearea";
		self.explodeprogressbar.color = (1,0,0);
	}

	self.explodeprogressbar setShader("white", barsize, 8);
	self.explodeprogressbar scaleOverTime(planttime, 1, 8);

	progresstime = 0;
	while(isAlive(self) && (progresstime < planttime))
	{
		progresstime += 0.05;
		wait 0.05;
	}

	if(progresstime >= planttime)
	{
		self thread progressBarDelay(planttime);
	
		while(self useButtonPressed() && isAlive(self))
			wait(0.05);

		return true;
	}
	else
	{
		if(isdefined(self.explodeprogressbackground))
			self.explodeprogressbackground destroy();

		if(isdefined(self.explodeprogressbar))
			self.explodeprogressbar destroy();
	}

	return undefined;
}

progressBarDelay(planttime)
{
	wait(planttime * 2);
	self.explodeprogressbackground destroy();
	self.explodeprogressbar destroy();
}

progressBar(object, price)
{
	planttime = 3;
	barsize = 192;
	current = self getCurrentWeapon();

	if(!isdefined(self.progressbackground))
	{
		self.progressbackground = newClientHudElem(self);
		self.progressbackground.x = 0;
		self.progressbackground.y = 104;
		self.progressbackground.alignX = "center";
		self.progressbackground.alignY = "middle";
		self.progressbackground.horzAlign = "center_safearea";
		self.progressbackground.vertAlign = "center_safearea";
		self.progressbackground.alpha = 0.5;
	}

	self.progressbackground setShader("black", (barsize + 4), 12);

	if(!isdefined(self.progressbar))
	{
		self.progressbar = newClientHudElem(self);
		self.progressbar.x = int(barsize / (-2.0));
		self.progressbar.y = 104;
		self.progressbar.alignX = "left";
		self.progressbar.alignY = "middle";
		self.progressbar.horzAlign = "center_safearea";
		self.progressbar.vertAlign = "center_safearea";
	}

	self.progressbar setShader("white", 0, 8);
	self.progressbar.color = (1,0,0);
	self.progressbar scaleOverTime(planttime, barsize, 8);

	self disableWeapon();

	progresstime = 0;
	while(isAlive(self) && self useButtonPressed() && self.power >= price && (progresstime < planttime) && isDefined(object) && distance(self.origin, object.origin) < 120)
	{
		progresstime += 0.05;
		wait 0.05;
	}

	if(progresstime >= planttime)
	{
		if(isDefined(self.progressbackground)) 
			self.progressbackground destroy();
		if(isDefined(self.progressbar)) 
			self.progressbar destroy();
		if(isDefined(self)) 
		{
			self enableWeapon();
			self switchToWeapon(current);
		}

		return true;
	}
	else
	{
		if(isdefined(self.progressbackground))
			self.progressbackground destroy();

		if(isdefined(self.progressbar))
			self.progressbar destroy();

		if(isDefined(self)) 
		{
			self enableWeapon();

			if(current != "none")
				self switchToWeapon(current);
		}

		return undefined;
	}
}

digit_length(digit)
{
    len = 0;
    
    while (digit >= 1)
    {
        digit /= 10;
        len++;
    }
    
    return len;
}

AlliesPacks()//Stupid addon..
{
     tombdelay = 30;
     switch(randomint(5))//Here it randomly switches between five
     {
	   case 0:
         //First type of tombstone
	   tomb1 = spawn( "script_model", self.origin + (0,0,-1));
	   tomb1 setmodel("xmodel/prop_tombstone1");
        grass1 = spawn( "script_model", self.origin + (0,0,-1));
        grass1 setmodel("xmodel/grasstuftgroup_test");
        wait tombdelay;
        tomb1 delete();
        grass1 delete();
	   break;
	 		
	   case 1:
	   //Second type of tombstone
	   tomb2 = spawn( "script_model", self.origin + (0,0,-1));
	   tomb2 setmodel("xmodel/prop_tombstone2");
         grass2 = spawn( "script_model", self.origin + (0,0,-1));
         grass2 setmodel("xmodel/grasstuftgroup_test");
         wait tombdelay;
         tomb2 delete();
         grass2 delete();
         break;
			
	    case 2:
	    //Third type of tombstone
	    tomb3 = spawn( "script_model", self.origin + (0,0,-1));
	    tomb3 setmodel("xmodel/prop_tombstone3");
         grass3 = spawn( "script_model", self.origin + (0,0,-1));
         grass3 setmodel("xmodel/grasstuftgroup_test");
         wait tombdelay;
         tomb3 delete();
         grass3 delete();
	    break;
			
	    case 3:
	    //Fourth type of tombstone
	    tomb4 = spawn( "script_model", self.origin + (0,0,-1));
	    tomb4 setmodel("xmodel/prop_tombstone4");
         grass4 = spawn( "script_model", self.origin + (0,0,-1));
         grass4 setmodel("xmodel/grasstuftgroup_test");
         wait tombdelay;
         tomb4 delete();
         grass4 delete();
	    break;
			
	    case 4:
	    //Fifth type of tombstone
	    tomb5 = spawn( "script_model", self.origin + (0,0,-1));
	    tomb5 setmodel("xmodel/prop_tombstone5");
         grass5 = spawn( "script_model", self.origin + (0,0,-1));
         grass5 setmodel("xmodel/grasstuftgroup_test");
         wait tombdelay;
         tomb5 delete();
         grass5 delete();
	    break;

		}
}
