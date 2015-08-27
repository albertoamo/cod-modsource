main() 
{
	thread onWepTrigger();
}

onWepTrigger()
{
	trig=getent("weapons","targetname");
	trig waittill ("trigger", user);
	if(isPlayer(user) && isDefined(user.debugmode) && user.debugmode)
		user iprintln("weapons trigger");

	trig delete();
	thread weapons_bazooka1();
	thread weapons_bazooka2();
	thread weapons_kar();
	thread weapons_kar_scoped();
	thread weapons_ppsh();
	thread weapons_trenchgun();
	thread weapons_sten();
}

weapons_bazooka1()
{
	liftpad=getent("weapons_bazooka1","targetname");
	wait (500);
	liftpad delete();
}


weapons_bazooka2()
{
	liftpad=getent("weapons_bazooka2","targetname");
	wait (1150);
	liftpad delete();
}


weapons_kar()
{
	liftpad=getent("weapons_kar","targetname");
	wait (700);
	liftpad delete();
}


weapons_kar_scoped()
{
	liftpad=getent("weapons_kar_scoped","targetname");
	wait (1400);
	liftpad delete();
}


weapons_trenchgun()
{
	liftpad=getent("weapons_trenchgun","targetname");
	wait (200);
	liftpad delete();
}


weapons_ppsh()
{
	liftpad=getent("weapons_ppsh","targetname");
	wait (400);
	liftpad delete();
}


weapons_sten()
{
	liftpad=getent("weapons_sten","targetname");
	wait (1000);
	liftpad delete();
}
