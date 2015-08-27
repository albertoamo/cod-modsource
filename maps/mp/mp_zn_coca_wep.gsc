main()
{
	game["menu_coca_weps"] = "coca_weps";
	precacheMenu(game["menu_coca_weps"]);

	game["coca_shop_prices"] = [];
	game["coca_shop_prices"]["ak47_mp"] = 5000;
	game["coca_shop_prices"]["ak74_mp"] = 5000;
	game["coca_shop_prices"]["g36_mp"] = 5000;
	game["coca_shop_prices"]["uzi_mp"] = 5000;
	game["coca_shop_prices"]["sig_mp"] = 5000;
	game["coca_shop_prices"]["m14_mp"] = 5000;
	game["coca_shop_prices"]["m14_scoped_mp"] = 5000;
	game["coca_shop_prices"]["remington_mp"] = 7000;
	game["coca_shop_prices"]["barret_mp"] = 10000;
	game["coca_shop_prices"]["benelli_mp"] = 7000;
	game["coca_shop_prices"]["winchester_mp"] = 7000;
	game["coca_shop_prices"]["rpd_mp"] = 5000;
	game["coca_shop_prices"]["mosberg_mp"] = 7000;
	game["coca_shop_prices"]["p90_mp"] = 10000;
	game["coca_shop_prices"]["tesla_mp"] = 20000;
	game["coca_shop_prices"]["scout_mp"] = 7500;
	game["coca_shop_prices"]["crossbow_mp"] = 7500;

	thread cocaWep();
}

cocaWep()
{
	level endon("intermission");

	trig = getent("trig_cocawep", "targetname");

	while(1)
	{
		trig waittill("trigger", user);

		if(user.pers["team"] == "allies")
		{
			if(IsSubStr(user.name,"ZN"))
				user thread openWepMenu();
			else
				user iprintlnbold("^7Sorry, " + user.name + ". \n^4[^7ZN^4]^7 Members Only");
		}
		else
			user iprintlnbold(&"ZMESSAGES_NOTHUNTER");
	}
}

openWepMenu()
{
	self notify("openedcocashop");
	self endon("openedcocashop");

	self closeMenu();
	self closeInGameMenu();

	self openMenu(game["menu_coca_weps"]);
	self thread onMenuResponse();
}

onMenuResponse()
{
	level endon("intermission");
	self endon("disconnect");
	self notify("closedcocashop");
	self endon("closedcocashop");

	self setClientCvar("ui_coca_wep_price", "^2M^9ove over a weapon to see the price^1. ^2C^9lick and ^2B^9uy^1.");

	for(;;)
	{
		self waittill("menuresponse", menu, response);

		if(menu == game["menu_coca_weps"])
		{
			if(response == "close_coca_weps")
			{
				self notify("closedcocashop");
			}
			else if(GetSubStr( response, 0, 6 ) == "price_")
			{
				wep = GetSubStr(response, 6, response.size);
				if(isDefined(game["coca_shop_prices"][wep]))
				{
					wepname = maps\mp\gametypes\_weapons::getWeaponName2(wep);
					self setClientCvar("ui_coca_wep_price", wepname + "^1:^3 " + game["coca_shop_prices"][wep] + "(XP)");
				}
			}
			else if(!maps\mp\gametypes\_weapons::isZombieWep(response) && maps\mp\gametypes\_weapons::isUnlockedWep(response) && isDefined(game["coca_shop_prices"][response]))
			{
				if(self.power >= game["coca_shop_prices"][response])
				{
					self closeMenu();
					self closeInGameMenu();
					self thread BuyWeapon(response, game["coca_shop_prices"][response]);
					self notify("closedcocashop");
				}
				else
					self setClientCvar("ui_coca_wep_price", "^1You haven't got that much power!!!");
			}
		}
	}
}

BuyWeapon(wep, price)
{
	weapon = self maps\mp\gametypes\_weapons::restrictWeaponByServerCvars(wep);

	if(weapon == "restricted")
		return;

	self thread maps\mp\gametypes\_basic::updatePower(price * -1);

	current = self GetCurrentWeapon();
	weapon1 = self getweaponslotweapon("primary");
	weapon2 = self getweaponslotweapon("primaryb");

	slot = "primary";

	if(current == weapon2)
		slot = "primaryb";

	if(weapon1 == wep)
		slot = "primary";
	else if(weapon2 == wep)
		slot = "primaryb";	

	self setWeaponSlotWeapon(slot, wep);
	self setWeaponSlotAmmo(slot, 999);
	self setWeaponSlotClipAmmo(slot, 999);
	self SwitchToWeapon(wep);
}