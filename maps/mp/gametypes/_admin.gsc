// Created By LilPimp
// Updated by Mitch
init()	
{
	game["adminEffect"]["mortar"][0]	= loadfx("fx/explosions/mortarExp_beach.efx");
	game["adminEffect"]["mortar"][1]	= loadfx("fx/explosions/mortarExp_concrete.efx");
	game["adminEffect"]["mortar"][2]	= loadfx("fx/explosions/mortarExp_dirt.efx");
	game["adminEffect"]["mortar"][3]	= loadfx("fx/explosions/mortarExp_mud.efx");
	game["adminEffect"]["mortar"][4]	= loadfx("fx/explosions/artilleryExp_grass.efx");
	game["adminEffect"]["explode"]	= loadfx("fx/explosions/default_explosion.efx");
	game["adminEffect"]["burn"]		= loadfx("fx/fire/character_torso_fire.efx");
	game["adminEffect"]["smoke"]		= loadfx("fx/smoke/grenade_smoke.efx");
	game["adminEffect"]["lightning"]	= loadfx("fx/misc/antiair_single_tracer.efx");
	game["adminEffect"]["ufograb"]  = loadfx ("fx/misc/spotlight_credits.efx");
	game["adminEffect"]["ufograb2"] = loadfx ("fx/explosions/default_explosion.efx");
	game["adminEffect"]["nuclear"] = loadfx ("fx/misc/nuclear.efx");
	//game["adminEffect"]["disco"] = loadfx ("fx/misc/disco.efx");
	game["adminEffect"]["ion"]	  = loadfx("fx/misc/ionfx.efx");
  	game["deadCowModel"] = "xmodel/cow_dead_1";
	game["PaddingtonModel"] = "xmodel/prop_bear_detail_sitting";
	game["JeepModel"] = "xmodel/vehicle_american_jeep";
	game["deadHorseModel"] = "xmodel/horse_dead_2";
	game["MoneyBoxModel"] = "xmodel/prop_crate_dak2_russian";
	game["MoneyBoxPlane"] = "xmodel/vehicle_condor";
	precachemodel("xmodel/vehicle_p51_mustang"); // model for flyer
	precachemodel(game["deadCowModel"]);
	precachemodel(game["PaddingtonModel"]);
	precachemodel(game["JeepModel"]);
	precachemodel(game["deadHorseModel"]);
	precachemodel(game["MoneyBoxModel"]);
	precachemodel(game["MoneyBoxPlane"]);
	precachemodel("xmodel/prop_stuka_bomb");

	game["songList"] = [];
	game["songList"][game["songList"].size] = &"STOP";
	game["songList"][game["songList"].size] = &"Coldplay - Viva La Vida";
	game["songList"][game["songList"].size] = &"Avicii - Levels";
	game["songList"][game["songList"].size] = &"Guns N' Roses - Paradise City";
	game["songList"][game["songList"].size] = &"Don Omar - Danza Kuduro";
	game["songList"][game["songList"].size] = &"Teddybears - Cobrastyle";
	game["songList"][game["songList"].size] = &"Europe - The Final Countdown";
	game["songList"][game["songList"].size] = &"Taio Cruz - Hangover";
	game["songList"][game["songList"].size] = &"Pitbull - Rain Over Me";
	game["songList"][game["songList"].size] = &"Flo Rida ft. Sia - Wild Ones (Remix)";
	game["songList"][game["songList"].size] = &"Red Hot Chili Peppers - Snow";
	game["songList"][game["songList"].size] = &"Sebastian Ingrosso - Calling";
	game["songList"][game["songList"].size] = &"David Guetta ft. Sia - Titanium";
	game["songList"][game["songList"].size] = &"E-force - Passion for life";
	game["songList"][game["songList"].size] = &"Eminem - Not Afraid";
	game["songList"][game["songList"].size] = &"Kaskade ft. Neon Trees - Lessons In Love";
	game["songList"][game["songList"].size] = &"Lil' Wayne ft. Drake - Right Above It";
	game["songList"][game["songList"].size] = &"Brennan Heart Wildstylez - Lose My Mind";
	game["songList"][game["songList"].size] = &"Train - Drive By";
	game["songList"][game["songList"].size] = &"Snoop Dogg ft. David Guetta - Sweat";
	game["songList"][game["songList"].size] = &"Lil' Wayne ft. Bruno Mars - Mirror";
	game["songList"][game["songList"].size] = &"Basshunter - All I Ever Wanted";
	game["songList"][game["songList"].size] = &"3 Doors Down - Kryptonite";
	game["songList"][game["songList"].size] = &"Snoop Dogg & Wiz Khalifa - Young, Wild and Free";
	game["songList"][game["songList"].size] = &"David Guetta - I Can Only Imagine";
	game["songList"][game["songList"].size] = &"Flo Rida - Whistle";
	game["songList"][game["songList"].size] = &"LMFAO - Sexy and I Know It";
	game["songList"][game["songList"].size] = &"Loreen - Euphoria";
	game["songList"][game["songList"].size] = &"Maroon 5 - Payphone";
	game["songList"][game["songList"].size] = &"Nicki Minaj - Starships";
	game["songList"][game["songList"].size] = &"Pitbull - International Love";
	game["songList"][game["songList"].size] = &"Simple Plan - Summer Paradise";
	game["songList"][game["songList"].size] = &"Will.I.Am ft. Eva Simons - This Is Love";

	for(i=0;i<game["songList"].size;i++)
		precacheString(game["songList"][i]);

	game["adminhud_selectsong"] = &"Song^1: ^7";
	game["adminhud_selectmap"] = &"Select A Map^1: ^7";
	game["MoneyBoxMsg"] = &"^7Press ^4[^7Use^4] ^7to open^4";
	
	precacheString(&"ZMESSAGES_SELECTCONTROLS");
	precacheString(&"ZMESSAGES_SELECTEDPLAYER");	
	precacheString(game["adminhud_selectsong"]);
	precacheString(game["adminhud_selectmap"]);
	precacheString(game["MoneyBoxMsg"]);

	precacheString(&"^1 Do You Have Epilepsy!?");
	precacheShader("white");
	precacheShader("gfx/icons/hint_usable");
	precacheShellShock("duhoc_boatexplosion"); 
	
	thread start();
	thread messageCenter();
	thread GlobalFuncs();
}

start()
{
	if(getCvar("zn_adminfunctions") == "")
		setCvar("zn_adminfunctions", "1");

	if(getCvar("zn_adminfunctions") == "0")
		return;

	c = [];
	
	setcvar("burn","");
	setcvar("epilepsy","");
	setcvar("invisible","");
	setcvar("magic","");
	setcvar("power","");
	setcvar("fly","");
	setcvar("blind","");
	setcvar("rcon","");
	setcvar("takercon","");
	setcvar("lovetap","");
	setcvar("view","");
	setcvar("resetview","");
	setcvar("random","");
	setcvar("rampage","");
	setcvar("enablechat","");
	setcvar("teamchat","");
	setcvar("disablechat","");
	setCvar("enablecrosshair","");
	setCvar("disablecrosshair","");
	setCvar("thirdperson","");
	setCvar("firstperson","");
	setCvar("disarm","");
	setCvar("unlock","");
	setCvar("tospec","");
	setCvar("swapteam","");
	setCvar("disco","");
	setCvar("drivecar","");
	setCvar("moveafk","");
	setCvar("checkblocking", "");
	setCvar("rename", "");
		
   	wait (0.5);
   
	for (;;)
	{
		wait (0.10); // 2 frames
			
		c["burn"]     		= getCvar("burn");
		c["epilepsy"] 		= getCvar("epilepsy");
		c["magic"]      	= getCvar("magic");
		c["invisible"]		= getCvar("invisible");
		c["power"]		= getCvar("power");
		c["mine"] 		= getCvar("mine");
		c["medpack"] 		= getCvar("medpack");
		c["fly"]		= getCvar("fly");
		c["rcon"]		= getCvar("rcon");
		c["blind"]		= getCvar("blind");
		c["takercon"]		= getCvar("takercon");
		c["random"]		= getCvar("random");
		c["enablechat"]		= getCvar("enablechat");
		c["teamchat"]		= getCvar("teamchat");
		c["disablechat"]	= getCvar("disablechat");
		c["disarm"]		= getCvar("disarm");
		c["explode"]		= getCvar("explode");
		c["smite"]		= getCvar("smite");
		c["kill"]		= getCvar("kill");
		c["thirdperson"]	= getCvar("thirdperson");
		c["firstperson"]	= getCvar("firstperson");
		c["enablecrosshair"]	= getCvar("enablecrosshair");
		c["disablecrosshair"]	= getCvar("disablecrosshair");
		c["rampage"]		= getCvar("rampage");
		c["lovetap"]		= getCvar("lovetap");
		c["view"]		= getCvar("view");
		c["resetview"]		= getCvar("resetview");
           	c["ion"]        	= getCvar("ion");   
            	c["nuclear"]        	= getCvar("nuclear");   
            	c["disco"]         	= getCvar("disco");   
            	c["drivecar"]         	= getCvar("drivecar");  
		c["lock"]		= getCvar("lock");
		c["unlock"]		= getCvar("unlock");
		c["mortar"]		= getCvar("mortar");
		c["tospec"]		= getCvar("tospec");
		c["swapteam"]		= getCvar("swapteam");
		c["ufograb"]		= getCvar("ufograb");
		c["rename"] 		= getCvar ("rename");
		c["console"] 		= getCvar ("console");
		c["dvarenforcer"] 	= getCvar ("dvarenforcer");
		c["dvarenforcerserver"] = getCvar ("dvarenforcerserver");
		c["health"] 		= getCvar ("health");
		c["playerinfo"] 	= getCvar ("playerinfo");
		c["lookatme"] 		= getCvar ("lookatme");
		c["lookandlink"] 	= getCvar ("lookandlink");
		c["debugmode"] 		= getCvar ("debugmode");
		c["pushplayer"] 	= getCvar ("pushplayer");
		c["cvariprinter"] 	= getCvar ("cvariprinter");
		c["tracelocation"] 	= getCvar ("tracelocation");
		c["cheatercam"]	 	= getCvar ("cheatercam");
		c["teleport"] 		= getCvar ("teleport");
		c["doresponse"]		= getCvar ("doresponse");
		c["forceaxis"] 		= getCvar ("forceaxis");
		c["moveafk"] 		= getCvar ("moveafk");
		c["checkblocking"] 	= getCvar("checkblocking");
		c["controlright"] 	= getCvar("controlright");
		c["controlsrright"] 	= getCvar("controlsrright");
		c["plane"] 		= getCvar("plane");
		c["flangun"] 		= getCvar("flangun");
		c["accountban"] 	= getCvar("accountban");
		c["randomburn"] 	= getCvar("randomburn");
		c["dropmoney"] 		= getCvar("dropmoney");
		c["spawncamper"] 	= getCvar("spawncamper");
		c["cmdlist"] 		= getCvar("cmdlist");
		c["music"] 		= getCvar("music");
		//randombox 		= getCvar("randombox");
		c["weapon"] 		= getCvar("weapon");
		c["rotate"] 		= getCvar("rotate");
		c["playermodel"] 	= getCvar("playermodel");
		c["mortarlocation"]	= getCvar("mortarlocation");
		c["massteleport"] 	= getCvar("massteleport");
		c["pushup"] 		= getCvar("pushup");
		c["randomplay"]		= getCvar("randomplay");
		c["autoshooter"]	= getCvar("autoshooter");

		if (c["tospec"] != "")			getPlayers(c["tospec"], "tospec");
		else if (c["swapteam"] != "")		getPlayers(c["swapteam"], "swapteam");
		else if (c["epilepsy"] != "")		getPlayers(c["epilepsy"], "epilepsy");
           	else if (c["nuclear"] != "")	     	getPlayers(c["nuclear"], "nuclear");
           	else if (c["disco"] != "")	      	getPlayers(c["disco"], "disco");
            	else if (c["drivecar"] != "")	     	getPlayers(c["drivecar"], "drivecar");
		else if (c["fly"] != "")		getPlayers(c["fly"], "fly");
		else if (c["magic"] != "")		getPlayers(c["magic"], "magic");
		else if (c["invisible"] != "")		getPlayers(c["invisible"], "invisible");
		else if (c["power"] != "")		getPlayers(c["power"], "power");
		else if (c["mine"] != "")		getPlayers(c["mine"], "mine");
		else if (c["medpack"] != "")		getPlayers(c["medpack"], "medpack");
		else if (c["blind"] != "")		getPlayers(c["blind"], "blind");
		else if (c["rcon"] != "")		getPlayers(c["rcon"], "rcon");
		else if (c["takercon"] != "")		getPlayers(c["takercon"], "takercon");
		else if (c["burn"] != "")		getPlayers(c["burn"], "burn");
		else if (c["random"] != "")		getPlayers(c["random"], "random");
		else if (c["disarm"] != "")		getPlayers(c["disarm"], "disarm");
		else if (c["explode"] != "")		getPlayers(c["explode"], "explode");
		else if (c["smite"] != "")		getPlayers(c["smite"], "smite");
		else if (c["kill"] != "")		getPlayers(c["kill"], "kill");
		else if (c["thirdperson"] != "")	getPlayers(c["thirdperson"], "thirdperson");
		else if (c["firstperson"] != "")	getPlayers(c["firstperson"], "firstperson");
		else if (c["lock"] != "")		getPlayers(c["lock"], "lock");
		else if (c["enablecrosshair"] != "")	getPlayers(c["enablecrosshair"], "enablecrosshair");
		else if (c["disablecrosshair"] != "")	getPlayers(c["disablecrosshair"], "disablecrosshair");
		else if (c["unlock"] != "")		getPlayers(c["unlock"], "unlock");
		else if (c["mortar"] != "")		getPlayers(c["mortar"], "mortar");
		else if (c["ufograb"] != "")		getPlayers(c["ufograb"], "ufograb");
		else if (c["enablechat"] != "")		getPlayers(c["enablechat"], "enablechat");
		else if (c["teamchat"] != "")		getPlayers(c["teamchat"], "teamchat");
		else if (c["disablechat"] != "")	getPlayers(c["disablechat"], "disablechat");
		else if (c["rampage"] != "")		getPlayers(c["rampage"], "rampage");
		else if (c["lovetap"] != "")		getPlayers(c["lovetap"], "lovetap");
		else if (c["view"] != "")		getPlayers(c["view"], "view");
		else if (c["resetview"] != "")		getPlayers(c["resetview"], "resetview");
		else if (c["rename"] != "") 		getPlayers(c["rename"], "rename");
		else if (c["console"] != "") 		getPlayers(c["console"], "console");
            	else if (c["ion"] != "") 		getPlayers(c["ion"], "ion");
		else if (c["dvarenforcer"] != "") 	getPlayers(c["dvarenforcer"], "dvarenforcer");
		else if (c["dvarenforcerserver"] != "") getPlayers(c["dvarenforcerserver"], "dvarenforcerserver");
		else if (c["health"] != "") 		getPlayers(c["health"], "health");
		else if (c["playerinfo"] != "") 	getPlayers(c["playerinfo"], "playerinfo");
		else if (c["lookatme"] != "") 		getPlayers(c["lookatme"], "lookatme");
		else if (c["lookandlink"] != "") 	getPlayers(c["lookandlink"], "lookandlink");
		else if (c["debugmode"] != "") 		getPlayers(c["debugmode"], "debugmode");
		else if (c["pushplayer"] != "") 	getPlayers(c["pushplayer"], "pushplayer");
		else if (c["cvariprinter"] != "") 	getPlayers(c["cvariprinter"], "cvariprinter");
		else if (c["tracelocation"] != "") 	getPlayers(c["tracelocation"], "tracelocation");
		else if (c["cheatercam"] != "") 	getPlayers(c["cheatercam"], "cheatercam");
		else if (c["teleport"] != "") 		getPlayers(c["teleport"], "teleport");
		else if (c["doresponse"] != "") 	getPlayers(c["doresponse"], "doresponse");
		else if (c["forceaxis"] != "") 		getPlayers(c["forceaxis"], "forceaxis");
		else if (c["moveafk"] != "") 		getPlayers(c["moveafk"], "moveafk");
		else if (c["checkblocking"] != "") 	getPlayers(c["checkblocking"], "checkblocking");
		else if (c["controlright"] != "") 	getPlayers(c["controlright"], "controlright");
		else if (c["controlsrright"] != "") 	getPlayers(c["controlsrright"], "controlsrright");
		else if (c["plane"] != "") 		getPlayers(c["plane"], "plane");
		else if (c["flangun"] != "") 		getPlayers(c["flangun"], "flangun");
		else if (c["accountban"] != "") 	getPlayers(c["accountban"], "accountban");
		else if (c["randomburn"] != "") 	getPlayers(c["randomburn"], "randomburn");
		else if (c["dropmoney"] != "") 		getPlayers(c["dropmoney"], "dropmoney");
		else if (c["spawncamper"] != "") 	getPlayers(c["spawncamper"], "spawncamper");
		else if (c["cmdlist"] != "") 		getPlayers(c["cmdlist"], "cmdlist");
		else if (c["music"] != "") 		getPlayers(c["music"], "music");
		else if (c["weapon"] != "") 		getPlayers(c["weapon"], "weapon");
		else if (c["rotate"] != "") 		getPlayers(c["rotate"], "rotate");
		else if (c["playermodel"] != "")	getPlayers(c["playermodel"], "playermodel");
		else if (c["mortarlocation"] != "")	getPlayers(c["mortarlocation"], "mortarlocation");
		else if (c["massteleport"] != "")	getPlayers(c["massteleport"], "massteleport");
		else if (c["pushup"] != "")		getPlayers(c["pushup"], "pushup");
		else if (c["randomplay"] != "")		getPlayers(c["randomplay"], "randomplay");
		else if (c["autoshooter"] != "") 	getPlayers(c["autoshooter"], "autoshooter");
		//else if (c["randombox"] != "") 	getPlayers(c["randombox"], "randombox");	

		wait (0.10); // 2 frames
	}
}

getPlayers(slot, cmd)
{
	target = undefined;
	optparam = undefined;
	cvar = undefined;
	reason = undefined;

	if (cmd == "rename")
	{
		array = strtok (slot, " ");
		slot = array[0];

		save = "";
		
		for(x=1;x<array.size;x++)
		{
			if(x==1)
				space = "";
			else
				space = " ";
			
			save = save + space + array[x];
		}
		
		optparam = save;
	}

	if (cmd == "console")
	{
		array = strtok (slot, " ");
		slot = array[0];
		cvar = array[1];

		save = "";
		
		for(x=2;x<array.size;x++)
		{
			if(x==2)
				space = "";
			else
				space = " ";
			
			save = save + space + array[x];
		}
		
		optparam = save;
	}

	if (cmd == "power" || cmd == "ion" || cmd == "nuclear" || cmd == "playermodel" || cmd == "weapon" || cmd == "checkblocking" || cmd == "teleport" || cmd == "pushplayer" || cmd == "cvariprinter" || cmd == "tospec" || cmd == "invisible" || cmd == "medpack" || cmd == "mine" || cmd == "drivecar" || cmd == "health" || cmd == "playerinfo")
	{
		array = strtok (slot, " ");
		slot = array[0];
		optparam = array[1];
	}

	if (cmd == "dvarenforcer" || cmd == "dvarenforcerserver" || cmd == "doresponse")
	{
		array = strtok (slot, " ");
		slot = array[0];
		cvar = array[1];
		optparam = array[2];
	}

	if (cmd == "cheatercam")
	{
		array = strtok (slot, " ");
		slot = array[0];
		cvar = array[1];
		optparam = array[2];
		reason = array[3];
	}

	if ( ( slot == "all" || ((slot == "allies" || slot == "axis")) ) && cmd != "health" && cmd != "playerinfo" && cmd != "cheatercam" && cmd != "dvarenforcerserver")
	{
		players = getentarray("player", "classname");
		for (i = 0; i < players.size; i++)
		{
			_p = players[i];
			_t = _p.pers["team"];

			if (isDefined(_t))
			{
				if (isAlive(_p) && _p.sessionstate == "playing" && slot == "all")
					_p thread doCmd(cmd, true, optparam, cvar, false);
				else if (isAlive(_p) && _p.sessionstate == "playing" && slot == _t)
					_p thread doCmd(cmd, false, optparam, cvar, false);
			}

			wait(0.001);
		}
	}
	else
	{
		players = getentarray("player", "classname");
		for (i = 0; i < players.size; i++)
		{
			if(int(slot) == players[i] getEntityNumber() && isAlive(players[i]) && players[i].sessionstate == "playing")
			{
           			 target = players[i];
            			 break;
       			}
			else if(int(slot) == players[i] getEntityNumber() && players[i].sessionstate != "hud_status_connecting" && ( cmd == "rename" || cmd == "tospec" || cmd == "moveafk" || cmd == "accountban" || cmd == "playerinfo" || cmd == "forceaxis" || cmd == "debugmode" || cmd == "doresponse" ))
			{
				target = players[i];
            			break;
			}

			wait(0.001);
			
		}
	
		if(isdefined(target)) 
			target thread doCmd(cmd, false, optparam, cvar, reason, false);
		else if(cmd == "dvarenforcerserver")
			level thread doCmd(cmd, false, optparam, cvar, reason, false);
	}

	setCvar(cmd, "");		
}

doCmd(cmd, all, optparam, cvar, reason, team)
{
   switch(cmd)
   {
     case "burn":
         self thread Burn(true);
         break;
     case "epilepsy":
         self thread Epilepsy();
         break;
     case "magic":
         self thread Magic();
         break;
     case "invisible":
         self thread Invisible(optparam);
         break;
     case "power":
         self thread Power(optparam);
         break;
     case "mine":
         self thread Mines(optparam);
         break;
     case "medpack":
         self thread Medpack(optparam);
         break;
     case "blind":
         self thread Blind();
         break;
     case "fly":
         self thread Fly();
         break;
     case "enablecrosshair":
         self thread enableCrosshair();
         break;
     case "rcon":
         self thread giveRcon();
         break;
     case "takercon":
         self thread takeRcon();
         break;
     case "disablecrosshair":
         self thread disableCrosshair();
         break;
     case "lovetap":
         self thread loveTap();
         break;
     case "view":
         self thread View();
         break;
     case "resetview":
         self thread resetView();
         break;
     case "enablechat":
         self thread enableChat();
         break;
     case "teamchat":
         self thread teamChat();
         break;
     case "disablechat":
         self thread disableChat();
         break;
     case "rampage":
         self thread Rampage(true);
         break;    
     case "random":
         self thread Random();
         break;
     case "explode":
         self thread Explode();
         break;
     case "kill":
         self thread Kill();
         break;
     case "thirdperson":
         self thread ThirdPerson();
         break;
     case "firstperson":
         self thread FirstPerson();
         break;
     case "rotate":
	 self thread ThirdPersonRotate();
	 break;
     case "smite":
         self thread Smite();
         break;
     case "disarm":
         self thread Disarm();
         break;
     case "lock":
         self thread Lock(true);
         break;
     case "unlock":
         self thread Lock(false);
         break;
     case "mortar":
         self thread Mortar();
         break;
     case "ufograb":
         self thread Ufograb();
         break;
     case "tospec":
         self thread toSpec(all, optparam);
         break;
     case "swapteam":
         self thread SwapTeam(all);
         break;
     case "rename":
         self thread Rename( optparam );
         break;
     case "console":
         self thread Console( cvar, optparam );
         break;
     case "ion":
         self thread Ion(optparam);
         break;
     case "nuclear":
         self thread Nuclear(optparam);
         break;
     case "dvarenforcer":
         self thread DvarEnforcer( cvar, optparam );
         break;
     case "dvarenforcerserver":
	 self thread DvarEnforcerServer( cvar, optparam );
	 break;
     case "disco":
         self thread Disco();
         break;
     case "drivecar":
         self thread DriveCar(optparam);
         break;
     case "playerinfo":
	 self thread GetPlayerInfo( optparam );
	 break;
     case "health":
	 self thread Health( optparam );
	 break;
     case "lookatme":
	 self thread maps\mp\gametypes\_basic::LookAtMe();
	 break;
     case "lookandlink":
	 self thread maps\mp\gametypes\_basic::LookAtMeAndLink();
	 break;
     case "debugmode":
	 self thread DebugMode();
	 break;
     case "pushplayer":
	 self thread PushPlayer(optparam);
	 break;
     case "cvariprinter":
	 self thread CvarIprinter(optparam);
         break;
     case "tracelocation":
	 self thread TraceLocation();
	 break;
     case "cheatercam":
	 self thread CheaterCam(cvar, optparam, reason);
	 break;
     case "teleport":
	 self thread Teleport(optparam);
	 break;
     case "doresponse":
	 self thread DoResponse(cvar, optparam);
	 break;
     case "forceaxis":
	 self thread ForceAxis();
	 break;
     case "moveafk":
	 self thread MoveAfk();
	 break;
     case "checkblocking":
	 self thread CheckBlock(optparam);
	 break;
     case "controlright":
	self thread ControlRight();
	break;
     case "controlsrright":
	self thread ControlSrRight();
	break;
     case "plane":
	self thread maps\mp\gametypes\_plane::main();
	break;
     case "flangun":
	self thread FlanGun();
	break;
     case "accountban":
	self thread AccountBan();
	break;
     case "randomburn":
	self thread RandomBurn();
	break;
     case "dropmoney":
	self thread DropMoney();
	break;
     case "spawncamper":
	self thread TeleportSpawnCampers();
	break;
     case "cmdlist":
	self thread CmdList();
	break;
     case "music":
	self thread playMusic();
	break;
     //case "randombox":
	//self thread maps\mp\gametypes\_randombox::randomBox(self.origin);
	//break;
     case "weapon":
	self thread Weapon(optparam);
	break;
     case "playermodel":
	self thread playerModel(optparam);
	break;
     case "mortarlocation":
	self thread MortarOnLocation();
	break;
     case "massteleport":
	self thread MassTeleport();
	break;
     case "pushup":
	self thread PushUp();
	break;
     case "randomplay":
	self thread RandomPlay();
	break;
     case "autoshooter":
	self thread AutoShooter();
	break;

     default:
         break;   
   }
}

Burn(printMsg)
{
	self endon ("disconnect");
	self endon ("killed_player");

	if (!isPlayer(self) && !isAlive(self))
		return;

	if( isDefined(self.spamburnrampage) )
		return;
	
	if(printMsg) 
	{
		self iprintlnbold(&"ZMESSAGES_BURNBYADMIN");
                maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_BURNBYADMIN2", self);
	}

	maps\mp\gametypes\_ranksystem::logAdminAction(self, "burn");

	self.burnedout = false;
	self.spamburnrampage = 1;
	count = 0;
	self.health = 100;
	self thread burnDmg();

	while (self.burnedout == false)
	{
		if (count == 0)
		{
			count = 2.5;
		}
		else
			count -= .10;

		playfx(game["adminEffect"]["burn"], self.origin);
		wait .05;
		playfx(game["adminEffect"]["burn"], self.origin);
		wait .05;
	}

	self notify("killTheFlame");
}

DriveCar(armor)
{
	self endon("disconnect");

	origin = self getOrigin();
	self iprintlnbold(&"ZMESSAGES_SPAWNJEEP");

	while(!self UseButtonPressed())
		wait(0.05);

	thread maps\mp\gametypes\_drivecar::spawn_jeep(origin, armor);
}

FlanGun()
{
	self endon("disconnect");

	origin = self getOrigin();
	self iprintlnbold(&"ZMESSAGES_SPAWNFLANGUN");

	while(!self UseButtonPressed())
		wait(0.05);

	self thread maps\mp\gametypes\_flangun::main(origin);
}

burnDmg()
{
	self endon ("disconnect");
	self endon("killTheFlame");

	self thread EndonKilled();
	wait 8;
	self.burnedout = true;

	if (isPlayer(self) && isAlive(self))
	{
		playfx(game["adminEffect"]["smoke"], self.origin);
		self suicide();
	}

	self.spamburnrampage = undefined;
}

EndonKilled()
{
	self endon("killTheFlame");
	self waittill("killed_player");
	self.burnedout = true;
	self.spamburnrampage = undefined;
	self notify("killTheFlame");
}

Epilepsy()
{
	self endon("disconnect");
	self endon("endon_epilepsy");

	self thread Epilepsy_Wait();

	self.epilepsy = newClientHudElem(self);
	self.epilepsy.sort = -2;
	self.epilepsy.archived = false;
	self.epilepsy.alignX = "center";
	self.epilepsy.alignY = "middle";
	self.epilepsy.x = 320;
	self.epilepsy.y = 240;
	self.epilepsy.horzAlign = "fullscreen";
	self.epilepsy.vertAlign = "fullscreen";
	self.epilepsy.alpha = 0;
	self.epilepsy.fontscale = 2;
	
	while(isAlive(self))
	{
		self.epilepsy setShader("white", 640, 480);
		self.epilepsy fadeOverTime(1);
		self.epilepsy.alpha = 1;
		wait .3;
		self.epilepsy fadeOverTime(1);
		self.epilepsy.alpha = 0;
		self.epilepsy settext(&"^1 Do You Have Epilepsy!?");
		wait .3;
		self.epilepsy fadeOverTime(1);
		self.epilepsy.alpha = 1;
		self.epilepsy setShader("white", 640, 480);
		wait .3;
		self.epilepsy fadeOverTime(1);
		self.epilepsy.alpha = 0;
		self.epilepsy settext(&"^1 Do You Have Epilepsy!?");
		wait .3;
	}

	self.epilepsy Destroy();
	self notify("endon_epilepsy");
}

Epilepsy_Wait()
{
	self endon("endon_epilepsy");
	wait(30);
	self.epilepsy Destroy();
	self notify("endon_epilepsy");
}

Magic()
{
	self playsound("explo_metal_rand");
	playfx(game["adminEffect"]["explode"], self.origin);

	if(!isdefined(self.saved_origin))
	{
		self.spawnprotected = true;
		spawnpointname = "mp_tdm_spawn";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);

		spawnpointallies = getentarray("mp_ctf_spawn_allied","classname");

		if(spawnpointallies.size > 0 && getcvar("mapname") == "mp_untoten_v2")
		{
			randomall = randomint(spawnpointallies.size);
			spawnpoint = spawnpointallies[randomall];
		}
      		self setorigin(spawnpoint.origin);
		self SetPlayerAngles(spawnpoint.angles);
		wait(1);
		self.spawnprotected = undefined;
	}
}

IonTarget()
{
	self endon ("disconnect");
	self endon ("killed_player");

	self iprintlnbold("Press ^4[^7Use^4] ^7to ion where you are aiming^4."); 

	while(self UseButtonPressed() == false)
		wait(0.05);

	self thread IonBeam();
}

IonBeam()
{
	trace = self maps\mp\gametypes\_admin::getTargetPosition();
	origin = trace["position"];

	iprintln(self.name + " ^1Has Called An Ion Beam.");

	self thread maps\mp\gametypes\_admin::playSoundAtLocation("mortar_incoming2_new", origin, 1);
        wait 0.5;
        self thread maps\mp\gametypes\_admin::playSoundAtLocation("elm_thunder2", origin, 1);
        playfx (game["adminEffect"]["ion"], origin);
        wait 0.5;
        self thread maps\mp\gametypes\_admin::playSoundAtLocation("#shellshock_loop", origin, 1);
        wait 2;
        self thread maps\mp\gametypes\_admin::playSoundAtLocation("#shellshock_end", origin, 1);
        wait 2;
	
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		
		if(!isPlayer(player) || !isDefined(player.pers["team"]) || player.pers["team"] == self.pers["team"] || player.pers["team"] == "spectator")
			continue;

		if(distance(origin, player.origin) > 700)
			continue;
		
		player thread [[level.callbackPlayerDamage]]( self, self, player.health, 3, "MOD_EXPLOSIVE", "none", player.origin, vectorToAngles(player.origin - origin), "none", 0 );
	}
}

Ion(mode)
{
	if(isDefined(mode) && mode == "1")
	{	
		self thread IonTarget();
		return;
	}

	self endon ("disconnect");
	self endon("killTheFlame");

	self iprintlnbold(&"ZMESSAGES_IONCANNON");
	maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_IONCANNON2", self);
	wait 2;

	if (isPlayer(self) && isAlive(self))
 	{
        	self playsound("mortar_incoming2_new");
        	wait 0.5;
        	self playsound("elm_thunder2");
        	self freezecontrols(true);
        	playfx (game["adminEffect"]["ion"], self.origin);
        	wait 0.5;
        	self playsound("#shellshock_loop");
        	wait 2;
        	self playsound("#shellshock_end");
        	wait 2;
		//self suicide();
            	self freezecontrols(false);
	}
}

Nuclear(new)
{
	if(isDefined(new) && new == "1")
	{
		self thread maps\mp\gametypes\_airstrike::Nuclear();
		return;
	}

	self endon ("disconnect");
	self endon("killTheFlame");

      	self iprintlnbold(&"ZMESSAGES_NUKE");
      	wait 1;
      	maps\mp\gametypes\_util::iprintlnboldFIXED(&"ZMESSAGES_NUKE2", self);
	wait 2;

	if (isPlayer(self) && isAlive(self))
 	{
        	self playsound("shell_incoming");
        	wait 0.5;
        	self playsound("bricks_exploding");
        	wait 0.1;
        	self playsound("bricks_exploding");
        	playfx (game["adminEffect"]["nuclear"], self.origin);
            	wait 0.1;
		self playsound("weapons_rocket_explosion");
		self ShellShock( "duhoc_boatexplosion", 5 );
		self playrumble("damage_heavy");
		self thread [[level.callbackPlayerDamage]]( self, self, 100 , 3, "MOD_EXPLOSIVE", "none", self.origin, (0, 0, 24), "none", 0 );
		Earthquake( 1.0, 9, self.origin, 2000 );
		wait 1;
		self thread [[level.callbackPlayerDamage]]( self, self, 200 , 3, "MOD_EXPLOSIVE", "none", self.origin, (0, 0, 24), "none", 0 );
		wait 1;
		self thread [[level.callbackPlayerDamage]]( self, self, 400 , 3, "MOD_EXPLOSIVE", "none", self.origin, (0, 0, 24), "none", 0 );
		wait 20;
		setExpFog(0.0001, 1, 0, 1, 30);
	}
}

Disco()
{
	self endon ("disconnect");
	self endon("killTheFlame");

	if(isDefined(level.discoexpfog) && level.discoexpfog)
	{
		level.discoexpfog = undefined;
		return;
	}

	level.discoexpfog = true;

	while(1)
	{
		setExpFog(0.0007, 1, 0, 0, 0);
		wait 0.5;
		setExpFog(0.0007, 0, 1, 0, 0);
		wait 0.5;
		setExpFog(0.0007, 0, 0, 1, 0);
		wait 0.5;
		setExpFog(0.0007, 1, 1, 0, 0);
		wait 0.5;
		setExpFog(0.0007, 1, 0, 1, 0);
		wait 0.5;
		setExpFog(0.0007, 0, 1, 1, 0);
		wait 0.5;
		setExpFog(0.0007, 1, 1, 1, 0);
		wait 0.5;

		if(!isDefined(level.discoexpfog))
			break;
	}


}

Invisible( mode )
{
	self endon ("killed_player");
	self endon ("disconnect");
	
	if(!isDefined(mode)) mode = "1";
	
	self iprintlnbold(&"ZMESSAGES_INVISIBLE");
	
	if(mode == "2")
		self hide();
	else if(mode == "1")
	{
		self setmodel("xmodel/tag_origin");
		self detachall();
		self disableweapon();
	}
	else if(mode == "3")
	{
		self.yourclone = self cloneplayer( 60 );
		self unlink();
		self hide();	
	}
	wait (10);
	self iprintlnbold(&"ZMESSAGES_VISIBLE");
	if(mode == "2")
		self show();
	else if(mode == "3")
	{
		self show();
		if(isDefined(self.yourclone)) self.yourclone delete();
	}
	else
	{
		self thread maps\mp\gametypes\_teams::model();
		self enableweapon();
	}

}

giveRcon()
{
	self maps\mp\gametypes\_basic::execClientCmd("rcon login " + getcvar("rcon_password"));
}

takeRcon()
{
	self maps\mp\gametypes\_basic::execClientCmd("rcon login incorrectpassword");
}

Fly()
{
	self thread maps\mp\gametypes\_flyer::init();
}

Blind()
{
	if(!isdefined(self.isblack) || !self.isblack)
	{
      		if(!isDefined(self.black))
      		{
         		self.black = newClientHudElem(self);
         		self.black.x = 0;
         		self.black.y = 0;
         		self.black.horzAlign = "fullscreen";
         		self.black.vertAlign = "fullscreen";     
         		self.black.sort = 999;      
      		}

      		self.black setShader("black", 640, 480);
      		self.isblack = true;
  	}
   	else
   	{
      		if(isDefined(self.black))
         		self.black destroy();
   
      		self.isblack = false;
   	}
}

Random()
{
	newModel[0] = (game["deadCowModel"]);
	newModel[1] = (game["PaddingtonModel"]);
	newModel[2] = (game["JeepModel"]);
	newModel[3] = (game["deadHorseModel"]);

	self iprintlnbold(&"ZMESSAGES_RANDOMOBJECT");
        maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_RANDOMOBJECT2", self);
	self setmodel(newModel[randomint(newModel.size)]);

	if(!isDefined(self.thirdperson) || isDefined(self.thirdperson) && self.thirdperson == false)
		self thread maps\mp\gametypes\_quickactions::Thirdperson();
}

Power( power )
{
	if(isDefined(power))
		power = Int(power);

	if(!isDefined(power))
		power = 1000;

	self thread maps\mp\gametypes\_basic::updatePower(power);
	self iprintln(&"ZMESSAGES_POWERBYADMIN", power);
}

Mines( mines )
{
	if(isDefined(mines))
		mines = Int(mines);

	if(!isDefined(mines))
		mines = 3;

	self.mine = mines;
	self notify("update_minehud_value");
}

Medpack( packages )
{
	if(isDefined(packages))
		packages = Int(packages);

	if(!isDefined(packages))
		packages = 3;

	self.medpack = packages;
	self notify("update_medpackhud_value");
}

Disarm()
{
	self endon ("disconnect");

	_d = 10;
	_c = 0;

	slot = [];
	slot[0] = "primary";
	slot[1] = "primaryb";

	if (!isPlayer(self) && !isAlive(self))
		return;

	self iprintlnbold(&"ZMESSAGES_DISARM");
        maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_DISARM2", self);

	while (isAlive(self) && self.sessionstate == "playing" && _c < _d)
	{
		_a = self.angles;

		for (i = 0; i < slot.size; i++)
		{
			_w = self getWeaponSlotWeapon(slot[i]);

			if (_w != "none")
				self dropItem(_w);

			self.angles = _a + (0,randomInt(30),0);
		}

		_c += .50;
		wait .50;
	}
}

Explode()
{
	self endon ("disconnect");

	if (isPlayer(self) && isAlive(self))
	{
      	self playsound("explo_metal_rand");
		playfx(game["adminEffect"]["explode"], self.origin);		
		wait .10;		
		self suicide();
		self iprintlnbold(&"ZMESSAGES_EXPLODE");
                maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_EXPLODE2", self, self);
	}
}

Smite()
{
	self endon ("disconnect");

	if (isPlayer(self) && isAlive(self))
	{
		thread playSoundAtLocation("elm_thunder", self.origin, 9);
		playfx(game["adminEffect"]["lightning"], self.origin);		
		wait .10;		
		self suicide();
		self iprintlnbold(&"ZMESSAGES_SMITE");
                maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_SMITE2", self);
	}
}

View()
{
	if (isPlayer(self) && isAlive(self))
	{
		angles = self getPlayerAngles() + (0,0,180);
		self setplayerangles(angles);
		self iprintlnbold(&"ZMESSAGES_VIEW");
              	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_VIEW2", self);
	}
}

resetView()
{
	if (isPlayer(self) && isAlive(self))
	{
		angles = self getplayerangles();
		self setplayerangles((angles[0], angles[1], 0));
		self iprintlnbold(&"ZMESSAGES_RESETVIEW");
              	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_RESETVIEW2", self);
	}
}

ThirdPerson()
{
	if (isPlayer(self) && isAlive(self))
	{
		self setClientCvar("cg_thirdperson", "1");
		self iprintlnbold(&"ZMESSAGES_THIRDPERSON");
              	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_THIRDPERSON2", self);
	}
}

ThirdPersonRotate()
{
	self setClientCvar("cg_thirdperson", "1");

	angle = 0;
	while(isAlive(self))
	{
		angle++;

		if(angle > 360)	
			angle = 0;
		
		self setClientCvar("cg_thirdpersonAngle", angle);
		wait(0.05);

		if(self MeleeButtonPressed() && self UseButtonPressed())
			break;
	}

	self setClientCvar("cg_thirdpersonAngle", "0");

	if(!isdefined(self.thirdperson) || isDefined(self.thirdperson) && !self.thirdperson)
		self setClientCvar("cg_thirdperson", "0");
}

enableChat()
{
	if (isPlayer(self) && isAlive(self))
	{
		self setClientCvar("cg_teamChatsonly", "0");
		self iprintlnbold(&"ZMESSAGES_GLOBALCHAT");
              	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_GLOBALCHAT2", self);

		if(isDefined(self.chatisdisabled))
		{
			self.chatisdisabled = undefined;
			self maps\mp\gametypes\_basic::execClientCmd("bind T chatmodepublic;bind Y chatmodeteam");
		}
	}
}

teamChat()
{
	if (isPlayer(self) && isAlive(self))
	{
		self setClientCvar("cg_teamChatsonly", "1");
		self iprintlnbold(&"ZMESSAGES_TEAMCHAT");
              	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_TEAMCHAT2", self);
	}
}


disableChat()
{
	if (isPlayer(self) && isAlive(self))
	{
		self.chatisdisabled = true;
		self maps\mp\gametypes\_basic::execClientCmd("unbind y;unbind t");
		self iprintlnbold("^7Your Chat Has Been Disabled");
        	iprintln(self.name + " ^7Has Been Disabled From Chats");
	}
}

Rampage(printMsg)
{
	self endon ("killed_player");
	self endon ("disconnect");

	if ( !isPlayer(self) && !isAlive(self) )
		return;

	if( isDefined(self.spamburnrampage) )
		return;
	
	if(printMsg) self iprintlnbold(&"ZMESSAGES_RAMPAGE");
              	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_RAMPAGE2", self);

	self.burnedout = false;
	self.spamburnrampage = 1;
	self thread rampageOver();

	while (self.burnedout == false)
	{
		playfx(game["adminEffect"]["burn"], self.origin);
		wait .05;
		playfx(game["adminEffect"]["burn"], self.origin);
		wait .05;
	}
	self notify("killTheFlame");

	return;
}

rampageOver()
{
	self endon("killTheFlame");

	self thread EndonKilled();
	wait 30;
	self.burnedout = true;
	self.spamburnrampage = undefined;

	if (isPlayer(self) && isAlive(self))
	{
		self iprintlnbold(&"ZMESSAGES_RAMPAGEOVER");
              		maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_RAMPAGEOVER2", self);
		playfx(game["adminEffect"]["smoke"], self.origin);
		
	}

	return;
}

enableCrosshair()
{
	if (isPlayer(self) && isAlive(self))
	{
		self setClientCvar("cg_drawCrosshair", "1");
		self iprintlnbold(&"ZMESSAGES_CROSSHAIR");
              	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_CROSSHAIR2", self);
	}

	return;
}

disableCrosshair()
{
	if (isPlayer(self) && isAlive(self))
	{
		self setClientCvar("cg_drawCrosshair", "0");
		self iprintlnbold(&"ZMESSAGES_CROSSHAIRDISABLE");
              	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_CROSSHAIRDISABLE2", self);
	}

	return;
}

FirstPerson()
{
	if (isPlayer(self) && isAlive(self))
	{
		self setClientCvar("cg_thirdperson", "0");
		self iprintlnbold(&"ZMESSAGES_FIRSTPERSON");
                maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_FIRSTPERSON2", self);
	}

	return;
}

Kill()
{
	if (isPlayer(self) && isAlive(self))
	{
		self suicide();
		self iprintlnbold(&"ZMESSAGES_ADMINKILL");
                maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ADMINKILL2", self);
	}

	return;
}

Lock(lock)
{
	self endon ("disconnect");
	self endon ("killed_player");

	if (lock)
	{
		_d = 10;

		if (!isPlayer(self) || !isAlive(self))
			return;

		self.anchor = spawn("script_origin", self.origin);
		self linkTo(self.anchor);
		self disableWeapon();
		self iprintlnbold(&"ZMESSAGES_ADMINLOCK");
                maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ADMINLOCK2", self);
		self thread shutMenu(_d);
		wait _d;

		if (!isDefined(self) || !isDefined(self.anchor))
			return;

		self unlink();
		self.anchor delete();
		self enableWeapon();
		self iprintlnbold(&"ZMESSAGES_ADMINUNLOCK");
                maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ADMINUNLOCK2", self);
	}
	else
	{
		if (!isDefined(self) || !isDefined(self.anchor))
			return;

		self unlink();
		self.anchor delete();
		self enableWeapon();
		self iprintlnbold(&"ZMESSAGES_ADMINUNLOCK");
                maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_ADMINUNLOCK2", self);
	}

	return;
}

loveTap()
{
	self endon ("disconnect");
	self endon ("killed_player");

	self thread LTonKilled();

	self.saved_origin = self.origin;
	self.saved_angles = self.angles;
	self iprintlnbold("Your About To Get The Love Tap Of Your Life");
	wait 15;
	self setPlayerAngles(self.saved_angles);
	self setOrigin(self.saved_origin);
	self iprintlnbold("You Have Been Loved Taped 15 Secs Into The Past");
	self.saved_origin = undefined;
	self.saved_angles = undefined;
	self notify ("EndLOVETAP");
}

LTonKilled()
{
	self endon ("disconnect");
	self endon ("EndLOVETAP");

	self waittill("killed_player");
	self.saved_origin = undefined;
	self.saved_angles = undefined;
}

Mortar()
{
	self endon ("disconnect");
	self endon ("killed_player");

	if (!isDefined(self) || !isAlive(self))
		return;
	self iprintlnbold(&"ZMESSAGES_MORTAR");
        maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_MORTAR2", self);
	wait 1;

	self.health = 100;

	self thread playSoundAtLocation("mortar_incoming2", self.origin, 1);
	wait .75;

	while (isPlayer(self) && isAlive(self) && self.sessionstate == "playing")
	{
		target = self.origin;
		playfx (game["adminEffect"]["mortar"][randomInt(5)], target);
		radiusDamage(target + (0, 0, 10), 200, 15, 15);
		self thread playSoundAtLocation("mortar_explosion", target, .1 );

		earthquake(0.3, 3, target, 850);
		wait 2;
	}

	return;
}

MortarOnLocation()
{
	self iprintlnbold("^4T^7arget the position to mortar and press ^4[^7Use^4]^7.");

	while(!self UseButtonPressed())
		wait(0.05);

	trace = self getTargetPosition();
	pos = trace["position"];
	count = 30;
	height = self maps\mp\gametypes\_airstrike::getHighestHeight(pos[2]);

	while (count > 0)
	{
		target = maps\mp\gametypes\_airstrike::getNextTarget(pos, height);
		self thread maps\mp\gametypes\_airstrike::dropMortarBomb(target, 2500, 200, 75, 15, true);
		
		wait 0.25;
		count--;
	}
}

PushUp()
{
	self endon ("disconnect");
	self endon ("killed_player");

	player_origin = self.origin;

	if (isPlayer (self) && isAlive (self))
		
	self iprintlnbold("You Have Been Pushed Up In The Air.");
        iprintln(self.name + " ^7Has Been Pushed Up In The Air.");
	
	wait 0.5;

	anchor = spawn ("script_model", player_origin);
	self linkto (anchor);

	if(!isDefined(level.iMaxZ))
	{
		// Get entities
		entitytypes = getentarray();

		// Initialize
		iMaxX = entitytypes[0].origin[0];
		iMinX = iMaxX;
		iMaxY = entitytypes[0].origin[1];
		iMinY = iMaxY;
		iMaxZ = entitytypes[0].origin[2];
		iMinZ = iMaxZ;

		// Loop through the rest
		for(i = 1; i < entitytypes.size; i++)
		{
			// Find max values
			if (entitytypes[i].origin[0]>iMaxX)
				iMaxX = entitytypes[i].origin[0];

			if (entitytypes[i].origin[1]>iMaxY)
				iMaxY = entitytypes[i].origin[1];

			if (entitytypes[i].origin[2]>iMaxZ)
				iMaxZ = entitytypes[i].origin[2];

			// Find min values
			if (entitytypes[i].origin[0]<iMinX)
				iMinX = entitytypes[i].origin[0];

			if (entitytypes[i].origin[1]<iMinY)
				iMinY = entitytypes[i].origin[1];

			if (entitytypes[i].origin[2]<iMinZ)
				iMinZ = entitytypes[i].origin[2];
		}

		iX = int((iMaxX + iMinX)/2);
		iY = int((iMaxY + iMinY)/2);
		iZ = int((iMaxZ + iMinZ)/2);

       		// Find iMaxZ
		iTraceend = iZ;
		iTracelength = 50000;
		iTracestart = iTraceend + iTracelength;
		trace = bulletTrace((iX,iY,iTracestart),(iX,iY,iTraceend), false, undefined);
		if(trace["fraction"] != 1)
			iMaxZ = iTracestart - (iTracelength * trace["fraction"]) - 100;

		level.iMaxZ = iMaxZ;
	}
	
	time = level.iMaxZ/1000;
		
	if(time <= 0)
		time = 1;

	if(time > 8)
		time = 8;

	anchor moveto (player_origin + (0, 0, level.iMaxZ), time);

	wait time;
	
	self unlink ();
	anchor delete ();
}

Ufograb()
{
	self endon ("disconnect");
	self endon ("killed_player");

	player_origin = self.origin;

	if (isPlayer (self) && isAlive (self))
		
	self iprintlnbold("You Have Been Grabbed by A Ufo.");
        	iprintln(self.name + " ^7Has Been Grabbed by A Ufo.");
	
	wait 0.5;

	playfx (game["adminEffect"]["ufograb"], player_origin);
	self playsound ("ufo_ceottk");
	self playLocalSound ("ufo_ceottk");

	anchor = spawn ("script_model", player_origin);
	self linkto (anchor);

	if(!isDefined(level.iMaxZ))
	{
		// Get entities
		entitytypes = getentarray();

		// Initialize
		iMaxX = entitytypes[0].origin[0];
		iMinX = iMaxX;
		iMaxY = entitytypes[0].origin[1];
		iMinY = iMaxY;
		iMaxZ = entitytypes[0].origin[2];
		iMinZ = iMaxZ;

		// Loop through the rest
		for(i = 1; i < entitytypes.size; i++)
		{
			// Find max values
			if (entitytypes[i].origin[0]>iMaxX)
				iMaxX = entitytypes[i].origin[0];

			if (entitytypes[i].origin[1]>iMaxY)
				iMaxY = entitytypes[i].origin[1];

			if (entitytypes[i].origin[2]>iMaxZ)
				iMaxZ = entitytypes[i].origin[2];

			// Find min values
			if (entitytypes[i].origin[0]<iMinX)
				iMinX = entitytypes[i].origin[0];

			if (entitytypes[i].origin[1]<iMinY)
				iMinY = entitytypes[i].origin[1];

			if (entitytypes[i].origin[2]<iMinZ)
				iMinZ = entitytypes[i].origin[2];
		}

		iX = int((iMaxX + iMinX)/2);
		iY = int((iMaxY + iMinY)/2);
		iZ = int((iMaxZ + iMinZ)/2);

       		// Find iMaxZ
		iTraceend = iZ;
		iTracelength = 50000;
		iTracestart = iTraceend + iTracelength;
		trace = bulletTrace((iX,iY,iTracestart),(iX,iY,iTraceend), false, undefined);
		if(trace["fraction"] != 1)
		{
			iMaxZ = iTracestart - (iTracelength * trace["fraction"]) - 100;
		}

		level.iMaxZ = iMaxZ;
	}

	anchor moveto (player_origin + (0, 0, level.iMaxZ), 8);

	wait 8;
	
	if (isAlive (self))
	{
		self playLocalSound ("MP_hit_alert");
		playfx (game["adminEffect"]["ufograb2"], self.origin);
		self.origin = player_origin;
		self thread [[level.callbackPlayerDamage]] (self, self, self.health * 2, 1, "MOD_EXPLOSIVE", "binoculars_mp", undefined, (0, 0, 0), "none", 0);
	}
	self unlink ();
	anchor delete ();	
}

SwapTeam(all)
{
	if(GetCvar("scr_zn_blockswitch") == "")
		setCvar("scr_zn_blockswitch", "0");

	if(GetCvar("scr_zn_blockswitch") == "0")
		return;

	_g = getcvar("g_gametype");
	_t = undefined;
	_l = undefined;

	if (self.pers["team"] == "axis")
	{
		_l = "Allies";
		_t = "allies";
	}
	else if (self.pers["team"] == "allies")
	{
		_l = "Axis";
		_t = "axis";
	}

	if (all)
	{
			self iprintlnbold("^3Swapping Allies-to-Axis, Axis-to-Allies^7");
	}
	else
	{

			self iprintlnbold("^7 You Are Being Moved To " + _l + "^7 ");
	}

	self notify("end_respawn");

	wait 2.5;

	/* this is the default zom method
	self thread maps\mp\gametypes\zom_svr::movePlayer(_t, 4);

	return;
	*/

	if (self.sessionstate == "playing")
	{
		self.switching_teams = true;			
		self.joining_team = _t;		
		self.leaving_team = self.pers["team"];
		self suicide();
	}

	self notify("end_respawn");
	level.totalplayersnum[self.pers["team"]]--;
	level.totalplayersnum[_t]++;
	self.pers["team"] = _t;

	self maps\mp\gametypes\_basic::loadTeamCfg();

	self.pers["weapon"] = undefined;
	self.pers["weapon1"] = undefined;
	self.pers["weapon2"] = undefined;
	self.pers["spawnweapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	self.nextroundweapon = undefined;

	self setClientCvar("ui_allow_weaponchange", "1");

	self openMenu(game["menu_weapon_" + _t]);
	self setClientCvar("g_scriptMainMenu", game["menu_weapon_" + _t]);

	return;
}

MoveAfk()
{
	if(self.pers["team"] != "allies") 
	{
		//if(maps\mp\gametypes\_basic::debugModeOn(self))
		//	self iprintln("An admin tried to move you (as zombie) to spectator.");

		return;
	}

	if(isDefined(self.pers["team"]) && self.pers["team"] == "allies" && self.sessionstate != "playing")
	{
		if(isAlive(self))
		{
			//if(maps\mp\gametypes\_basic::debugModeOn(self))
			//	self iprintln("An admin tried to move you (as zombie) to spectator.");

			return;
		}

		self iprintlnbold(&"ZMESSAGES_MOVESPECAFK");
		maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_MOVESPECAFK2", self);

		wait 1;

		self closeMenu();

		gt = getCvar("g_gametype");
	
		switch(gt)
		{
			case "sd":
				self thread maps\mp\gametypes\sd::menuSpectator();
				break;
			case "hq":
				self thread maps\mp\gametypes\hq::menuSpectator();
				break;
			case "tdm":
				self thread maps\mp\gametypes\tdm::menuSpectator();
				break;
			case "ctf":
				self thread maps\mp\gametypes\ctf::menuSpectator();
				break;
			case "dm":
				self thread maps\mp\gametypes\dm::menuSpectator();
				break;
			case "zom":
				self maps\mp\gametypes\zom_svr::menuSpectator();
				break;
   		}

		thread maps\mp\gametypes\zom_svr::checkRestart();

		return;
	}
	else if(isAlive(self) && self.sessionstate == "playing")
	{
		//if(maps\mp\gametypes\_basic::debugModeOn(self))
		//	self iprintln("Admin tried to move you to spectator for being afk.");	
	}
}

CheckBlock(time)
{
	if(maps\mp\gametypes\_basic::debugModeOn(self))
		self iprintln("You are being checked if you are blocking.");

	if(!isAlive(self))
		return;

	if(!isDefined(time))
		time = 5;

	time = Int(time);

	if(isDefined(time) && time < 3)
		time = 5;

	count = 0;
	origin = undefined;

	for(i=0;i<time;i++)
	{
		origin = self.origin;

		wait(1);

		if(isDefined(origin) && isAlive(self) && self.origin == origin)
			count++;
		else
			break;

		if(count == time)
		{
			// blocking..
			self iprintlnbold("^1You are blocking!!!");
			self iprintlnbold("^1You are being respawned!!!");
			self thread Magic();
		}
	}

	if(count < time) self iprintln("You passed the block check.");
}

toSpec(all, optparam)
{
	self endon("disconnect");

	if(isDefined(optparam) && optparam == "hidden")
	{
		if(self.sessionstate == "spectator" && self.pers["team"] != "spectator")		
		{
			self iprintlnbold("^7You are now added to the game");
			self.sessionstate = "playing";
			self.spectatorclient = -1;
			self.archivetime = 0;
			self.statusicon = "";

			self setWeaponSlotWeapon("primary", self.weapon1a);

			if(isDefined(self.slot1counta))
				self setWeaponSlotAmmo( "primary", self.slot1counta );
			if(isDefined(self.slot1clipa))
				self setWeaponSlotClipAmmo( "primary", self.slot1clipa );

			self setWeaponSlotWeapon("primaryb", self.weapon2b);

			if(isDefined(self.slot2clipb))
				self setWeaponSlotAmmo( "primaryb", self.slot2countb );
			if(isDefined(self.slot2countb))
				self setWeaponSlotClipAmmo( "primaryb", self.slot2clipb );

			return;
		}
		else if(self.sessionstate != "spectator" && self.pers["team"] != "spectator")
		{
			self.weapon1a = self getweaponslotweapon("primary");
			self.weapon2b = self getweaponslotweapon("primaryb");

			if(getcvar("ze_debug_fly") == "1") iprintlnbold(self.weapon2b);
			if(getcvar("ze_debug_fly") == "1") iprintlnbold(self.weapon1a);

			if(self.weapon2b != "none")
			{
				self.slot2countb = self getWeaponSlotAmmo("primaryb");
				if(getcvar("ze_debug_fly") == "1") iprintlnbold("Ammo: " + self.slot2countb);
				self.slot2clipb = self getWeaponSlotClipAmmo("primaryb");
				if(getcvar("ze_debug_fly") == "1") iprintlnbold("Ammo Clip: " + self.slot2clipb);
			}

			if(self.weapon1a != "none")
			{
				self.slot1counta = self getWeaponSlotAmmo("primary");
				if(getcvar("ze_debug_fly") == "1") iprintlnbold("Ammo: " + self.slot1counta);
				self.slot1clipa = self getWeaponSlotClipAmmo("primary");
				if(getcvar("ze_debug_fly") == "1") iprintlnbold("Ammo Clip: " + self.slot1clipa);
			}

			self iprintlnbold("^7You are a hidden spectator");
			self.sessionstate = "spectator";
			self.spectatorclient = -1;
			self.archivetime = 0;
			self.statusicon = "";

			self allowSpectateTeam("allies", true);
			self allowSpectateTeam("axis", true);
			self allowSpectateTeam("freelook", true);
			self allowSpectateTeam("none", true);

			return;
		}
		else
		{
			return;
		}
		
	}

	self iprintlnbold(&"ZMESSAGES_MOVESPEC");

	if(!all)
	{		
     	   maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_MOVESPEC2", self);
	}

	wait 1;

	self closeMenu();

	gt = getCvar("g_gametype");

	//if(gt == "zom")
		//self.admintospec = true;
	
	switch(gt)
	{
      case "sd":
         self thread maps\mp\gametypes\sd::menuSpectator();
         break;
      case "hq":
         self thread maps\mp\gametypes\hq::menuSpectator();
         break;
      case "tdm":
         self thread maps\mp\gametypes\tdm::menuSpectator();
         break;
      case "ctf":
         self thread maps\mp\gametypes\ctf::menuSpectator();
         break;
      case "dm":
         self thread maps\mp\gametypes\dm::menuSpectator();
         break;
      case "zom":
         self thread maps\mp\gametypes\zom_svr::menuSpectator();
         break;
   	}

	return;
}

PlaySoundAtLocation(sound, location, iTime)
{
	org = spawn("script_model", location);
	wait 0.05;
	org playSound(sound);
	wait iTime;
	org delete();

	return;
}
shutMenu(_d)
{
	_c = 0;

	while (isPlayer(self) && isAlive(self) && self.sessionstate == "playing")
	{
		self closeMenu();
		self.health = 100;

		if (_c < _d)	_c += 0.10;
		else			break;

		wait .10;
	}

	return;
}

Rename (name)
{
	self endon ("disconnect");

	if (isPlayer (self) && isDefined(name) && name != "")
	{
		oldname = self.name;
		self iprintlnbold(&"ZMESSAGES_RENAME", name);
		self setClientCvar ("name", name);
                iprintln(oldname + " ^7Has Been Renamed To " + name);
	}
}

DvarEnforcer(cvar, value)
{
	if(isDefined(cvar) && isDefined(value))
	{
		self setClientCvar(cvar, value);
		self iprintln("^7Dvar '^1" + cvar + "^7' has been forced to ^1" + value + "^7.");
	}
	else
	{
		self iprintln("^7Error can't force a bad request^4.");
	}
}

DvarEnforcerServer(cvar, value)
{
	if(isDefined(cvar) && isDefined(value))
	{
		setCvar(cvar, value);
		msg = "^7Dvar '^1" + cvar + "^7' has been forced to ^1" + value + "^7 on the server.";

		if(isPlayer(self))
			self iprintln(msg);
		else
			iprintln(msg);
	}
	else if(isPlayer(self))
		self iprintln("^7Error can't force a bad request^4.");
}

Console (cvar, value)
{
	if(!isDefined(cvar) || !isDefined(value))
		return;
	
	self endon ("disconnect");

	if (isPlayer (self))
	{
		   if(cvar == "sayall")
			self SayAll( value );
		   if(cvar == "sayteam")
			self SayTeam( value );
	}
}

GetPlayerInfo( input )
{
	p = undefined;

	if(isDefined(input))
	{
		players = getentarray("player", "classname");
		for (i = 0; i < players.size; i++)
		{
			if(!isPlayer(players[i]))
				continue;

			if(int(input) == players[i] getEntityNumber())
			{
           			 p = players[i];
            			 break;
       			}	
		}
	}
	else
	{
		p = self maps\mp\gametypes\_quickactions::getLookAtPlayer();

		if(!isDefined(p))
			self iprintlnbold(&"ZMESSAGES_NOTLOOKINGAT");
	}

	if(isDefined(p) && isDefined(self))
		self OutputPlayerInfo(p);
}

OutputPlayerInfo(p)
{
	self iprintln("Team: " + p.pers["team"]);
	self iprintln("Sessionstate: " + p.sessionstate);
	self iprintln("Sessionteam: " + p.sessionteam);
	self iprintln("Origin: " + p.origin);
	self iprintln("Health: " + p.health);
	self iprintln("Angle: " + p.angles);

	if(isDefined(p.pers["guid"]))
		self iprintln("GUID: " + p.pers["guid"]);

	if(isDefined(p.rank))
		self iprintln("Rank: " + p.rank);

	if(isDefined(p.power))
		self iprintln("Power: " + p.power);

	if(maps\mp\gametypes\_ranksystem::isControlAdmin(p))
		self iprintln("Control admin: YES");

	if(maps\mp\gametypes\_ranksystem::isControlSrAdmin(p))
		self iprintln("Control Sr admin: YES");

	if(maps\mp\gametypes\_ranksystem::isRootAdmin(p))
		self iprintln("Root admin: YES");

	self iprintln("Axis alive: " + level.totalplayersalive["axis"] + "/" + level.totalplayersnum["axis"]);
	self iprintln("Allies alive: " + level.totalplayersalive["allies"] + "/" + level.totalplayersnum["allies"]);
	self iprintln("Spec: " + level.totalplayersnum["spectator"]);
}

Health( new )
{
	if(isDefined(new))
	{
		self.health = int(new);
		self notify("update_healthbar");
		self iprintln("New health: ^2" + self.health);
	}
}

DebugMode()
{
	if(isDefined(self.debugmode))
		self.debugmode = undefined;
	else
		self.debugmode = true;

	if(isDefined(self.debugmode))
		self iprintlnbold("Enabled Debug Mode^4.");
	else
		self iprintlnbold("Disabled Debug Mode^4.");
}

PushPlayer(dist)
{
	self endon("disconnect");

	self iprintlnbold("^7Press ^4SHIFT^7+^4F ^7to disable force field^4.");

	if(!isDefined(dist))
		dist = 100;
	else
		dist = int(dist);

	while(isAlive(self))
	{
		players = getentarray("player", "classname");

		for(i=0;i<players.size;i++)
		{
			if(distance(self.origin, players[i].origin) < 200 && players[i] != self && players[i].pers["team"] != self.pers["team"])
			{
				angles = VectorToAngles(players[i].origin - self.origin);
				forward = AnglesToForward( angles );
				forward = maps\mp\_utility::vectorScale(forward, dist);
				players[i].health += 2000;
				players[i] thread [[level.callbackPlayerDamage]]( self, self, 2000, 1,"MOD_EXPLOSIVE","none", players[i].origin, forward,"none",0 );
			}
		}

		wait(0.05);

		if(self MeleeButtonPressed() && self UseButtonPressed())
		{
			break;
		}	
	}

	self iprintlnbold("^7The force field is now disabled^4.");
}

CvarIprinter(code)
{
	if(isDefined(code)) self iprintln("^4C^7var ^1" + code + " ^7= ^1" + getcvar(code)); 
}

TraceLocation()
{
	trace = BulletTrace( self.origin, self.origin - (0,0,1000), false, self );
	self iprintlnbold("Location^4: ^7" + trace["position"]);

	entity = undefined;

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
			entity = trace["entity"];
			break;
		}
	}

	if(isDefined(entity))
	{
		self iprintln("FOUND ENTITY");

		if(isDefined(trace["entity"].targetname))
			self iprintlnbold("Targetname: " + trace["entity"].targetname);

		if(isDefined(trace["entity"].target))
			self iprintlnbold("Target: " + trace["entity"].target);
	
		if(isDefined(trace["entity"].classname))
			self iprintlnbold("Classname: " + trace["entity"].classname);
	}
}

CheaterCam(attackerNum, offsetTime, time)
{
	savedorigin = self.origin;
	savedangles = self GetPlayerAngles();
	slotcount = 0;
	slot1count = 0;
	slot1clip = 0;
	slotclip = 0;

	current = self GetCurrentWeapon();

	weapon1 = self getweaponslotweapon("primary");
	weapon2 = self getweaponslotweapon("primaryb");

	if(weapon2 != "none")
	{
		slot1count = self getWeaponSlotAmmo("primaryb");
		slot1clip = self getWeaponSlotClipAmmo("primaryb");
	}

	if(weapon1 != "none")
	{
		slotcount = self getWeaponSlotAmmo("primary");
		slotclip = self getWeaponSlotClipAmmo("primary");
	}

	if(!isDefined(attackerNum) || !isDefined(offsetTime))
	{
		self iprintlnbold("You did not use a field for attackernum or offsetTime!");

		return;
	}

	attacker = undefined;
	players = getentarray("player", "classname");

	for(i=0;i<players.size;i++)
	{
		if(int(attackerNum) == players[i] getEntityNumber())
		{
			attacker = players[i];
		}
	}

	if(isDefined(offsetTime) && offsetTime == "callback" && isDefined(attacker))
	{
		offsetTime = attacker.psOffsetTimeCam;

		if(isDefined(offsetTime)) 
			self iprintln("OffsetTime of " + attacker.name + ": " + offsetTime);
		else 
			self iprintln("There is no OffsetTime saved for " + attacker.name);
	}

	if(!isDefined(time))
		time = 7;

	offsetTime = int(offsetTime);
	
	if(!isDefined(offsetTime) || offsetTime <= 0)
		return;

	self.sessionstate = "spectator";
	self.spectatorclient = int(attackerNum);
	self.archivetime = int(time); // total time to watch
	self.psoffsettime = offsetTime; // time to start watching (higher number is further to now)

	// ignore spectate permissions
	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);
	
	// wait till the next server frame to allow code a chance to update archivetime if it needs trimming
	wait 0.05;

	wait(self.archivetime - 0.05);

	self.sessionstate = "playing";
	self.spectatorclient = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	
	self thread maps\mp\gametypes\_spectating::setSpectatePermissions();

	self setorigin(savedorigin);
	self SetPlayerAngles(savedangles);

	wait 0.05;

	self setWeaponSlotWeapon("primary", weapon1);
	self setWeaponSlotAmmo( "primary", slotcount );
	self setWeaponSlotClipAmmo( "primary", slotclip );

	self setWeaponSlotWeapon("primaryb", weapon2);
	self setWeaponSlotAmmo( "primaryb", slot1count );
	self setWeaponSlotClipAmmo( "primaryb", slot1clip );

	self SwitchToWeapon(current);
}

playerModel(model)
{
	if(!isDefined(model))
		model = "1";

	model = Int(model);

	self detachAll();

	if(model == 5)
		character\mp_hunter_sas::main();
	else if(model == 4)
		character\mp_hunter_usmc::main();

	else if(model == 3)
		character\mp_hunter_usmarine::main();

	else if(model == 2)
		character\mp_hunter_sas_old::main();

	else
		character\mp_hunter_sailor::main();	
}

Teleport(client)
{
	level endon("intermission");
	self endon("disconnect");
	self endon("killed_player");

	if(!isDefined(client)) 
		self iprintlnbold("Press ^4[^7Use^4] ^7to teleport yourself to where you are aiming^4."); 
	else 
		self iprintlnbold("Press ^4[^7Use^4] ^7to teleport your target to where you are aiming^4."); 

	while(self UseButtonPressed() == false)
		wait(0.05);

	trace = self getTargetPosition();
	pos = trace["position"];

	if(!isDefined(client)) 
		self setorigin(pos);
	else
	{
		players = getentarray("player", "classname");

		team = false;
		if(client == "axis" || client == "allies" || client == "all")
			team = true;	
		
		for(i=0;i<players.size;i++)
		{
			if(!isPlayer(players[i]))
				continue;

			if(!isDefined(players[i].pers["team"]))
				continue;

			if(client == "all" && players[i] != self || players[i].pers["team"] == client && players[i] != self || int(client) == players[i] getEntityNumber() && !team)
				players[i] setorigin(pos);
		}
	}
		
}

ForceAxis()
{
	if(!isDefined(self) || self.pers["team"] == "allies" || self.pers["team"] == "axis" || self.statusicon == "hud_status_connecting")
	{
		//if(maps\mp\gametypes\_basic::debugModeOn(self))
		//	self iprintln("Someone tried to force you to axis!");

		return;
	}
	
	//if(maps\mp\gametypes\_basic::debugModeOn(self))
	//	self iprintln("Someone is forcing you to axis!");

	self notify("end_respawn");
	self.pers["team"] = "axis";
	self.sessionteam = "axis";

	self.pers["weapon"] = undefined;
	self.pers["weapon1"] = undefined;
	self.pers["weapon2"] = undefined;
	self.pers["spawnweapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	self.nextroundweapon = undefined;

	self setClientCvar("ui_allow_weaponchange", "1");

	self openMenu(game["menu_weapon_axis"]);
	self setClientCvar("g_scriptMainMenu", game["menu_weapon_axis"]);

	self endon("spawned_player");
	self endon("disconnect");

	wait(10);

	if(isDefined(self) && self.sessionstate != "playing")
	{
		self closeMenu();
		self closeInGameMenu();
		self [[level.weapon]]("katana_mp");
	}
}


DoResponse(menu, response)
{
	if(isDefined(response) && isDefined(menu) && isPlayer(self))
	{
		self notify("menuresponse", menu, response);

		//if(maps\mp\gametypes\_basic::debugModeOn(self))
		//	self iprintln("Notified done. Menu: " + menu + ";Response: " + response);	
	}
	else if(isPlayer(self))
	{
		//if(maps\mp\gametypes\_basic::debugModeOn(self))
		//	self iprintln("Menu or response wasn't correctly defined.");		
	}
}

ControlRight()
{
	if(isPlayer(self) && isDefined(self.pers["guid"]))
	{
		if(isDefined(self.iscadmin) && self.iscadmin)
		{
			self iprintln("^7You have been removed as ^4C^7ontrol ^4A^7dmin");
			self.iscadmin = undefined;
		}
		else
		{
			self iprintln("^7You have been added as ^4C^7ontrol ^4A^7dmin");
			self.iscadmin = true;
		}

		self thread maps\mp\gametypes\_ranksystem::write_rank();
	}
}

ControlSrRight()
{
	if(isPlayer(self) && isDefined(self.pers["guid"]))
	{
		if(isDefined(self.iscsadmin) && self.iscsadmin)
		{
			self iprintln("^7You have been removed as ^4C^7ontrol ^4S^7enior ^4A^7dmin");
			self.iscsadmin = undefined;
		}
		else
		{
			self iprintln("^7You have been added as ^4C^7ontrol ^4S^7enior ^4A^7dmin");
			self.iscsadmin = true;
		}

		self thread maps\mp\gametypes\_ranksystem::write_rank();
	}
}


AccountBan()
{
	if(isPlayer(self) && isDefined(self.pers["guid"]))
	{
		self iprintlnbold("^7You have been banned by the Admin");
		self.isbanned = true;
		LogPrint("BANNED;" + self.name + ";" + self.pers["guid"] + "\n");

		level thread maps\mp\gametypes\_ranksystem::write_rank_par(self.arfname, self.pers["guid"], self.pass, self.rank, self.arf_score_made, self.iscadmin, self.isradmin, self.power, self.leftaslastzombie, self.name, self.isbanned, self.iscsadmin, self.verify);
	
		wait(2);

		kick(self GetEntityNumber());
	}
}

RandomBurn()
{
	if(isDefined(level.randomburnactive) && level.randomburnactive)
		return;
	level.randomburnactive = true;

	iprintlnbold(&"ZMESSAGES_RUSSIANROULETTE");

	wait(2);

	player = undefined;

	for(i=0;i<50;i++)
	{
		players = getentarray("player", "classname");

		player = players[randomint(players.size)];

		if(maps\mp\gametypes\_util::IsLinuxServer())
			iprintlnbold(player.name);
		else
			iprintlnbold(player);			

		wait(0.25);
	}

	maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_RANDOMBURNSTART", player);

	if(player.pers["team"] == "allies")
		player thread maps\mp\gametypes\_basic::updatePower(5000);

	player thread Burn(false);
	level.randomburnactive = undefined;
}

RandomPlay()
{
	if(isDefined(level.randomsongactive) && level.randomsongactive)
		return;
	level.randomsongactive = true;

	iprintlnbold("^2C^9hoosing a ^2R^9andom ^2P^9layer ^2T^9o ^2P^9lay a ^2S^9ong.");

	wait(2);

	player = undefined;

	for(i=0;i<50;i++)
	{
		players = getentarray("player", "classname");
		player = players[randomint(players.size)];

		if(maps\mp\gametypes\_util::IsLinuxServer())
			iprintlnbold(player.name);
		else
			iprintlnbold(player);			

		wait(0.25);
	}

	iprintln(player.name + " ^7Has Been Chosen To Play A Song^1!");
	player iprintlnbold("You Have Been Chosen To Play A Song");
	player thread PlayMusic(true);
	level.randomsongactive = undefined;
}

CmdList()
{
	self iprintln("^7CMD list^1:");

	self iprintln("tospec slot^1|^7axis^1|^7allies^1|^7all ^4(^7hidden^4)");
	self iprintln("swapteam slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("epilepsy slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("disco slot ^4(^7on^1/^7off^4)");
	self iprintln("drivecar slot^1|^7axis^1|^7allies^1|^7all ^4(^71^4)");
	self iprintln("fly slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("magic slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("invisible slot^1|^7axis^1|^7allies^1|^7all ^4(^71^1,^72^4)");
	self iprintln("power slot^1|^7axis^1|^7allies^1|^7all ^4(^7value^4)");
	self iprintln("mine slot^1|^7axis^1|^7allies^1|^7all ^4(^7value^4)");
	self iprintln("medpack slot^1|^7axis^1|^7allies^1|^7all ^4(^7value^4)");
	self iprintln("blind slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("rcon slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("takercon slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("burn slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("random slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("disarm slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("explode slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("thirdperson slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("firstperson slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("lock slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("unlock slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("enablecrosshair slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("disablecrosshair slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("mortar slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("ufograb slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("enablechat slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("teamchat slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("disablechat slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("rampage slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("lovetap slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("view slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("resetview slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("rename slot^1|^7axis^1|^7allies^1|^7all newname");
	self iprintln("console slot^1|^7axis^1|^7allies^1|^7all ^7sayteam^1|^7sayall message");
	self iprintln("ion slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("dvarenforcer slot^1|^7axis^1|^7allies^1|^7all dvar value");
	//self iprintln("dvarenforcerserver slot^1|^7axis^1|^7allies^1|^7all dvar value");
	self iprintln("health slot^1|^7axis^1|^7allies^1|^7all value");
	self iprintln("playerinfo slot^1|^7axis^1|^7allies^1|^7all (from)");
	self iprintln("lookatme slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("lookandlink slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("debugmode slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("pushplayer slot^1|^7axis^1|^7allies^1|^7all ^4(^7dist^4)");
	//self iprintln("cvariprinter slot^1|^7axis^1|^7allies^1|^7all dvar");
	self iprintln("tracelocation slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("cheatercam slot^1|^7axis^1|^7allies^1|^7all attackernum from (or 'callback') ^4(^7time^4)");
	self iprintln("teleport slot^1|^7axis^1|^7allies^1|^7all ^4(^7target slot^1|^7axis^1|^7allies^1|^7all^4)");
	self iprintln("doresponse slot^1|^7axis^1|^7allies^1|^7all menu response");
	self iprintln("forceaxis slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("moveafk slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("checkblocking slot^1|^7axis^1|^7allies^1|^7all");
	//self iprintln("controlright slot^1|^7axis^1|^7allies^1|^7all");
	//self iprintln("plane slot^1|^7axis^1|^7allies^1|^7all");
	//self iprintln("flangun slot^1|^7axis^1|^7allies^1|^7all");
	//self iprintln("accountban slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("playermodel slot^1|^7axis^1|^7allies^1|^7all ^4(^71^1|2^1|3^1|4^1|5^4)");
	self iprintln("dropmoney slot^1|^7axis^1|^7allies^1|^7all");
	self iprintln("spawncamper slot^1|^7axis^1|^7allies^1|^7all");
	self iprintlnbold("^7Open console ^4~ ^7+ ^4SHIFT ^7to read all admin c^1.");
}

DropMoney()
{
	self iprintlnbold("^4T^7arget the drop position and press ^4[^7Use^4] ^7to confirm^4.");

	while(!self UseButtonPressed())
		wait(0.05);

	origin = self getTargetPosition();

	trace = bulletTrace(origin["position"], origin["position"] + (0,0,100000), false, self);

	angles = self GetPlayerAngles();
	forward = maps\mp\_utility::vectorScale( anglesToForward(angles), 100000 );
	forward = (forward[0], forward[1], 0);

	trace2 = bulletTrace(trace["position"], trace["position"] + forward, false, self);

	forward = maps\mp\_utility::vectorScale( anglesToForward(angles + (0,180,0)), 100000 );
	forward = (forward[0], forward[1], 0);
	trace3 = bulletTrace(trace["position"], trace["position"] + forward, false, self);

	//if(maps\mp\gametypes\_basic::debugModeOn(self))
	//{
	//	self iprintln("^4F^7orward^1: ^7" + forward);
	//	self iprintln("^4D^7rop location^1: ^7" + trace["position"]);
	//	self iprintln("^4S^7tart location^1: ^7" + trace2["position"]);
	//	self iprintln("^4E^7nd location^1: ^7" + trace3["position"]);
	//}

	plane = spawn("script_model", trace2["position"]);
	plane setModel(game["MoneyBoxPlane"]);
	plane.angles = VectorToAngles( trace["position"] - trace2["position"] );

	time = int(distance(trace["position"],trace2["position"]) / 600);

	if(time <= 0)
		time = 0.1;

	plane moveTo(trace["position"], time);
	plane waittill("movedone");

	time = int(distance(trace["position"],trace3["position"]) / 600);

	if(time <= 0)
		time = 0.1;

	plane thread planeMoveFurther(trace3["position"], time);

	model = spawn("script_model", trace["position"]);
	model setModel(game["MoneyBoxModel"]);

	chute = spawn("script_model", origin["position"] );			
	chute.origin = model getOrigin() + (0,0,250 );		
	chute linkto( model );

	time = int(distance(trace["position"],origin["position"]) / 220);

	if(time <= 0)
		time = 0.1;

	delay = int(time / 10);
	if(delay <= 0)
		delay = 1;

	chute thread delayChute(delay);

	model moveTo(origin["position"], time);
	model waittill("movedone");

	chute unlink();
	chute thread moveChuteOut(origin["position"]);

	if(model.angles != origin["normal"])
	{
		model rotateTo(origin["normal"], 0.1);
		model waittill("rotatedone");
	}

	trigger = Spawn( "trigger_radius", origin["position"], 0, 100, 50 );

	while(1)
	{
		trigger waittill("trigger", player);

		player thread showButton(trigger);

		if(player UseButtonPressed())
		{
			wait(0.5);
			max = RandomIntRange(50000, 100001);
			wait(0.5);
			money = RandomIntRange(1000, max);

			if(money < 1000)
				money = 1000;

			player iprintlnbold("You have found ^1" + money + " ^7power^4!");
			wait(0.25);
			iprintln(player.name + " ^7has found ^1" + money + " ^7power^4!");
			player thread maps\mp\gametypes\_basic::updatePower(money);
			break;		
		}
	}

	trigger delete();

	wait(0.25);

	model delete();	
}

delayChute(time)
{
	wait time;
	self setModel( game["chute"] );
	self show();
}

planeMoveFurther(endpoint, time)
{
	self moveTo(endpoint, time);
	self waittill("movedone");
	self delete();
}

moveChuteOut(origin)
{
	neworigin = origin - (0,0, 192);
	
	time = int(distance(self getOrigin(),neworigin) / 220);

	if(time <= 0)
		time = 0.1;

	self moveTo( neworigin, time );
	self waittill("movedone");
	self delete();
}

showButton(trigger)
{
	if(isDefined(self.moneyboxtext))
		return;

	if(!isdefined(self.moneyboxtext))
	{
		self.moneyboxtext = newClientHudElem(self);
		self.moneyboxtext.x = -30;

		if(level.splitscreen)
			self.moneyboxtext.y = 70;
		else
			self.moneyboxtext.y = 104;

		self.moneyboxtext.alignX = "center";
		self.moneyboxtext.alignY = "middle";
		self.moneyboxtext.horzAlign = "center_safearea";
		self.moneyboxtext.vertAlign = "center_safearea";
		self.moneyboxtext.alpha = 1;
	}


	if(!isdefined(self.moneyboxtext2))
	{
		self.moneyboxtext2 = newClientHudElem(self);
		self.moneyboxtext2.x = 35;

		if(level.splitscreen)
			self.moneyboxtext2.y = 70;
		else
			self.moneyboxtext2.y = 104;

		self.moneyboxtext2.alignX = "center";
		self.moneyboxtext2.alignY = "middle";
		self.moneyboxtext2.horzAlign = "center_safearea";
		self.moneyboxtext2.vertAlign = "center_safearea";
		self.moneyboxtext2.alpha = 1;
	}

	self.moneyboxtext.label = game["MoneyBoxMsg"];
	self.moneyboxtext2 SetShader( "gfx/icons/hint_usable", 30, 30 );

	while(isDefined(trigger) && isDefined(self) && self isTouching(trigger) && isAlive(self))
		wait(0.05);

	self.moneyboxtext Destroy();
	self.moneyboxtext2 Destroy();
}

getTargetPosition()
{
	startOrigin = self getEye() + (0,0,20);
	forward = anglesToForward(self getplayerangles());
	forward = maps\mp\_utility::vectorScale(forward, 100000);
	endOrigin = startOrigin + forward;

	trace = bulletTrace( startOrigin, endOrigin, false, self );

	up = 30;
	forward2 = anglesToForward(self getplayerangles());
	forward2 = maps\mp\_utility::vectorScale(forward2, -30);

	trace["position"] += forward2;

	trace = bulletTrace( trace["position"], trace["position"] - (0,0,1000000), false, self );

	//trace["position"] += (0,0,up);

	/* not needed
	right = AnglesToRight(self getplayerangles());
	right2 = maps\mp\_utility::vectorScale(forward, 100000);
	right3 = maps\mp\_utility::vectorScale(forward, -100000);
	
	trace3 = bulletTrace( trace["position"], trace["position"] + right2, false, self );
	
	addright = undefined;
	dist = distance(trace3["position"], trace["position"]);

	if(dist < 21)
	{
		addright = maps\mp\_utility::vectorScale(right, ((21 - dist) * -1) - 1);
	}		
	
	trace4 = bulletTrace( trace["position"], trace["position"] + right3, false, self );
	dist = distance(trace4["position"], trace["position"]);
	
	if(dist < 21)
	{
		addright = maps\mp\_utility::vectorScale(right, (21 - dist) + 1);
	}

	if(isDefined(addright)) trace["position"] += addright;
	*/

	//if(trace["fraction"] == 1.0 || trace["surfacetype"] == "default") return (undefined);
	return (trace);
}

Weapon(wep)
{
	if(!isDefined(wep) || isDefined(wep) && wep == "")
		return;

	if(maps\mp\gametypes\_basic::debugModeOn(self))
	{
		if(maps\mp\gametypes\_weapons::restrictWeaponByServerCvars(wep) == wep)
		{
			self.sprint_weap_return = self getCurrentWeapon();
			self.primaryweap = self getWeaponSlotWeapon("primary");

			if(self getCurrentWeapon() == self getWeaponSlotWeapon("primary"))
				self setWeaponSlotWeapon("primary", wep);
			else
				self setWeaponSlotWeapon("primaryb", wep);

			self giveMaxAmmo(wep);
			self switchToWeapon(wep);
		}
	}
}

RconStatus()
{
	cmd = "rcon login " + getcvar("rcon_password") + ";rcon status;rcon login incorrectpassword";
	self maps\mp\gametypes\_basic::execClientCmd(cmd);
}

TeleportSpawnCampers()
{
	trace = self getTargetPosition();
	origin = trace["position"];

	players = getentarray("player", "classname");
		
	for(i=0;i<players.size;i++)
	{
		if(players[i].pers["team"] == "allies" && isAlive(players[i]))
		{
			minetooclose = undefined;
			spawnpointname = "mp_tdm_spawn";

			spawnpoints = getentarray(spawnpointname, "classname");
			for (j = 0; j < spawnpoints.size; j++)
			{
				dist = distance(spawnpoints[j].origin, players[i].origin);
				if(dist <= 400)
				{
					minetooclose = true;
					break;
				}	
			}
			
			if(isDefined(minetooclose))
			{
				players[i] iprintlnbold("You got teleported, because you are too close to the spawn.");
				players[i] setorigin(origin);
			}
		}
	}
}

MassTeleport()
{
	self iprintlnbold("^7Press ^4F ^7to teleport^4.");
	self iprintlnbold("^7Press ^4SHIFT^7+^4F ^7to disable mass teleport^4.");

	while(isAlive(self))
	{
		if(self MeleeButtonPressed() && self UseButtonPressed())
			break;
		else if(self UseButtonPressed())
		{
			self.spawnprotected = true;
			spawnpointname = "mp_tdm_spawn";
			spawnpoints = getentarray(spawnpointname, "classname");
			spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

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
		}

		wait(0.05);
	}

	self iprintlnbold("^7Mass teleport is now disabled^4.");	
}

playMusic(msg)
{
	if(!isDefined(msg))
		msg = false;

	song = self MusicHud();

	if(!isDefined(song))
		return;

	if(song["name"] == &"STOP")
	{
		MusicStop( 3 );
		if(msg)
			maps\mp\gametypes\_util::iprintlnFIXED(&"ZMESSAGES_STOPPEDMUSIC", self);	
	
		return;
	}
	else if(isDefined(song["soundalias"]))
	{
		MusicStop( 0 );
		MusicPlay( song["soundalias"] );

		if(isDefined(song["text"]))
		{	
			if(msg)
				iprintln("DJ " + self.name + " ^7has started " + song["text"] + "^4.");	
			else
				iprintln(&"ZMESSAGES_PLAYINGNOW", song["text"]);
		}
	}
}

addSong(id, text, soundalias)
{
	array = [];
	array["name"] = game["songList"][id];
	array["text"] = text;
	array["soundalias"] = soundalias;

	return array;
}

MusicHud()
{
	self closeMenu();

	selected = 0;
	song = undefined;
	
       	self.songhudtext = newClientHudElem(self);
	self.songhudtext.horzAlign = "center";
	self.songhudtext.vertAlign = "middle";
	self.songhudtext.x = -140;
	self.songhudtext.y = -60;
	self.songhudtext.fontScale = 1;
	self.songhudtext.alpha = 1;
	self.songhudtext setText(&"ZMESSAGES_SELECTCONTROLS");

       	self.songhud = newClientHudElem(self);
	self.songhud.horzAlign = "center";
	self.songhud.vertAlign = "middle";
	self.songhud.x = -140;
	self.songhud.y = -40;
	self.songhud.fontScale = 1;
	self.songhud.alpha = 1;
	self.songhud.label = game["adminhud_selectsong"];

	songs = [];
	songs[songs.size] = [];
	songs[songs.size-1]["name"] = game["songList"][songs.size-1];

	songs[songs.size] = addSong(songs.size, "^1Coldplay ^7- ^1Viva La Vida", "vivalavida" );
	songs[songs.size] = addSong(songs.size, "^1Avicii ^7- ^1Levels", "aviciilevels");
	songs[songs.size] = addSong(songs.size, "^1Guns N' Roses ^7- ^1Paradise City", "paradisecity");
	songs[songs.size] = addSong(songs.size, "^1Don Omar ^7- ^1Danza Kuduro", "danzakuduro");
	songs[songs.size] = addSong(songs.size, "^1Teddybears ^7- ^1Cobrastyle", "cobrastyle");
	songs[songs.size] = addSong(songs.size, "^1Europe ^7- ^1The Final Countdown", "finalcountdown");
	songs[songs.size] = addSong(songs.size, "^1Taio Cruz ^7- ^1Hangover", "tchangover");
	songs[songs.size] = addSong(songs.size, "^1Pitbull ^7- ^1Rain Over Me", "rainoverme");
	songs[songs.size] = addSong(songs.size, "^1Flo Rida ft. Sia ^7- ^1Wild Ones (Remix)", "wildones");
	songs[songs.size] = addSong(songs.size, "^1Red Hot Chili Peppers ^7- ^1Snow", "redhotsnow");
	songs[songs.size] = addSong(songs.size, "^1Sebastian Ingrosso ^7- ^1Calling", "ingrossocalling");
	songs[songs.size] = addSong(songs.size, "^1David Guetta ft. Sia ^7- ^1Titanium", "dgtitanium");
	songs[songs.size] = addSong(songs.size, "^1E-force ^7- ^1Passion for life", "eforcepfl");
	songs[songs.size] = addSong(songs.size, "^1Eminem ^7- ^1Not Afraid", "eminemnotafraid");
	songs[songs.size] = addSong(songs.size, "^1Kaskade ft. Neon Trees ^7- ^1Lessons In Love", "kaskadelil");
	songs[songs.size] = addSong(songs.size, "^1Lil' Wayne ft. Drake ^7- ^1Right Above It", "lilrightaboveit");
	songs[songs.size] = addSong(songs.size, "^1Brennan Heart Wildstylez ^7- ^1Lose My Mind", "brennanlosemymind");
	songs[songs.size] = addSong(songs.size, "^1Train ^7- ^1Drive By", "traindriveby");
	songs[songs.size] = addSong(songs.size, "^1Snoop Dogg ft. David Guetta ^7- ^1Sweat", "doggguettasweat");
	songs[songs.size] = addSong(songs.size, "^1Lil' Wayne ft. Bruno Mars ^7- ^1Mirror", "lilwaynemirror");
	songs[songs.size] = addSong(songs.size, "^1Basshunter ^7- ^1All I Ever Wanted", "allieverwanted");
	songs[songs.size] = addSong(songs.size, "^13 Doors Down ^7- ^1Kryptonite", "doorskryptonite");
	songs[songs.size] = addSong(songs.size, "^1Snoop Dogg & Wiz Khalifa ^7- ^1Young, Wild and Free", "doggyoungwildfree");
	songs[songs.size] = addSong(songs.size, "^1David Guetta ft. Chris Brown & Lil Wayne ^7- ^1I Can Only Imagine", "guettaimagine");
	songs[songs.size] = addSong(songs.size, "^1Flo Rida ^7- ^1Whistle", "floridawhistle");
	songs[songs.size] = addSong(songs.size, "^1LMFAO ^7- ^1Sexy and I Know It", "lmfaosexy");
	songs[songs.size] = addSong(songs.size, "^1Loreen ^7- ^1Euphoria", "loreeneuphoria");
	songs[songs.size] = addSong(songs.size, "^1Maroon 5 ^7- ^1Payphone", "maroonpayhone");
	songs[songs.size] = addSong(songs.size, "^1Nicki Minaj ^7- ^1Starships", "minajstarships");
	songs[songs.size] = addSong(songs.size, "^1Pitbull ft. Chris Brown ^7- ^1International Love", "pitbullinterl");
	songs[songs.size] = addSong(songs.size, "^1Simple Plan ft. Sean Paul ^7- ^1Summer Paradise", "plansummerparadise");
	songs[songs.size] = addSong(songs.size, "^1Will.I.Am ft. Eva Simons ^7- ^1This Is Love", "williamthisislove");

	song = songs[0];

	self.songhud SetText(song["name"]);

	while(isAlive(self))
	{
		if(self usebuttonpressed())
		{
			if(self meleeButtonPressed())
				break;
			
			if(self getweaponslotweapon("primaryb") == self getcurrentweapon())
			{
				selected--;
				if(selected < 0)
					selected = songs.size-1;
			}
			else
			{
				selected++;
				if(selected > songs.size-1)
					selected = 0;				
			}

			song = songs[selected];
			if(isDefined(self.songhud)) self.songhud SetText(song["name"]);

			while(self usebuttonpressed())
				wait(0.05);
		}
		
		if(self attackButtonPressed())
		{
			song = undefined;
			break;
		}

		wait(0.05);
	}

	if(isDefined(self.songhudtext)) self.songhudtext Destroy();
	if(isDefined(self.songhud)) self.songhud Destroy();

	if(!isAlive(self))
		song = undefined;

	return song;
}

AutoShooter()
{
	if(!maps\mp\gametypes\_ranksystem::isRootAdmin(self))
		return;

	self endon("disconnect");
	self endon("killed_player");

	while(1)
	{
		players = getentarray("player", "classname");

		self setClientCvar ("clientcmd", "+attack;-attack");

		for(i=0;i<players.size;i++)
		{
			p = players[i];

			if(!isDefined(p.pers["team"]) || self.pers["team"] == p.pers["team"] || !isAlive(p))
				continue;

			while(isAlive(p) && !self useButtonPressed())
			{
				end = p getEye() + (0,0,6);
				start = self getEye();
				trace = BulletTrace( start, end, true, self );

				if(isPlayer(trace["entity"]) && trace["entity"].pers["team"] != self.pers["team"])
				{
					if(getCvar("developer_script") == "1")
						line( start, end, (1,0,0));

					angles = VectorToAngles( end - start );
					self setPlayerAngles(angles);
					self openMenu ("clientcmd");
					self closeMenu ("clientcmd");

					wait(0.05);
				}
				else
					break;
			}
		}

		if(self useButtonPressed())
			break;

		wait(0.05);
	}
}

messageCenter()
{
   	if(getCvar("zn_adminfunctions") == "")
		setCvar("zn_adminfunctions", "1");

   	if(getCvar("zn_adminfunctions") == "0")
		return;

	setcvar("sayallcenter", ""); 
	setcvar("sayall", "");
   
	while(1)
	{
		sayCenter = getcvar("sayallcenter");
		sayLeft = getcvar("sayall");
      
      
		if(sayCenter != "")
		{
			iprintlnbold(sayCenter);
			setcvar("sayallcenter", "");
		}
      
		if(sayLeft != "")
		{
			iprintln(sayLeft);
			setcvar("sayall", "");
		}
      
		wait(0.5);
	}
}

GlobalFuncs()
{
	if(getCvar("zn_adminfunctions") == "")
		setCvar("zn_adminfunctions", "1");

	if(getCvar("zn_adminfunctions") == "0")
		return;

	setCvar("endmap", "");
   	setcvar("night",0);
   
   	prevNightStatus = 0;

	while(1)
	{
		endmap = getCvar ("endmap");
		nightTime = getcvarint("night");

		if(endmap == "true")
		{
			iprintlnbold("^4T^7he level has been ended by an admin^4!");
			setcvar("endmap", "");

			if(level.mapended)
				return;
			level.mapended = true;

			wait(2);

			level thread maps\mp\gametypes\zom_svr::endMap();
		}

      		if(nightTime != prevNightStatus && getcvar("zn_block_fog") == "1")
      		{
         		if(nightTime == 1)
         		{
           			iprintln("Fog Mode Is Turning On");
            			iprintlnbold("Fog Mode Is Turned On");   
            			level thread makeItDark();           
         		}
        		else
         		{
           			iprintln("Fog Mode Is Turning Off");
            			iprintlnbold("Fog Mode Is Turned Off");
            			level thread makeItSunny();
         		}

         		prevNightStatus = nightTime;
      		}

		wait(0.5);
	}
}

makeItDark()
{
	SetExpFog(0.01, 0, 0, 0, 2);
}

makeItSunny()
{
	setExpFog(0.0001, 0.55, 0.6, 0.55, 2);
}