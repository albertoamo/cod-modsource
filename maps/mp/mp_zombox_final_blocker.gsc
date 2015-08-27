main()
{
	
	thread wood();
	thread wood1();
	thread wood2();
	thread wood3();
	//thread wood4();
	
}
wood()
{	
	wood = getent("wood", "targetname"); 
	wood1 = getent("wood1", "targetname"); 
	wood2 = getent("wood2", "targetname"); 
	onswitch = getent("apear", "targetname"); 
	offswitch = getent("disapear", "targetname");
	while(1)
	{
		offswitch waittill("trigger");
            wood PlaySound("cojer");
		wood hide();
		wood notsolid();
		wait(1);
		offswitch waittill("trigger");
            wood1 PlaySound("cojer");
		wood1 hide();
		wood1 notsolid();
		wait(1);
		offswitch waittill("trigger");
            wood2 PlaySound("cojer");
		wood2 hide();
		wood2 notsolid();
		wait(1.5);
		onswitch waittill("trigger");
            wood PlaySound("cojer");
		wood show();
		wood solid();
		wait(1.5);
		onswitch waittill("trigger");
            wood1 PlaySoundAsMaster("cojer");
		wood1 show();
		wood1 solid();
		wait(1.5);
		onswitch waittill("trigger");
            wood2 PlaySound("cojer");
		wood2 show();
		wood2 solid();
	}
}
wood1()
{	
	wood3 = getent("wood3", "targetname"); 
	wood4 = getent("wood4", "targetname"); 
	wood5 = getent("wood5", "targetname"); 
	onswitch = getent("apear1", "targetname"); 
	offswitch = getent("disapear1", "targetname");
	while(1)
	{
		offswitch waittill("trigger");
            wood3 PlaySound("cojer");
		wood3 hide();
		wood3 notsolid();
		wait(1);
		offswitch waittill("trigger");
            wood4 PlaySound("cojer");
		wood4 hide();
		wood4 notsolid();
		wait(1);
		offswitch waittill("trigger");
            wood5 PlaySound("cojer");
		wood5 hide();
		wood5 notsolid();
		wait(1.5);
		onswitch waittill("trigger");
            wood3 PlaySound("cojer");
		wood3 show();
		wood3 solid();
		wait(1.5);
		onswitch waittill("trigger");
            wood4 PlaySound("cojer");
		wood4 show();
		wood4 solid();
		wait(1.5);
		onswitch waittill("trigger");
            wood5 PlaySound("cojer");
		wood5 show();
		wood5 solid();
	}
}
wood2()
{	
	wood6 = getent("wood6", "targetname"); 
	wood7 = getent("wood7", "targetname"); 
	wood8 = getent("wood8", "targetname"); 
	onswitch = getent("apear2", "targetname"); 
	offswitch = getent("disapear2", "targetname");
	while(1)
	{
		offswitch waittill("trigger");
            wood6 PlaySound("cojer");
		wood6 hide();
		wood6 notsolid();
		wait(1);
		offswitch waittill("trigger");
            wood7 PlaySound("cojer");
		wood7 hide();
		wood7 notsolid();
		wait(1);
		offswitch waittill("trigger");
            wood8 PlaySound("cojer");
		wood8 hide();
		wood8 notsolid();
		wait(1.5);
		onswitch waittill("trigger");
            wood6 PlaySoundAsMaster("cojer");
		wood6 show();
		wood6 solid();
		wait(1.5);
		onswitch waittill("trigger");
            wood7 PlaySound("cojer");
		wood7 show();
		wood7 solid();
		wait(1.5);
		onswitch waittill("trigger");
            wood8 PlaySound("cojer");
		wood8 show();
		wood8 solid();
	}
}
wood3()
{	
	wood9 = getent("wood9", "targetname"); 
	wood10 = getent("wood10", "targetname"); 
	wood11 = getent("wood11", "targetname"); 
	onswitch = getent("apear3", "targetname"); 
	offswitch = getent("disapear3", "targetname");
	while(1)
	{
		offswitch waittill("trigger");
            wood9 PlaySound("cojer");
		wood9 hide();
		wood9 notsolid();
		wait(1);
		offswitch waittill("trigger");
            wood10 PlaySound("cojer");
		wood10 hide();
		wood10 notsolid();
		wait(1);
		offswitch waittill("trigger");
            wood11 PlaySound("cojer");
		wood11 hide();
		wood11 notsolid();
		wait(1.5);
		onswitch waittill("trigger");
            wood9 PlaySound("cojer");
		wood9 show();
		wood9 solid();
		wait(1.5);
		onswitch waittill("trigger");
            wood10 PlaySound("cojer");
		wood10 show();
		wood10 solid();
		wait(1.5);
		onswitch waittill("trigger");
            wood11 PlaySound("cojer");
		wood11 show();
		wood11 solid();
	}
}
wood4()
{	
	wood12 = getent("wood12", "targetname"); 
	wood13 = getent("wood13", "targetname"); 
	wood14 = getent("wood14", "targetname"); 
	onswitch = getent("apear4", "targetname"); 
	offswitch = getent("disapear4", "targetname");
	while(1)
	{
		offswitch waittill("trigger");
		wood12 PlaySound("cojer");
		wood12 hide();
		wood12 notsolid();
		wait(1);
		offswitch waittill("trigger");
		wood13 PlaySound("cojer");
		wood13 hide();
		wood13 notsolid();
		wait(1);
		offswitch waittill("trigger");
		wood14 PlaySound("cojer");
		wood14 hide();
		wood14 notsolid();
		wait(1.5);
		onswitch waittill("trigger");
		wood12 PlaySound("cojer");
		wood12 show();
		wood12 solid();
		wait(1.5);
		onswitch waittill("trigger");
		wood13 PlaySound("cojer");
		wood13 show();
		wood13 solid();
		wait(1.5);
		onswitch waittill("trigger");
		wood14 PlaySound("cojer");
		wood14 show();
		wood14 solid();
	}
}