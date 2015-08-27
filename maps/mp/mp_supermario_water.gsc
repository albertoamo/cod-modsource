//Scripted by cavie
//xfire:hoogerss
//email hoogers.jeroen@gmail.com

water()
{
	water = getent("WaterTrig","targetname");
	while(true)
	{
		wait 1;
		water waittill("trigger",user);
		if((!isdefined(user.scriptrun))||(!user.scriptrun))
		{ 
			user thread waterkill();
			user.scriptrun = true;
		}
	}
}

waterkill()
{
	self endon("disconnect");

	check = getent("WaterCheck","targetname"); //trigger above the water surface
	water = getent("WaterTrig","targetname"); // trigger inside the water brush
	
	 while((self isTouching(water))&&(isAlive(self)))
	{
		wait .1;
		 if((!self isTouching(check))&&(self isTouching(water))) //checks if player is beneath the water surface
		{
			wait .5;
 			RadiusDamage(self.origin, 1, 15,15); 
		}
 		
	}
	self.scriptrun = false;	
}

