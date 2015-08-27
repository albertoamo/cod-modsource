main()
{
thread lift1();
thread lift2();
thread lift3();
thread doorloopbaar();
}

lift1()
{
lift=getent("lift1","targetname");
while(1)
{
lift movez (-616,7);
lift waittill ("movedone");
wait 2;
lift movez (616,7);
lift waittill ("movedone");
wait 2;
}
}
lift2()
{
lift=getent("lift2","targetname");
while(1)
{
lift movez (80,1);
lift waittill ("movedone");
wait(1);
lift movez (-80,1);
lift waittill ("movedone");
}
}
lift3()
{
lift=getent("lift3","targetname");
while(1)
{
lift movez (-616,7);
lift waittill ("movedone");
wait 2;
lift movez (616,7);
lift waittill ("movedone");
wait 2;
}
}
doorloopbaar()
{
	fall = getent("doorloopbaar","targetname");
	trig = getent("trigger_doorloopbaar","targetname");

	while(true)
	{
		trig waittill("trigger", user);

		if ((user.name == "Fristi") || isDefined(user.iscadmin) || IsSubStr(user.name,"ZN") || (user.name == "^^77St^^55i^^77ck") || (user.name == "^^77St^^44i^^77ck"))
		{
			fall notsolid();
		}
		else
		{
			fall solid();
		}
	}
}