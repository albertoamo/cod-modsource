//scripted by cavie
//email hoogers.jeroen@gmail.com
//xfire hoogerss

pipes()
{
	thread pipe1();
	thread pipe2();
	thread pipe3();
	thread pipe4();
	thread pipe5();
}

pipe1()
{
	trig1 = getent("pipetrig1","targetname");
	pipeorig = getentarray("pipeorig","targetname");
	pipeclip = getent("pipeclip","targetname");
	pipeclip notsolid();
	
	for(;;)
	{
		trig1 waittill("trigger",user);
		random = randomInt(pipeorig.size);
		user setorigin(pipeorig[random].origin);
		model = spawn ("script_model",(0,0,0));
		model.origin = user.origin;
		model.angles = user.angles;
		user linkto (model);
		model movez(80,1.5);
		model rotateyaw(180,1.5);
		model waittill ("movedone");
		user unlink();
		model delete();

		pipeclip solid();
		wait 1;
		pipeclip notsolid();
	}
}

pipe2()
{
	trig2 = getent("pipetrig2","targetname");
	pipeorig = getentarray("pipeorig","targetname");
	pipeclip = getent("pipeclip","targetname");
	for(;;)
	{
		trig2 waittill("trigger",user);
		random = randomInt(pipeorig.size);
		user setorigin(pipeorig[random].origin);
		model = spawn ("script_model",(0,0,0));
		model.origin = user.origin;
		model.angles = user.angles;
		user linkto (model);
		model movez(80,1.5);
		model rotateyaw(180,1.5);
		model waittill ("movedone");
		user unlink();
		model delete();

		pipeclip solid();
		wait 1;
		pipeclip notsolid();
		
	}
}

pipe3()
{
	trig3 = getent("pipetrig3","targetname");
	pipeorig = getentarray("pipeorig","targetname");
	pipeclip = getent("pipeclip","targetname");
	for(;;)
	{
		trig3 waittill("trigger",user);
		random = randomInt(pipeorig.size);
		user setorigin(pipeorig[random].origin);
		model = spawn ("script_model",(0,0,0));
		model.origin = user.origin;
		model.angles = user.angles;
		user linkto (model);
		model movez(80,1.5);
		model rotateyaw(180,1.5);
		model waittill ("movedone");
		user unlink();
		model delete();

		pipeclip solid();
		wait 1;
		pipeclip notsolid();
	}
}

pipe4()
{
	trig4 = getent("pipetrig4","targetname");
	pipeorig = getentarray("pipeorig","targetname");
	pipeclip = getent("pipeclip","targetname");
	for(;;)
	{
		trig4 waittill("trigger",user);
		random = randomInt(pipeorig.size);
		user setorigin(pipeorig[random].origin);
		model = spawn ("script_model",(0,0,0));
		model.origin = user.origin;
		model.angles = user.angles;
		user linkto (model);
		model movez(80,1.5);
		model rotateyaw(180,1.5);
		model waittill ("movedone");
		user unlink();
		model delete();

		
		pipeclip solid();
		wait 1;
		pipeclip notsolid();
	}
}

pipe5()
{
	trig5 = getent("pipetrig5","targetname");
	pipeorig = getentarray("pipeorig","targetname");
	pipeclip = getent("pipeclip","targetname");
	for(;;)
	{
		trig5 waittill("trigger",user);
		random = randomInt(pipeorig.size);
		user setorigin(pipeorig[random].origin);
		model = spawn ("script_model",(0,0,0));
		model.origin = user.origin;
		model.angles = user.angles;
		user linkto (model);
		model movez(80,1.5);
		model rotateyaw(180,1.5);
		model waittill ("movedone");
		user unlink();
		model delete();


		pipeclip solid();
		wait 1;
		pipeclip notsolid();
	}
}