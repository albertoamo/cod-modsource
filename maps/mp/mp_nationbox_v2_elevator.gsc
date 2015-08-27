main()
{
thread elevator1();
thread elevator2();
thread elevator3();
thread elevator4();
thread elevator5();
thread elevator6();
thread elevator7();
thread elevator8();
}

elevator1()
{
elevator1=getent("elevator1","targetname");
trig=getent("trig_elevator1","targetname");
while(9)
{
trig waittill ("trigger");
elevator1 movez (488,4,0.9,1.9);
elevator1 waittill ("movedone");
wait(5);
elevator1 movez (-488,4,0.9,2);
elevator1 waittill ("movedone");
}
}

elevator2()
{
elevator2=getent("elevator2","targetname");
trig=getent("trig_elevator2","targetname");
while(20)
{
trig waittill ("trigger");
elevator2 movez (2144,4,0.9,1.9);
elevator2 waittill ("movedone");
wait(10);
elevator2 movez (-2144,4,0.9,2);
elevator2 waittill ("movedone");
}
}

elevator3()
{
elevator3=getent("elevator3","targetname");
trig=getent("trig_elevator3","targetname");
while(20)
{
trig waittill ("trigger");
elevator3 movey (-4800,5,2,2);
elevator3 waittill ("movedone");
wait(10);
elevator3 movey (4800,5,2,2);
elevator3 waittill ("movedone");
}
}

elevator4()
{
elevator1=getent("elevator4","targetname");
trig=getentarray("trig_elevator4","targetname");
level.box_elevator4moving = false;

	for(i=0;i<trig.size;i++)
	{
		trig[i] thread elevator4_Move(elevator1);
	}
}
elevator4_Move(elevator1)
{
	while(1)
	{
		self waittill ("trigger");
		if(!level.box_elevator4moving)
		{
			level.box_elevator4moving = true;
			elevator1 movey (472,5,2,2);
			elevator1 waittill ("movedone");
			wait(5);
			elevator1 movey (-472,5,2,2);
			elevator1 waittill ("movedone");
			wait(5);
			level.box_elevator4moving = false;
		}
	}
}

elevator5()
{
elevator1=getent("elevator5","targetname");
trig=getent("trig_elevator5","targetname");
while(9)
{
trig waittill ("trigger");
elevator1 movez (224,4,0.9,2);
elevator1 waittill ("movedone");
wait(5);
elevator1 movez (-224,4,0.9,2);
elevator1 waittill ("movedone");
}
}

elevator6()
{
elevator1=getent("elevator6","targetname");
trig=getent("trig_elevator6","targetname");
while(9)
{
trig waittill ("trigger");
elevator1 movez (192,4,0.9,2);
elevator1 waittill ("movedone");
wait(5);
elevator1 movez (-192,4,0.9,2);
elevator1 waittill ("movedone");
}
}

elevator7()
{
elevator1=getent("elevator7","targetname");
trig=getent("trig_elevator7","targetname");
while(9)
{
trig waittill ("trigger");
elevator1 movez (-512,4,1.9,1.9);
elevator1 waittill ("movedone");
elevator1 movey (256,4,1.9,1.9);
elevator1 waittill ("movedone");
wait(5);
elevator1 movey (-256,4,0.9,2);
elevator1 waittill ("movedone");
elevator1 movez (512,4,0.9,2);
elevator1 waittill ("movedone");
}
}

elevator8()
{
elevator1=getent("elevator8","targetname");
trig=getent("trig_elevator8","targetname");
while(9)
{
trig waittill ("trigger");
elevator1 movez (-1536,4,0.9,1.9);
elevator1 waittill ("movedone");
wait(5);
elevator1 movez (1536,4,0.9,2);
elevator1 waittill ("movedone");
}
}
