// Created by Mitch
init()
{
	precacheModel("xmodel/prop_crate_smallshipping_open2");
	precacheString(&"^7Press ^4[^7Use^4]^7 to use the Random Box^4.");
	precacheShader( "gfx/icons/hint_usable" );
	precacheShader( "objpoint_question" );

	precacheItem("greasegun_mp");
	precacheItem("m1carbine_mp");
	precacheItem("m1garand_mp");
	precacheItem("springfield_mp");
	precacheItem("thompson_mp");
	precacheItem("bar_mp");
	precacheItem("sten_mp");
	precacheItem("enfield_mp");
	precacheItem("enfield_scope_mp");
	precacheItem("bren_mp");
	precacheItem("PPS42_mp");
	precacheItem("mosin_nagant_mp");
	precacheItem("SVT40_mp");
	precacheItem("mosin_nagant_sniper_mp");
	precacheItem("ppsh_mp");
	precacheItem("mp40_mp");
	precacheItem("kar98k_mp");
	precacheItem("g43_mp");
	precacheItem("kar98k_sniper_mp");
	precacheItem("mp44_mp");
	precacheItem("shotgun_mp");

	spawnBox();
}

removeWayPoint()
{
	if(isDefined(self.waypoint_box))
		self.waypoint_box Destroy();
}

addWayPoint()
{
	waypoint = newHudElem();
	waypoint.x = self.origin[0];
	waypoint.y = self.origin[1];
	waypoint.z = self.origin[2] + 100;
	waypoint.alpha = .61;
	waypoint.archived = true;

	icon = "objpoint_question";

	if(level.splitscreen)
		waypoint setShader(icon, 14, 14);
	else
	{
		waypoint setShader(icon, 7, 7);
	}

	waypoint setwaypoint(true);
	self.waypoint_box = waypoint;
}

spawnBox()
{
	level endon("intermission");

	spawnpointname = "mp_tdm_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");

	if(getCvar("scr_randombox_timeout") == "")
		timeout = 120;
	else
		timeout = getCvarInt("scr_randombox_timeout");

	if(timeout < 10)
		timeout = 10;

	for(;;)
	{
		spawn = spawnpoints[randomInt(spawnpoints.size)];
		randomBox(spawn.origin, spawn.angles);
		wait(timeout); // time-out
	}	
}

canUseBox()
{
	if(getCvar("scr_randombox_axis") == "")
		setCvar("scr_randombox_axis", "0");

	if(getCvar("scr_randombox_allies") == "")
		setCvar("scr_randombox_allies", "1");

	if(getCvar("scr_randombox_axis") == "1" && isPlayer(self) && self.pers["team"] == "axis")
		return true;

	if(getCvar("scr_randombox_allies") == "1" && isPlayer(self) && self.pers["team"] == "allies")
		return true;

	return false;
}

randomBox(origin, angles)
{
	wait(2);

	trace = BulletTrace( origin, origin - (0,0,100000), false, undefined );
	origin = trace["position"];

	model = Spawn("script_model", origin);
	model setModel("xmodel/prop_crate_smallshipping_open2");
	model.angles = trace["normal"];
	model addWayPoint();

	wep = Spawn("script_model", origin);
	wep.angles = trace["normal"];
	trigger = Spawn( "trigger_radius", origin, 0, 100, 50 );

	model.takewep = false;
	randwep = undefined;
	buyer = undefined;

	iprintln("A random weapon box just spawned somewhere^1...");

	model thread randomBoxInActive(wep, trigger);
	model endon("inactivetimeout");

	while(1)
	{
		trigger waittill("trigger", player);

		if(player canUseBox()) 
			player thread showButton(trigger);

		if(player UseButtonPressed() && player canUseBox())
		{
			if(!model.takewep)
			{
				model.takewep = true;
				buyer = player;

				wep thread moveWep();
	
				while(isDefined(wep.ismoving) && wep.ismoving)
				{
					randwep = getRandomWeapon();

					wep setModel(randwep[1]);
					wait(0.05);
				}

				wait(0.25);
				wep setModel(randwep[1]);

				wepname = getWeaponName(randwep[0]); 

				if(maps\mp\gametypes\_weapons::useAn(randwep[0]))
					player iprintln("You have won an " + wepname);
				else
					player iprintln("You have won a " + wepname);

				model thread randomBoxInActiveBought(wep, trigger);
			}
			else if(isPlayer(buyer) && buyer == player)
			{
				current = player GetCurrentWeapon();
				weapon1 = player getweaponslotweapon("primary");

				if(current == weapon1)
					player setWeaponSlotWeapon("primary", randwep[0]);
				else
					player setWeaponSlotWeapon("primaryb", randwep[0]);

				player GiveMaxAmmo(randwep[0]);
				player SwitchToWeapon(randwep[0]);
				break;
			}
		}
	}

	model removeWayPoint();
	model notify("destroyed_box");

	wait(0.05);

	model delete();
	wep delete();
	trigger delete();
}

randomBoxInActive(wep, trigger)
{
	self endon("destroyed_box");
	wait(60);

	if(!self.takewep)
	{
		self notify("inactivetimeout");
		self removeWayPoint();
		self delete();
		wep delete();
		trigger delete();
	}
}

randomBoxInActiveBought(wep, trigger)
{
	self endon("destroyed_box");
	wait(30);

	self notify("inactivetimeout");
	self removeWayPoint();
	self delete();
	wep delete();
	trigger delete();
}

showButton(trigger)
{
	if(isDefined(self.randomboxtext))
		return;

	if(!isdefined(self.randomboxtext))
	{
		self.randomboxtext = newClientHudElem(self);
		self.randomboxtext.x = -30;

		if(level.splitscreen)
			self.randomboxtext.y = 70;
		else
			self.randomboxtext.y = 104;

		self.randomboxtext.alignX = "center";
		self.randomboxtext.alignY = "middle";
		self.randomboxtext.horzAlign = "center_safearea";
		self.randomboxtext.vertAlign = "center_safearea";
		self.randomboxtext.alpha = 1;
	}


	if(!isdefined(self.randomboxtext2))
	{
		self.randomboxtext2 = newClientHudElem(self);
		self.randomboxtext2.x = 70;

		if(level.splitscreen)
			self.randomboxtext2.y = 70;
		else
			self.randomboxtext2.y = 104;

		self.randomboxtext2.alignX = "center";
		self.randomboxtext2.alignY = "middle";
		self.randomboxtext2.horzAlign = "center_safearea";
		self.randomboxtext2.vertAlign = "center_safearea";
		self.randomboxtext2.alpha = 1;
	}

	self.randomboxtext.label = (&"^7Press ^4[^7Use^4]^7 to use the Random Box^4.");
	self.randomboxtext2 SetShader( "gfx/icons/hint_usable", 30, 30 );

	while(isDefined(trigger) && isDefined(self) && self isTouching(trigger) && isAlive(self))
		wait(0.05);

	self.randomboxtext Destroy();
	self.randomboxtext2 Destroy();
}

getRandomWeapon()
{
	randwep = [];

	rand = RandomInt( 21 );

	switch(rand)
	{
		case 0:
		w = "greasegun_mp";
		x = "xmodel/weapon_greasegun";
		break;

		case 1:		
		w = "m1carbine_mp";
		x = "xmodel/weapon_m1carbine";
		break;

		case 2:		
		w = "m1garand_mp";
		x = "xmodel/weapon_m1garand";
		break;

		case 3:		
		w = "springfield_mp";
		x = "xmodel/weapon_springfield";
		break;

		case 4:		
		w = "thompson_mp";
		x = "xmodel/weapon_thompson";
		break;

		case 5:		
		w = "bar_mp";
		x = "xmodel/weapon_bar";
		break;

		case 6:		
		w = "sten_mp";
		x = "xmodel/weapon_sten";
		break;

		case 7:		
		w = "enfield_mp";
		x = "xmodel/weapon_enfield";
		break;

		case 8:		
		w = "enfield_scope_mp";
		x = "xmodel/weapon_enfield_scope";
		break;

		case 9:		
		w = "bren_mp";
		x = "xmodel/weapon_bren";
		break;

		case 10:		
		w = "PPS42_mp";
		x = "xmodel/weapon_pps43";
		break;

		case 11:		
		w = "mosin_nagant_mp";
		x = "xmodel/weapon_mosinnagant";
		break;

		case 12:		
		w = "SVT40_mp";
		x = "xmodel/weapon_svt40";
		break;

		case 13:		
		w = "mosin_nagant_sniper_mp";
		x = "xmodel/weapon_mosinnagantscoped_cloth";
		break;

		case 14:		
		w = "ppsh_mp";
		x = "xmodel/weapon_ppsh";
		break;

		case 15:		
		w = "mp40_mp";
		x = "xmodel/weapon_mp40";
		break;

		case 16:		
		w = "kar98k_mp";
		x = "xmodel/weapon_kar98";
		break;

		case 17:		
		w = "g43_mp";
		x = "xmodel/weapon_g43";
		break;

		case 18:		
		w = "kar98k_sniper_mp";
		x = "xmodel/weapon_kar98_scoped";
		break;

		case 19:		
		w = "mp44_mp";
		x = "xmodel/weapon_mp44";
		break;

		case 20:		
		w = "shotgun_mp";
		x = "xmodel/weapon_trenchgun";
		break;

		default:		
		w = "greasegun_mp";
		x = "xmodel/weapon_greasegun";
		break;
	}

	randwep[0] = w;
	randwep[1] = x;

	return randwep;	
}

moveWep()
{
	self.ismoving = true;
	self moveZ(50, 5);
	self waittill("movedone");
	self.ismoving = undefined;
}

getWeaponName(weapon)
{
	switch(weapon)
	{
	// American
	case "m1carbine_mp":
		weaponname = "M1 Carbine";
		break;

	case "m1garand_mp":
		weaponname = "M1 Garand";
		break;

	case "thompson_mp":
		weaponname = "Thompson";
		break;

	case "bar_mp":
		weaponname = "Bar";
		break;

	case "springfield_mp":
		weaponname = "Springfield";
		break;

	case "greasegun_mp":
		weaponname = "Greasegun";
		break;

	case "shotgun_mp":
		weaponname = "Shotgun";
		break;

	case "enfield_mp":
		weaponname = "Lee Enfield";
		break;

	case "sten_mp":
		weaponname = "Sten";
		break;

	case "bren_mp":
		weaponname = "Bren";
		break;

	case "enfield_scope_mp":
		weaponname = "Lee Enfield Sniper";
		break;

	// Russian
	case "mosin_nagant_mp":
		weaponname = "Mosin Nagant";
		break;

	case "SVT40_mp":
		weaponname = "SVT40";
		break;

	case "PPS42_mp":
		weaponname = "PPS42";
		break;

	case "ppsh_mp":
		weaponname = "PPSH";
		break;

	case "mosin_nagant_sniper_mp":
		weaponname = "Mosin Nagant Sniper";
		break;

	case "kar98k_mp":
		weaponname = "Kar98k";
		break;

	case "g43_mp":
		weaponname = "G43";
		break;

	case "mp40_mp":
		weaponname = "MP40";
		break;

	case "mp44_mp":
		weaponname = "AK-47";
		break;

	case "kar98k_sniper_mp":
		weaponname = "Kar98k Sniper";
		break;

	case "panzerfaust_mp":
		weaponname = "Panzerfaust";
		break;

	case "panzerschreck_mp":
		weaponname = "Panzerschreck";
		break;

	default:
		weaponname = "Unknown Weapon";
		break;
	}

	return weaponname;
}