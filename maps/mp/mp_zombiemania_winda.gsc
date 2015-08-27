main()
{
	thread winda();
	thread winda2();
}

winda()
{
	winda=getent("winda","targetname");
	trig=getent("trig_winda","targetname");

	while(2)
	{
		trig waittill ("trigger");
		wait(5);
		winda movez (900,7,1.9,1.9);
		winda waittill ("movedone");
		wait(5);
		winda movez (-900,7,1.9,5);
		winda waittill ("movedone");
	}
}

winda2()
{
	winda=getent("winda2","targetname");
	trig=getent("trig_winda2","targetname");

	while(2)
	{
		trig waittill ("trigger");
		wait(5);
		winda movez (-450,7,1.9,1.9);
		winda waittill ("movedone");
		wait(5);
		winda movez (450,7,1.9,5);
		winda waittill ("movedone");
	}
}