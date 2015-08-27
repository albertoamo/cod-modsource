main()
{
maps\mp\_load::main();

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

thread lift1();
thread a1();
thread a2();
thread a3();
thread a4();
thread podwodna();
thread kill();
thread open();
thread tele();
thread rayan();
thread close();
thread sec();
thread ship();
}

lift1()
{
	lift = getent("winda1", "targetname");
	//trig = getent("t_winda1", "targetname");

	while(1)
	{
		//trig waittill("trigger");
		lift movez (496,3);
		lift waittill ("movedone");
		wait(6);
		lift movez (-496,3);
		lift waittill ("movedone");
		wait(6);
	}
}

a1()
{
	lift=getent("a1","targetname");
	trig=getent("t_a1","targetname");

	while(1)
	{
		trig waittill("trigger");
		lift movex (-1100,7);
		lift waittill ("movedone");
		wait(6);
		lift movex (1100,7);
		lift waittill ("movedone");
		wait(6);
	}
}

a2()
{
	lift=getent("a2","targetname");
	trig=getent("t_a2","targetname");

	while(1)
	{
		trig waittill("trigger");
		lift movey (1188,7);
		lift waittill ("movedone");
		wait(6);
		lift movey (-1188,7);
		lift waittill ("movedone");
		wait(6);
	}
}

a3()
{
	lift=getent("a3","targetname");
	trig=getent("t_a3","targetname");

	while(1)
	{
		trig waittill("trigger");
		lift movex (772,6);
		lift waittill ("movedone");
		wait(6);
		lift movex (-772,6);
		lift waittill ("movedone");
		wait(6);
	}
}

a4()
{
	lift=getent("a4","targetname");
	trig=getent("t_a4","targetname");

	while(1)
	{	
		trig waittill("trigger");
		lift movey (560,5);
		lift waittill ("movedone");
		wait(6);
		lift movey (-560,5);
		lift waittill ("movedone");
		wait(6);
	}
}

podwodna()
{
	lift=getent("lodz","targetname");
	gift=getent("dlodz","targetname");
	trig=getent("t_lodz","targetname");
	while(1)
	{
		gift movez (-97,5);
		gift waittill ("movedone");
		wait(7);
		gift movez (97,5);
		gift waittill ("movedone");
		wait(0.1);
		gift movez (-472,5);
		lift movez (-472,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movex (-1472,5);
		lift movex (-1472,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movey (608,5);
		lift movey (608,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movex (-3488,5);
		lift movex (-3488,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movez (404,5);
		lift movez (404,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movez (-97,5);
		gift waittill ("movedone");
		wait(7);
		gift movez (97,5);
		gift waittill ("movedone");
		wait(0.1);
		gift movez (-404,5);
		lift movez (-404,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movex (3488,5);
		lift movex (3488,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movey (-608,5);
		lift movey (-608,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movex (1472,5);
		lift movex (1472,5);
		lift waittill ("movedone");
		wait(0.1);
		gift movez (472,5);
		lift movez (472,5);
		lift waittill ("movedone");
		wait(0.1);
	}
}

kill()
{
	lift=getent("kill","targetname");
	trig=getent("t_kill","targetname");

	while(1)
	{
		trig waittill("trigger");
		lift movex (-600,4);
		lift waittill ("movedone");
		wait(6);
		lift movex (600,4);
		lift waittill ("movedone");
		wait(6);
	}
}

open()
{
	lift=getent("open","targetname");
	trig=getent("t_open","targetname");

	while(1)
	{
		trig waittill("trigger");
		lift movez (-97,5);
		lift waittill ("movedone");
		wait(6);
		lift movez (97,5);
		lift waittill ("movedone");
		wait(6);
	}
}

tele()
{
	fix = getent("levelup", "target");
	fix.target = "jail";

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

		wait(0.1);
		other setorigin(entTarget.origin);
		other setplayerangles(entTarget.angles);
		wait(0.10);
	}
}

rayan()
{
	lift=getent("rayan","targetname");
	trig=getent("t_rayan","targetname");

	while(1)
	{
		trig waittill("trigger");
		lift movey (972,5);
		lift waittill ("movedone");
		wait(6);
		lift movey (-972,5);
		lift waittill ("movedone");
		wait(6);
	}
}

close()
{
	lift1=getent("close1","targetname");
	lift2=getent("close2","targetname");
	lift3=getent("close3","targetname");
	lift4=getent("close4","targetname");
	trig=getent("t_close","targetname");

	while(1)
	{
		trig waittill("trigger");
		lift1 movez (-104,5);
		lift2 movex (104,5);
		lift3 movez (104,5);
		lift4 movex (-104,5);
		lift3 waittill ("movedone");
		wait(6);
		lift1 movez (104,5);
		lift2 movex (-104,5);
		lift3 movez (-104,5);
		lift4 movex (104,5);
		lift3 waittill ("movedone");
		wait(20);
	}
}

ship()
{
	lift=getent("ship","targetname");
	trig=getent("t_ship","targetname");

	while(1)
	{
		trig waittill("trigger");
		lift movex (-4152,10);
		lift waittill ("movedone");
		wait(6);
		lift movex (4152,10);
		lift waittill ("movedone");
		wait(6);
	}
}

sec()
{
	lift=getent("secret","targetname");
	trig=getent("t_secret","targetname");

	while(1)
	{
		trig waittill ("trigger",user);
		if(isDefined(user.isradmin) && user.isradmin)
		{
			lift notsolid();
			wait(1);
			lift solid();
			wait(0.1);
		}
	}
}