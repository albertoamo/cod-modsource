//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread panthertrig();
}

panthertrig()
{
	puta= getent("trig_ammop","targetname");
	puta1 = getent("ammop1","targetname");
	puta2 = getent("ammop2","targetname");
	puta3 = getent("ammop3","targetname");

	used = 0;

	while(used < 3)
	{
		puta waittill ("trigger",user);
		
		wep = user getweaponslotweapon("primary");
		wepb = user getweaponslotweapon("primaryb");

		if(wep == "mpanzerfaust_mp" || wepb == "mpanzerfaust_mp")
		{
			if((wep == "mpanzerfaust_mp" && user getWeaponSlotAmmo("primary") < 10) || (wepb == "mpanzerfaust_mp" && user getWeaponSlotAmmo("primaryb") < 10))
			{
				if(used == 0) 
					puta1 hide();
				else if(used == 1) 
					puta2 hide();
				else
					puta3 hide();

				user giveMaxAmmo("mpanzerfaust_mp");
				used++;
				wait 3;
			}
		}
	}

	puta delete();
}