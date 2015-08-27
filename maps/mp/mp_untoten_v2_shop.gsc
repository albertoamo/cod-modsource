main()
{
	//add the raygun before anything else
	precacheItem("tesla_mp");

	thread boxguns_init();
	thread precache();
	thread shops_init();

	if( (isdefined(game["waw_enablefences"])) && (game["waw_enablefences"] == "1") )
	{
		thread fences_init();
		thread fenceclipsclose();
	}
}

boxguns_init()
{
	level.boxtriginuse = 0;
	level.fenceactivated = 0;
	
	level._effect["zap"] = loadfx("fx/waw/zapper.efx");
	
	bar = getent("bar_box","targetname");
	bren = getent("bren_box","targetname");
	carbine = getent("carbine_box","targetname");
	ray = getent("raygun_box","targetname");
	enfield = getent("enfield_box","targetname");
	enfield_scoped = getent("enfield_scope_box","targetname");
	g43 = getent("g43_box","targetname");
	kar = getent("kar98k_box","targetname");
	kar_scoped = getent("kar98k_scoped_box","targetname");
	garand = getent("garand_box","targetname");
	mp40 = getent("mp40_box","targetname");
	mp44 = getent("mp44_box","targetname");
	panzer = getent("panzer_box","targetname");
	nagant = getent("mosin_box","targetname");
	nagant_scoped = getent("mosin_scoped_box","targetname");
	pps43 = getent("pps42_box","targetname");
	ppsh = getent("ppsh_box","targetname");
	springfield = getent("springfield_box","targetname");
	sten = getent("sten_box","targetname");
	svt40 = getent("svt40_box","targetname");
	thompson = getent("thompson_box","targetname");
	trench = getent("trench_box","targetname");
	grease = spawn("script_model", trench.origin);
	grease.angles = trench.angles;
	grease setmodel("xmodel/viewmodel_greasegun");
	grease.targetname = "grease_box";
	
	if( isdefined(getent("box_top","targetname")) )
	{
		boxtop = getent("box_top","targetname");
		boxtop delete();
	}
	
	bar.target = "box_guns";
	bren.target = "box_guns";
	carbine.target = "box_guns";
	ray.target = "box_guns";
	enfield.target = "box_guns";
	enfield_scoped.target = "box_guns";
	g43.target = "box_guns";
	kar.target = "box_guns";
	kar_scoped.target = "box_guns";
	garand.target = "box_guns";
	mp40.target = "box_guns";
	mp44.target = "box_guns";
	panzer.target = "box_guns";
	nagant.target = "box_guns";
	nagant_scoped.target = "box_guns";
	pps43.target = "box_guns";
	ppsh.target = "box_guns";
	springfield.target = "box_guns";
	sten.target = "box_guns";
	svt40.target = "box_guns";
	thompson.target = "box_guns";
	trench.target = "box_guns";
	grease.target = "box_guns";
	
	bear = getent("bear_box","targetname");
	bear.target = "box_guns";
	tnt = getent("tnt_box","targetname");
	tnt.target = "box_guns";
	
	boxguns = getentarray("box_guns","target");
	for(i=0;i<boxguns.size;i++)
	{
		boxguns[i] hide();
		boxguns[i].begorg = boxguns[i].origin;
	}
}
	
precache()
{
	precacheitem("panzerschreck_mp");
	precacheitem("sten_mp");
	precacheitem("enfield_mp");
	precacheitem("enfield_scope_mp");
	precacheitem("bren_mp");
	precacheitem("PPS42_mp");
	precacheitem("mosin_nagant_mp");
	precacheitem("SVT40_mp");
	precacheitem("mosin_nagant_sniper_mp");
	precacheitem("ppsh_mp");
	precacheitem("sten_mp");
	precacheitem("tt30_mp");

	precacheitem("greasegun_mp");
	precacheitem("m1carbine_mp");
	precacheitem("springfield_mp");
	precacheitem("m1garand_mp");
	precacheitem("thompson_mp");
	precacheitem("bar_mp");
	precacheitem("mp40_mp");
	precacheitem("kar98k_mp");
	precacheitem("g43_mp");
	precacheitem("kar98k_sniper_mp");
	precacheitem("mp44_mp");
	precacheitem("shotgun_mp");

	precacheModel("xmodel/prop_bear_detail_sitting");
}

shops_init()
{
	shops = getentarray("shop","targetname");
	for(i=0; i<shops.size; i++)
	{
		switch(shops[i].target)
		{
			case "springfield_mp":
				shops[i] setHintString("Buy Springfield [" + game["waw_springfield_cost"] + "] ");
				break;
			
			case "kar98k_mp":
				shops[i] setHintString("Buy Kar98k [" + game["waw_kar98k_cost"] + "] ");
				break;
			
			case "m1garand_mp":
				shops[i] setHintString("Buy M1 Garand [" + game["waw_garand_cost"] + "] ");
				break;
			
			case "g43_mp":
				shops[i] setHintString("Buy Gewehr [" + game["waw_gewehr_cost"] + "] ");
				break;
			
			case "m1carbine_mp":
				shops[i] setHintString("Buy M1 Carbine [" + game["waw_carbine_cost"] + "] ");
				break;
			
			case "mp40_mp":
				shops[i] setHintString("Buy MP40 [" + game["waw_mp40_cost"] + "] ");
				break;
				
			case "mp44_mp":
				shops[i] setHintString("Buy MP44 [" + game["waw_mp44_cost"] + "] ");
				break;
			
			case "random":
				shops[i] setHintString("Buy Random Weapon [" + game["waw_mysterybox_cost"] + "] ");
				break;
			
			case "thompson_mp":
				shops[i] setHintString("Buy Thompson [" + game["waw_thompson_cost"] + "] ");
				break;
				
			case "bouncing_teddy":
				shops[i] setHintString("^1DISABLED");
				break;
				
			case "ele_trig":
				shops[i] setHintString("Activate Electric Fences [" + game["waw_fences_cost"] + "] ");
				break;
		}

		if(shops[i].target != "bouncing_teddy")
			shops[i] thread init_shops();
	}
}

init_shops()
{
	springfield = Int(game["waw_springfield_cost"]);
	kar98k = Int(game["waw_kar98k_cost"]);
	garand = Int(game["waw_garand_cost"]);
	gewehr = Int(game["waw_gewehr_cost"]);
	carbine = Int(game["waw_carbine_cost"]);
	mp40 = Int(game["waw_mp40_cost"]);
	mp44 = Int(game["waw_mp44_cost"]);
	thompson = Int(game["waw_thompson_cost"]);
	
	while(1)
	{
		self waittill("trigger", shopper);

		if(shopper.pers["team"] == "allies" && !isDefined(shopper.isshopping))
		{
			shopper.isshopping = true;

			shopper thread StopShopping();

			switch(self.target)
			{
				case "springfield_mp":
					shopper thread shop(self.target,60,springfield);
					break;
			
				case "kar98k_mp":
					shopper thread shop(self.target,60,kar98k);
					break;
			
				case "m1garand_mp":
					shopper thread shop(self.target,96,garand);
					break;
			
				case "g43_mp":
					shopper thread shop(self.target,100,gewehr);
					break;
			
				case "m1carbine_mp":
					shopper thread shop(self.target,90,carbine);
					break;
			
				case "mp40_mp":
					shopper thread shop(self.target,192,mp40);
					break;
				
				case "mp44_mp":
					shopper thread shop(self.target,180,mp44);
					break;
			
				case "random":
					if(level.boxtriginuse == 0)
					{
						shopper thread randomtakemoney(self);
					}
					break;
			
				case "thompson_mp":
					shopper thread shop(self.target,180,thompson);
					break;
				
				
				case "ele_trig":
					if(level.fenceactivated == 0)
					{
						shopper thread fenceshop(self);
					}
					break;

				default:
					break;
			}
		}

		wait(0.15);
	}
}

StopShopping()
{
	while(self useButtonPressed())
		wait(0.25);

	self.isshopping = undefined;
}

randomtakemoney(trigger)
{
	boxcost = Int(game["waw_mysterybox_cost"]);

	if((self.power >= boxcost) && (level.boxtriginuse == 0))
	{
		self thread random(trigger);
		self thread maps\mp\gametypes\_basic::updatePower(boxcost * -1);
		level.boxtriginuse = 1;
		trigger setHintString("");
	}
	else if(self.power < boxcost)
	{
		self iprintln(&"ZMESSAGES_CANTPURCHASE");
		rantrig = getent("random","target");
		rantrig thread init_shops();		
	}
}
	
random(trigger)
{
	level endon("weapon_not_picked");
	cost = 0;
	time = 5.5;
	accel = 0.2;
	decel = 0.2;
	
	tnt = getent("tnt_box","targetname");
	
	level.boxguid = self.guid;
	
	boxguns = getentarray("box_guns","target");
	for(i=0;i<boxguns.size;i++)
	{
		boxguns[i] movez(45,time,accel,decel);
	}
	
	number = randomint(24);
	self thread flashguns(number);
	
	level waittill("guns_flashed");
	//self iprintln("^1THE GUNS HAVE FLASHED");
	
	triggers = getent("random","target");
	
	if(level.rangun == "raygun")
	{
		triggers setHintString("Swap Weapon For ^1Ray Gun ");
	}
	else
	{
		triggers setHintString("Swap Weapon ");
	}
	
	while(1)
	{
		trigger waittill("trigger", buyer);
		if((buyer.guid == level.boxguid) && (buyer.pers["team"] == "allies"))
		{
			break;
		}
	}

	triggers setHintString("");
	
	switch(level.rangun)
	{
		case "grease":
			buyer thread shop("greasegun_mp",224,cost);
			break;
		
		case "carbine":
			buyer thread shop("m1carbine_mp",90,cost);
			break;
		
		case "springfield":
			buyer thread shop("springfield_mp",60,cost);
			break;
		
		case "garand":
			buyer thread shop("m1garand_mp",96,cost);
			break;
		
		case "thompson":
			buyer thread shop("thompson_mp",180,cost);
			break;
		
		case "bar":
			buyer thread shop("bar_mp",140,cost);
			break;
			
		case "sten":
			buyer thread shop("sten_mp",224,cost);
			break;
			
		case "enfield":
			buyer thread shop("enfield_mp",70,cost);
			break;
			
		case "enfield_scope":
			buyer thread shop("enfield_scope_mp",70,cost);
			break;
			
		case "bren":
			buyer thread shop("bren_mp",210,cost);
			break;
		
		case "pps42":
			buyer thread shop("PPS42_mp",245,cost);
			break;
		
		case "nagant":
			buyer thread shop("mosin_nagant_mp",65,cost);
			break;
			
		case "nagant_scoped":
			buyer thread shop("mosin_nagant_sniper_mp",65,cost);
			break;
		
		case "svt40":
			buyer thread shop("SVT40_mp",110,cost);
			break;
			
		case "ppsh":
			buyer thread shop("ppsh_mp",284,cost);
			break;
		
		case "mp40":
			buyer thread shop("mp40_mp",196,cost);
			break;
		
		case "kar":
			buyer thread shop("kar98k_mp",60,cost);
			break;
		
		case "g43":
			buyer thread shop("g43_mp",100,cost);
			break;
			
		case "kar_scoped":
			buyer thread shop("kar98k_sniper_mp",65,cost);
			break;
	
		case "mp44":
			buyer thread shop("mp44_mp",180,cost);
			break;
		
		case "trench":
			buyer thread shop("shotgun_mp",66,cost);
			break;
			
		case "panzer":
			buyer thread shop("panzerschreck_mp",3,cost);
			break;
		
		case "raygun":
			buyer thread shop("tesla_mp",60,cost);
			break;
	}
	
	boxguns = getentarray("box_guns","target");
	for(i=0;i<boxguns.size;i++)
	{
		boxguns[i] hide();
	}
	//level.boxtriginuse = 0;
}

shop(item,itemmaxammosize,wepcost)
{
	wepcurrent = self getcurrentweapon();
	weapon1 = self getweaponslotweapon("primary");
	weapon2 = self getweaponslotweapon("primaryb");
	notwep = !(self hasweapon(item));
			
	if(self.power >= wepcost && wepcurrent == item && self.pers["team"] == "allies")
	{
		if(wepcurrent == weapon1)
		{
			currentslot = "primary";
		}
		else
		{
			currentslot = "primaryb";
		}

		wepammo = self getweaponslotammo(currentslot);

		if(wepammo < itemmaxammosize)
		{
			if(wepcost > 0)
				self thread maps\mp\gametypes\_basic::updatePower(wepcost * -1);

			self givemaxammo(wepcurrent);
			self playsound("weap_pickup");
		}

		self iprintln("current == item");
	}
	else if(self.power < wepcost && self.pers["team"] == "allies")
	{
		self iprintln(&"ZMESSAGES_CANTPURCHASE");
	}
	else if(notwep && self.pers["team"] == "allies" && self.power >= wepcost)
	{
		if(wepcurrent == weapon1)
		{
			currentslot = "primary";
		}
		else
		{
			currentslot = "primaryb";
		}

		if(wepcost > 0)
			self thread maps\mp\gametypes\_basic::updatePower(wepcost * -1);

		self setweaponslotweapon(currentslot, item);
		self playsound("weap_pickup");
		self SwitchToWeapon(item);

		if(item == "panzerschreck_mp")
			self givemaxammo("panzerschreck_mp");
	}
}

flashguns(number)
{
	boxguns = getentarray("box_guns","target");
	
	bar = getent("bar_box","targetname");
	bren = getent("bren_box","targetname");
	carbine = getent("carbine_box","targetname");
	ray = getent("raygun_box","targetname");
	enfield = getent("enfield_box","targetname");
	enfield_scoped = getent("enfield_scope_box","targetname");
	g43 = getent("g43_box","targetname");
	kar = getent("kar98k_box","targetname");
	kar_scoped = getent("kar98k_scoped_box","targetname");
	garand = getent("garand_box","targetname");
	mp40 = getent("mp40_box","targetname");
	mp44 = getent("mp44_box","targetname");
	panzer = getent("panzer_box","targetname");
	nagant = getent("mosin_box","targetname");
	nagant_scoped = getent("mosin_scoped_box","targetname");
	pps43 = getent("pps42_box","targetname");
	ppsh = getent("ppsh_box","targetname");
	springfield = getent("springfield_box","targetname");
	sten = getent("sten_box","targetname");
	svt40 = getent("svt40_box","targetname");
	thompson = getent("thompson_box","targetname");
	trench = getent("trench_box","targetname");
	grease = getent("grease_box","targetname");
	
	bear = getent("bear_box","targetname");
	tnt = getent("tnt_box","targetname");
	
	i = 0;
	time = 0.065;
	
	while(i < 10)
	{
	ran = randomint(boxguns.size);
	boxguns[ran] show();
	
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt show();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear show();
	}
	
	wait(time);
	boxguns[ran] hide();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt hide();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear hide();
	}
	
	i++;
	}
	
	i=0;
	time = 0.1;
	while(i < 8)
	{
	ran = randomint(boxguns.size);
	boxguns[ran] show();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt show();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear show();
	}
	
	wait(time);
	boxguns[ran] hide();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt hide();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear hide();
	}
	i++;
	}
	
	i=0;
	time = 0.14;
	while(i < 8)
	{
	ran = randomint(boxguns.size);
	boxguns[ran] show();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt show();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear show();
	}
	
	wait(time);
	boxguns[ran] hide();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt hide();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear hide();
	}
	
	i++;
	}
	
	i=0;
	time = 0.2;
	while(i < 8)
	{
	ran = randomint(boxguns.size);
	boxguns[ran] show();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt show();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear show();
	}
	
	wait(time);
	boxguns[ran] hide();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt hide();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear hide();
	}
	
	i++;
	}
	
	i=0;
	time = 0.25;
	while(i < 5)
	{
	ran = randomint(boxguns.size);
	boxguns[ran] show();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt show();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear show();
	}
	
	wait(time);
	boxguns[ran] hide();
	
	if( (boxguns[ran].targetname == "bear_box") )
	{
		tnt hide();
	}
	else if((boxguns[ran].targetname == "tnt_box"))
	{
		bear hide();
	}
	
	i++;
	}
	
	switch(number)
	{
		case 0:
			level.rangun = "grease";
			grease thread lastflash();
			break;
		
		case 1:
			level.rangun = "carbine";
			carbine thread lastflash();
			break;
		
		case 2:
			level.rangun = "springfield";
			springfield thread lastflash();
			break;
		
		case 3:
			level.rangun = "garand";
			garand thread lastflash();
			break;
		
		case 4:
			level.rangun = "thompson";
			thompson thread lastflash();
			break;
		
		case 5:
			level.rangun = "bar";
			bar thread lastflash();
			break;
			
		case 6:
			level.rangun = "sten";
			sten thread lastflash();
			break;
			
		case 7:
			level.rangun = "enfield";
			enfield thread lastflash();
			break;
			
		case 8:
			level.rangun = "enfield_scope";
			enfield_scoped thread lastflash();
			break;
			
		case 9:
			level.rangun = "bren";
			bren thread lastflash();
			break;
		
		case 10:
			level.rangun = "pps42";
			pps43 thread lastflash();
			break;
		
		case 11:
			level.rangun = "nagant";
			nagant thread lastflash();
			break;
			
		case 12:
			level.rangun = "nagant_scoped";
			nagant_scoped thread lastflash();
			break;
		
		case 13:
			level.rangun = "svt40";
			svt40 thread lastflash();
			break;
			
		case 14:
			level.rangun = "ppsh";
			ppsh thread lastflash();
			break;
		
		case 15:
			level.rangun = "mp40";
			mp40 thread lastflash();
			break;
		
		case 16:
			level.rangun = "kar";
			kar thread lastflash();
			break;
		
		case 17:
			level.rangun = "g43";
			g43 thread lastflash();
			break;
			
		case 18:
			level.rangun = "kar_scoped";
			kar_scoped thread lastflash();
			break;
	
		case 19:
			level.rangun = "mp44";
			mp44 thread lastflash();
			break;
		
		case 20:
			level.rangun = "trench";
			trench thread lastflash();
			break;
			
		case 21:
			level.rangun = "panzer";
			panzer thread lastflash();
			break;
		
		case 22:
			level.rangun = "raygun";
			ray thread lastflash();
			break;
			
		case 23:
			level.rangun = "kar";
			kar thread lastflash();
			break;
	}
	
	//level notify("guns_flashed");
}

lastflash()
{
	level endon("weapon_picked");
	tnt = getent("tnt_box","targetname");
	
	self show();
	
	if(self.targetname == "bear_box")
	{
		tnt show();
	}
	
	
	level notify("guns_flashed");
	
	boxguns = getentarray("box_guns","target");
	for(i=0;i<boxguns.size;i++)
	{
		boxguns[i] moveto(boxguns[i].begorg,15,0.5,0.5);
	}
	//self waittill("movedone");   //may stop moving before the last ones(s)
	boxguns[boxguns.size-1] waittill("movedone");
	self hide();
	
	if(self.targetname == "bear_box")
	{
		tnt hide();
	}

	level notify("weapon_not_picked");
	level.boxtriginuse = 0;
	
	rantrig = getent("random","target");
	rantrig thread init_shops();
	rantrig setHintString("Buy Random Weapon [" + game["waw_mysterybox_cost"] + "] ");
	
	level.boxtriginuse = 0;
	
}

fenceshop(trigger)
{
	fencescost = Int(game["waw_fences_cost"]);

	if( self.power >= fencescost)
	{
		self thread maps\mp\gametypes\_basic::updatePower(fencescost * -1);
		self thread fenceactivate(trigger);
		level.fenceactivator = self;
		thread fenceactivateDelay();
	}
	else if(self.power < fencescost)
		self iprintln(&"ZMESSAGES_CANTPURCHASE");
}

fenceactivateDelay()
{
	wait(1);
	level.fenceactivated = 1;
}

fenceactivate(trigger)
{
	soundorg = getent("zap_sound","targetname");
	
	panel = spawn("script_model",soundorg.origin);
	panel.angles = (0,0,0);
	panel setmodel("xmodel/prop_bear_detail_sitting");
	
	trigger thread maps\mp\_utility::triggerOff();
	iprintln(self.name + " ^1has activated the Electric Fences!");
	
	panel playsound("sparks");
	thread fenceclipsdraw();

	zapper = getentarray("waw_zapper","targetname");
	
	for(i=0;i<3;i++)
	{
		for(s=0;s<zapper.size;s++)
		{
			zapperorigin = (zapper[s].origin[0]+9,zapper[s].origin[1]+2,zapper[s].origin[2]-17);
			playfx(level._effect["zap"],zapperorigin);
		}

	wait(20);
	}
	
	panel playsound("sparks");
	wait(2);
	level.fenceactivated = 0;
	thread fenceclipsclose();
	wait(3);
	trigger thread maps\mp\_utility::triggerOn();
	panel delete();
}

fences_init()
{
	fences = getentarray("ele_fence","targetname");
	for(i=0;i<fences.size;i++)
	{
		fences[i] thread fencekill();
	}
}

fencekill()
{
	while(1)
	{
	self waittill("trigger",other);
	if(level.fenceactivated == 1)
	{
		if(isdefined(level.fenceactivator))
		{
			if( (level.fenceactivator.pers["team"] == "allies" && other.pers["team"] == "axis"))
			{
				other thread [[level.callbackPlayerDamage]](self, level.fenceactivator, 1600, 0, "MOD_GRENADE_SPLASH", "mine_mp", self.origin, vectornormalize(other.origin + (0,0,20) - self.origin), "none", 0);
			}
			else
			{
				other suicide();
			}
		}
		else
		{
			other suicide();
		}
	}
	}
}

fenceclipsdraw()
{
	fences = getentarray("fence_clip","targetname");
	for(i=0;i<fences.size;i++)
	{
		fences[i] solid();
	}
}

fenceclipsclose()
{
	fences = getentarray("fence_clip","targetname");
	for(i=0;i<fences.size;i++)
	{
		fences[i] notsolid();
	}
}