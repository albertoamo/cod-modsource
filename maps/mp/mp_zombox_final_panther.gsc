//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
	thread panther();
}

panther()
{
	precacheitem("mpanzerfaust_mp");

	po= getent("trig_p","targetname");
	po1 = getent("p1","targetname");
	po2 = getent("p2","targetname");
	po3 = getent("p3","targetname");

	used = 0;

	while(used < 3)
	{
		po waittill ("trigger",user);

		wep = user getweaponslotweapon("primary");
		wepb = user getweaponslotweapon("primaryb");

		if(wep != "mpanzerfaust_mp" && wepb != "mpanzerfaust_mp")
		{
			if(used == 0)
				po1 hide();
			else if(used == 1)
				po2 hide();
			else
				po3 hide();

			user setWeaponSlotWeapon("primaryb", "mpanzerfaust_mp");
			user switchToWeapon("mpanzerfaust_mp");
			used++;
			wait 3;
		}
	}

	po delete();
}

