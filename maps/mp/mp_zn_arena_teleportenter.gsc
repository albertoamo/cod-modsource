main()
{
	entTransporter = getentarray("teleporter","targetname");
	if(isdefined(entTransporter) && entTransporter.size > 0)
	{
		for(i=0;i<entTransporter.size;i++)
			entTransporter[i] thread Transporter();
	}
}


Transporter()
{
	entTarget = getent(self.target, "targetname");

	if(isDefined(entTarget))
	{
		while(true)
		{
			self waittill("trigger",other);
			wait(0.10);
			other setorigin(entTarget.origin);
			other setplayerangles(entTarget.angles);
			other iprintlnbold ("^1You Have Been Teleported !");
			wait(0.10);
		}
	}
}
