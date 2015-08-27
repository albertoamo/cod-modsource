main()
{
	thread tele1();
	thread tele2();

}
tele1()
{

	entteleporter = getentarray("tele1","targetname");
	if(isdefined(entteleporter))
	{
		for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleportert();

	}
}
tele2()
{

	entteleporter = getentarray("tele2","targetname");
	if(isdefined(entteleporter))
	{
		for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleportert();

	}
}
teleportert()
{
	while(true)
	{
		self waittill("trigger",other);
		entTarget = getent(self.target, "targetname");

		wait(0.10);
		other setorigin(entTarget.origin);
		other setplayerangles(entTarget.angles);
		wait(0.10);
	}
}
teleportertt()
{
	while(true)
	{
		self waittill("trigger",other);
		entTarget = getent(self.target, "targetname");

		wait(0.10);
		other setorigin(entTarget.origin);
		other setplayerangles(entTarget.angles);
		wait(0.10);
		return;
	}
}
