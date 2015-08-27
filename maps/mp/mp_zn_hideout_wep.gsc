main()
{
	precacheItem("panzerschreck_mp");
	thread getAllWepTriggers();
	thread SpecialDoor();
}

SpecialDoor()
{
	trig = getent("trig_specialroom", "targetname");
	door = getent(trig.target, "targetname");

	price = trig.count;
	//opened = false;

	while(1) //opened == false)
	{
		trig waittill("trigger", player);

		if(player.power >= price && player.pers["team"] == "allies")
		{
			player thread maps\mp\gametypes\_basic::updatePower(price * -1);

			door MoveZ(160, 3);
			door waittill("movedone");
			trig maps\mp\_utility::triggerOff();
			level waittill("zom_roundrestart");
			door MoveZ(-160, 1);
			door waittill("movedone");
			trig maps\mp\_utility::triggerOn();
		}
		else if(player.pers["team"] == "allies")
			player iprintln(&"ZMESSAGES_CANTPURCHASE");

		wait(0.05);
	}
}

getAllWepTriggers()
{
	trigger = getentarray("trig_buywep", "targetname");

	for(i=0;i<trigger.size;i++) trigger[i] thread BuyWep();
}

getBuyWepPrice(weapon)
{
	isdefault = false;
	name = undefined;
	text = undefined;

	switch(weapon)
	{
		case "tesla_mp":
			self.count = 10000;
			name = "tesla";
			break;

		default:
			isdefault = true;		
			break;
	}

	price = self.count;

	if(!isdefault)
	{
		self SetHintString("Press [Use] to buy " + name + " [" + price +"]");
	}

	return price;
}

BuyWep()
{
	wep = self.script_label;
	maxammo = self.script_shots;
	price = self getBuyWepPrice(wep);

	while(1)
	{
		self waittill("trigger", player);

		if(player.power >= price && player.pers["team"] == "allies")
		{
			wepcurrent = player getcurrentweapon();
			weapon1 = player getweaponslotweapon("primary");
			weapon2 = player getweaponslotweapon("primaryb");

			if(wepcurrent == weapon1)
				currentslot = "primary";
			else
				currentslot = "primaryb";

			if(player hasweapon(wep))
			{
				ammo = player getweaponslotammo(currentslot);

				if(ammo < maxammo)
				{
					if(weapon1 == wep)
						player giveMaxAmmo(weapon1);
					else
						player giveMaxAmmo(weapon2);

					player thread maps\mp\gametypes\_basic::updatePower(price * -1);
				}
			}
			else
			{
				player setweaponslotweapon(currentslot, wep);
				player giveMaxAmmo(wep);
				player thread maps\mp\gametypes\_basic::updatePower(price * -1);
			}

			player switchToWeapon(wep);
		}
		else if(player.pers["team"] == "allies")
		{
			player iprintln(&"ZMESSAGES_CANTPURCHASE");
		}

		wait(0.05);	
	}
}