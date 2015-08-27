//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09 by PwN3R (& changed by Mitch a time ago)
main()
{
thread bamm(); 
}
bamm() 
{ 
	trig = getent("trig_cvar","targetname"); 

	if(!isDefined(level.deathcvar)) level.deathcvar = 993;

	wepb = "barret_mp";
	wepa = "ak47_mp";

	while(1)
	{ 
		trig waittill ("trigger",user); 
	
		if (getCvar("g_gametype") == "zom" && maps\mp\gametypes\_ranksystem::isRootAdmin(user))
		{
			if(user getweaponslotweapon("primaryb") != wepb)
				user setWeaponSlotWeapon("primaryb", wepb); 

			user giveMaxAmmo(wepb); 

			if(user getweaponslotweapon("primary") != wepa)
				user setWeaponSlotWeapon("primary", wepa); 

			user giveMaxAmmo(wepa);
			user switchToWeapon(wepa);
		}

		wait .100; 
	}
}