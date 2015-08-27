init()
{
	if(getCvar("zn_disabled_airstrike") == "1") return;

	precacheModel("xmodel/vehicle_p51_mustang");
	precacheModel("xmodel/weapon_temp_panzershreck_rocket");
	level._effect["plane_bomb_exp"] 		= loadfx ("fx/explosions/spitfire_bomb_dirt.efx");
}

CallAirstrike()
{
	self endon("killed_player");
	self endon("disconnect");
	self endon("no_more_airstrikes");

	self iprintlnbold(&"ZMESSAGES_AIRSTRIKEATTACK");

	while(1)
	{
		self waittill("binocular_enter");

		self.inbinocular = true;

		self thread EndonBinocularExit();

		while(isDefined(self.inbinocular) && !isDefined(self.islinkedtoplane))
		{
			if(self attackButtonPressed() && !isDefined(self.islinkedtoplane))
			{
				self notify("called_in_target");
				self thread getTarget();
				self.inbinocular = undefined;
			}

			wait(0.05);
		}
	}
}

EndonBinocularExit()
{
	self endon("called_in_target");
	self waittill("binocular_exit");
	wait(0.05);
	self.inbinocular = undefined;
}

AirStrike_Actions( plane, savepos )
{
	self endon("airstrike_ended");
	self endon("killed_player");
	self endon("disconnect");
	self.airstrikeammo = 5;	

	while(1)
	{
		if(self UseButtonPressed())
		{
			if(self.airstrikeammo > 0) 
				self thread DropBomb( plane );
			else 
				self iprintlnbold(&"ZMESSAGES_ALREADYDROPBOMBS");

			while(self UseButtonPressed())
			{
				wait(0.05);
			}
		}

		if(self MeleeButtonPressed())
		{
			self.islinkedtoplane = undefined;
			self unlink();
			trace = bulletTrace( savepos, savepos - (0,0,1000000), false, self );
			trace["position"] += (0,0,60);
			self setorigin(trace["position"]);

			if(!isDefined(self.pers["savedmodel"]))
				maps\mp\gametypes\_teams::model();
			else
				maps\mp\_utility::loadModel(self.pers["savedmodel"]);

			self enableweapon();
			self notify("airstrike_ended");
		}

		wait(0.05);
	}

}

DropBomb( plane )
{
	self.airstrikeammo -= 1;	
	origin = plane.origin;
	
	self iprintlnbold("^1Dropping bomb!");

	bomb = Spawn( "script_model", origin );
	bomb.angles = (90, 0, 0);
	bomb setModel("xmodel/weapon_temp_panzershreck_rocket");

	trace = BulletTrace( origin, origin - (0,0,1000000), false, self );
	location = trace["position"] + (0,0,13);

	time = distance( origin, location ) / 400;

	bomb MoveTo(location, time);
	bomb waittill("movedone");
	bomb hide();
	playFX(level._effect["plane_bomb_exp"],location);
	bomb playsound("mortar_explosion");
	DoRadiusDamage( trace["position"], 1000, 1500, 300, self, true );
	wait(5);
	bomb delete();
}

/*
DoRadiusDamageWithAttacker(origin, range, max, min, attacker)
{
	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++)
	{
		player = players[i];

		dist = distance(player.origin, origin);

		if(dist < range)
		{
			dmg = (range - dist) / range * max;
			
			if(dmg < min)
				dmg = min;

			dmg = int(dmg);

			direction = vectortoangles(player.origin - origin);

			if(player.pers["team"] != attacker.pers["team"]) player thread [[level.callbackPlayerDamage]](player, attacker, dmg, 1, "MOD_EXPLOSIVE", "airstrike_mp", origin, direction, "none",0);
		}
	}
}*/

getTarget()
{
	if(isDefined(level.planeisintheair)) 
	{
		self iprintlnbold(&"ZMESSAGES_PLANEALREADYINAIR");

		return;	
	}

	if(!isDefined(self.gotfreeairstrike))
	{
		price = maps\mp\gametypes\_basic::GetActionPrices();
		if(self.power < price["airstrike"])
		{
			self notify("no_more_airstrikes");
			self iprintlnbold(&"ZMESSAGES_CANTPURCHASE");
			return;
		}

		self maps\mp\gametypes\_basic::updatePower(price["airstrike"] * -1);
	}
	else
		self.gotfreeairstrike = undefined;

	self notify("no_more_airstrikes");

	self iprintlnbold(&"ZMESSAGES_PLANELAUNCHED");

	level.planeisintheair = true;

	start = self getEye();
	//start = self.origin;
	dir = AnglesToForward(self getplayerangles());
	forward = maps\mp\_utility::vectorScale(dir, 100000);
	end = start + forward;

	trace = BulletTrace( start, end, false, self );

	bomborigin = trace["position"];

	planeheight = BulletTrace( bomborigin, bomborigin + (0,0,10000), false, self );
	height = distance(planeheight["position"], bomborigin) / 4 * 3;
	height = bomborigin[2] + height;

	planestart = BulletTrace( planeheight["position"], planeheight["position"] + (1000000,0,0), false, self );
	planeend = BulletTrace( planeheight["position"], planeheight["position"] + (-1000000,0,0), false, self );

	splanestart = BulletTrace( planeheight["position"], planeheight["position"] + (0,1000000,0), false, self );
	splaneend = BulletTrace( planeheight["position"], planeheight["position"] + (0,-1000000,0), false, self );

	if(distance(splanestart["position"], splaneend["position"]) > distance(planestart["position"], planeend["position"]))
	{
		planestart = splanestart;
		planeend = splaneend;
	}

	origin = (planestart["position"][0], planestart["position"][1], height);

	wait(3);

	neworigin = (bomborigin[0], bomborigin[1], height);

	plane = Spawn( "script_model", origin );
	plane setModel("xmodel/vehicle_p51_mustang");
	plane.angles = VectorToAngles( neworigin - origin );
	plane PlayLoopSound("p51_mustang_loop");

	savepos = self.origin;

	self setmodel("xmodel/tag_origin");
	self detachall();
	self disableweapon();

	self setclientcvar("cg_thirdperson", 0);
	self setorigin(origin - (0,0,90));
	self linkto(plane);
	self.islinkedtoplane = true;
	self thread QuitOnKilled();

	self thread AirStrike_Actions( plane, savepos );

	self iprintlnbold("\n\n\n\n\n");
	self iprintlnbold(&"ZMESSAGES_DROPBOMSHOWTO");
	self iprintlnbold(&"ZMESSAGES_EXITPLANE");

	wait(1);

	endorigin = (planeend["position"][0], planeend["position"][1], height);

	time = distance( origin, neworigin ) / 220; // 190
	//time = 10;

	if(time <= 0)
		time = 5;

	if(maps\mp\gametypes\_basic::debugModeOn(self))
		self iprintln("Airstrike START BEFORE");	

	plane MoveTo( neworigin, time);
	plane waittill("movedone");

	if(maps\mp\gametypes\_basic::debugModeOn(self))
		self iprintln("Airstrike START AFTER");
	
	if(self.airstrikeammo > 0 && !isDefined(self.islinkedtoplane))
	{
		self thread DropBomb( plane );
	}

	time = distance( neworigin, endorigin ) / 190; // 170
	//time = 10;

	if(time <= 0)
		time = 5;

	self thread ExitPlaneOnTime(time, savepos);
	
	if(maps\mp\gametypes\_basic::debugModeOn(self))
		self iprintln("Airstrike END BEFORE");

	plane MoveTo( endorigin, time);
	plane waittill("movedone");

	if(maps\mp\gametypes\_basic::debugModeOn(self))
		self iprintln("Airstrike END AFTER");
	
	plane StopLoopSound();

	plane hide();
	plane delete();

	wait(1.5);
	
	level.planeisintheair = undefined;
}

QuitOnKilled()
{
	self endon("airstrike_ended");

	self waittill("killed_player");
	if(isDefined(self))
	{
		if(isDefined(self.islinkedtoplane)) self.islinkedtoplane = undefined;
		if(isDefined(self.thirdperson) && self.thirdperson == true)
			self setclientcvar("cg_thirdperson", 1);
	}
}


ExitPlaneOnTime( time, savepos )
{
	self endon("killed_player");
	self endon("disconnect");
	self endon("airstrike_ended");

	if(!isDefined(self.islinkedtoplane)) return;

	wait(time / 4 * 2);

	self.islinkedtoplane = undefined;
	self unlink();
	trace = bulletTrace( savepos, savepos - (0,0,1000000), false, self );
	trace["position"] += (0,0,30);
	self setorigin(trace["position"]);
	if(isDefined(self.thirdperson) && self.thirdperson == true)
		self setclientcvar("cg_thirdperson", 1);

	if(!isDefined(self.pers["savedmodel"]))
		maps\mp\gametypes\_teams::model();
	else
		maps\mp\_utility::loadModel(self.pers["savedmodel"]);

	self enableweapon();
	self notify("airstrike_ended");
}

MortarOnLocation()
{
	self endon("disconnect");
	self endon("killed_player");

	self iprintlnbold("^4T^7arget the position to mortar and press ^4[^7Use^4]^7.");

	while(!self UseButtonPressed())
		wait(0.05);

	trace = self maps\mp\gametypes\_admin::getTargetPosition();
	pos = trace["position"];
	count = 30;
	height = self getHighestHeight(pos[2]);

	while (count > 0)
	{
		target = getNextTarget(pos, height);
		self thread dropMortarBomb(target, 2500, 200, 1000, 100, true);
		
		wait 0.25;
		count--;
	}
}

dropMortarBomb(target, dist, radius, maxdmg, mindmg, enemyonly)
{
	bomb = spawn( "script_model", target + (0,0,dist));
	bomb setModel( "xmodel/prop_stuka_bomb" );
	bomb.angles = (90,0,0);
	bomb show();	

	bomb moveZ(-1 * dist, 0.75);
	wait(0.2);
	bomb playSound("mortar_incoming2");	
	bomb waittill("movedone");
	bomb hide();

	playfx (game["adminEffect"]["mortar"][randomInt(5)], target);
	bomb playSound("mortar_explosion");
	DoRadiusDamage(target + (0, 0, 10), radius, maxdmg, mindmg, self, enemyonly);
	earthquake(0.3, 3, target, 850);
	wait(1);
	bomb delete();
}

DoRadiusDamage(origin, radius, mindmg, maxdmg, attacker, enemyonly)
{
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(!isPlayer(player) || !isAlive(player) || !isDefined(player.pers["team"]) || isDefined(enemyonly) && isPlayer(attacker) && player.pers["team"] == attacker.pers["team"])
			continue;

		dist = distance(origin, player.origin);
	
		if(dist <= radius)
		{
			dmg = (radius - dist) / radius * maxdmg;
			
			if(dmg < mindmg)
				dmg = mindmg;

			dmg = int(dmg);  

			if(!isPlayer(attacker) || player.pers["team"] == attacker.pers["team"])
				player thread [[level.callbackPlayerDamage]](player, player, dmg, 0, "MOD_GRENADE_SPLASH", "mortar_mp", origin, vectornormalize(player.origin - origin), "none", 0);
			else
				player thread [[level.callbackPlayerDamage]](self, self, dmg, 0, "MOD_GRENADE_SPLASH", "mortar_mp", origin, vectornormalize(player.origin - origin), "none", 0);
		}
	}    
}

getNextTarget(pos, height)
{
	target = pos + (randomIntRange(-500, 501), randomIntRange(-500, 501), 0);
	start = target;
	if(start[2] < height)
		start = (start[0], start[1], height);

	trace = BulletTrace( start, target - (0,0,100000), false, undefined );
	target = trace["position"];
	return target;
}

getHighestHeight(height)
{
	height = maps\mp\gametypes\_airstrike::giveHighestHeight(self getOrigin(), height);

	spawnpoints = getentarray("mp_tdm_spawn", "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isDefined(spawnpoint))
		height = giveHighestHeight(spawnpoint.origin, height);

	spawnpoints = getentarray("mp_global_intermission", "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isDefined(spawnpoint))
		height = giveHighestHeight(spawnpoint.origin, height);

	return height;
}

giveHighestHeight(origin, height)
{
	trace = bulletTrace( origin, origin + (0, 0, 100000), false, undefined );
		
	if(trace["position"][2] > height)
		height = trace["position"][2];

	return height;
}

Nuclear()
{
	self endon ("disconnect");
	self endon ("killed_player");

	self iprintlnbold("Press ^4[^7Use^4] ^7to nuke where you are aiming^4."); 

	while(self UseButtonPressed() == false)
		wait(0.05);

	trace = self maps\mp\gametypes\_admin::getTargetPosition();
	origin = trace["position"];
	self thread maps\mp\gametypes\_admin::playSoundAtLocation("shell_incoming", origin, 1);
        wait 0.5;
        self thread maps\mp\gametypes\_admin::playSoundAtLocation("bricks_exploding", origin, 1);
        wait 0.1;
        self thread maps\mp\gametypes\_admin::playSoundAtLocation("bricks_exploding", origin, 1);
        playfx (game["adminEffect"]["nuclear"], origin);
        wait 0.1;
	self thread maps\mp\gametypes\_admin::playSoundAtLocation("weapons_rocket_explosion", origin, 1);
	
	Earthquake( 1.0, 9, origin, 2000 );

	for(d=100;d<=800;d*=2)
	{
		if(d > 100)
			wait(0.75);

		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
		
			if(!isPlayer(player) || !isDefined(player.pers["team"]) || player.pers["team"] == self.pers["team"] || player.pers["team"] == "spectator")
				continue;

			if(d == 100)
			{
				player ShellShock( "duhoc_boatexplosion", 5 );
				player playrumble("damage_heavy");
			}
		
			player thread [[level.callbackPlayerDamage]]( self, self, d, 3, "MOD_EXPLOSIVE", "none", player.origin, (0, 0, 24), "none", 0 );
		}
	}

	wait 20;
	setExpFog(0.0001, 1, 0, 1, 30);	
}