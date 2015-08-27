main()
{

  entTransporter = getentarray("enter","targetname");
  if(isdefined(entTransporter))
  {
    for(lp=0;lp<entTransporter.size;lp=lp+1)
      entTransporter[lp] thread Transporter();
  }


}


Transporter()
{
	while(true)
	{
		self waittill("trigger",other);
		entTarget = getent(self.target, "targetname");

		wait(0.10);

		tempOrigin = entTarget.origin;

		if(tempOrigin[1] == 3336)
			tempOrigin = (tempOrigin[0], RandomIntRange( 3336, 3713 ), tempOrigin[2]);
		
   		other setorigin(tempOrigin);
    		other setplayerangles(entTarget.angles);
    		//iprintlnbold ("You have been teleported !!!");
    		wait(0.10);
	}
}
