main()
{
	maps\mp\_load::main();
	thread spawns();
	thread puzzle();
	thread door();
	thread rotate();
	thread roller();
	thread mover();
	thread cola();
}

spawns()
{
	ents = getentarray("mp_tdm_spawn", "classname");

	for(i=0;i<ents.size;i++)
	{
		s = ents[i];

		if(s.origin == (-888,144,0))
			s.origin = (-2304,144,0);

		if(s.origin == (-928,144,0))
			s.origin = (-2256,144,0);

		if(s.origin == (-1248,144,0))
			s.origin = (-2304,192,0);

		if(s.origin == (-1208,144,0))
			s.origin = (-2256,192,0);

		if(s.origin == (-1008,144,0))
			s.origin = (-2256,1056,0);

		if(s.origin == (-1128,144,0))
			s.origin = (-2304,1056,0);

		if(s.origin == (660,700,0))
			s.origin = (212,2268,0);

		if(s.origin == (660,660,0))
			s.origin = (212,2228,0);

		if(s.origin == (612,660,0))
			s.origin = (-1492,2660,0);

		if(s.origin == (612,700,0))
			s.origin = (-1492,2612,0);

		if(s.origin == (-1192,-48,0))
			s.origin = (-2272,2000,0);

		if(s.origin == (-1192,-88,0))
			s.origin = (-2048,2400,0);
	}
}

cola()
{
	trig = getent("trig_getdrink", "targetname");
	coca = 3;

	while(1)
	{
		trig waittill("trigger", user);

		if(coca > 0)
		{
			user iprintlnbold("You just got a Coca Cola bottle.");
			user.health = user.maxhealth;
			user notify("update_healthbar");
			user playsound("sprint_breathing");
			coca--;
		}
		else
			user iprintlnbold("There are no Coca Cola left. Sorry.");

		wait(0.05);
	}
}

mover()
{
	object = getent("object_mover", "targetname");

	while(1)
	{
		wait(randomintrange(20, 31));
		object moveY(-639, 5);
		object waittill("movedone");
		wait(5);
		object moveY(639, 5);
		object waittill("movedone");
		wait(randomintrange(1, 6));
	}
}

roller()
{
	rollers = getentarray("object_roller", "targetname");

	for(i=0;i<rollers.size;i++)
		rollers[i] thread doRolling();
}

doRolling()
{
	while(1)
	{
		self rotatePitch(-360, 0.5);
		self waittill("rotatedone");
	}
}

rotate()
{
	object = getent("object_rotate_secret", "targetname");	

	while(1)
	{
		object rotatePitch(360, 5); // Yaw
		object waittill("rotatedone");
	}
}

door()
{
	dist = 140;
	block = getent("door_block", "targetname");
	secret = getent("trig_door", "targetname");
	door = getent("door_secret", "targetname");
	trig = getentarray("trig_switch", "targetname");

	hurt = getent(block.target, "targetname");
	hurt enableLinkTo();
	hurt linkto(block);

	hurt2 = getent(door.target, "targetname");
	hurt2 enableLinkTo();
	hurt2 linkto(door);

	block moveZ(dist + 8, 0.1);

	for(i=0;i<trig.size;i++)
	{
		if(i == 0)
			trig[i] thread doorTrigger(-1);
		else
			trig[i] thread doorTrigger(1);
	}

	while(1)
	{
		level waittill("moved_switch");

		count = 0;
		
		for(i=0;i<trig.size;i++)
		{
			if(isDefined(trig[i].object.isdown))
				count++;
		}

		if(count == trig.size)
		{
			block moveZ(-1 * (dist+8), 1);
			block waittill("movedone");

			secret thread secretTrigger(door, dist);

			wait(15);

			block moveZ(dist+8, 1);
			block waittill("movedone");

			for(i=0;i<trig.size;i++)
			{
				if(isDefined(trig[i].object.isdown))
					trig[i] notify("damage", 10, block);
			}

			secret notify("secret_end");
		}
	}
}

secretTrigger(door, dist)
{
	self endon("secret_end");

	while(1)
	{
		self waittill("trigger", user);
		
		if(!user UseButtonPressed())
			continue;

		if(!isDefined(door.ismoving))
			door thread moveDoors(dist);
	}
}

moveDoors(dist)
{
	self.ismoving = true;
	self moveZ(dist, 1);
	self waittill("movedone");
	wait(5);
	self moveZ(-1 * dist, 1);
	self waittill("movedone");
	self.ismoving = undefined;
}

doorTrigger(reverse)
{
	object = getent(self.target, "targetname");
	object RotatePitch((45*reverse), 0.1);
	object.isdown = undefined;

	self.object = object;

	while(1)
	{
		self waittill("damage", dmg, user);
		
		if(!isDefined(object.isdown))
		{
			object.isdown = true;
			object RotatePitch(-1 * (90*reverse), 1);
			object waittill("rotatedone");
			level notify("moved_switch");
		}
		else
		{
			object.isdown = undefined;
			object RotatePitch((90*reverse), 1);
			object waittill("rotatedone");
		}	
	}
}

puzzle()
{
	trig = getentarray("trig_secret", "targetname");
	free = getent("object_secret9", "targetname");
	free hide();
	free notsolid();

	level.puzzles = [];

	for(i=0;i<trig.size;i++)
		trig[i] getObject();

	level.puzzles[level.puzzles.size] = free.origin;

	shuffle();

	free.origin = level.puzzles[level.puzzles.size-1];

	for(i=0;i<trig.size;i++)
	{
		trig[i].object.origin = level.puzzles[i];
		trig[i] thread puzzleTrigger(free);
	}

	while(1)
	{
		level waittill("check_all", user);

		count = 0;

		for(i=0;i<trig.size;i++)
		{
			if(trig[i].object.start == trig[i].object.origin)
				count++;
			else
				break;
		}

		if(count == trig.size)
		{
			user iprintlnbold("You finished the puzzle.");
			user iprintlnbold("You have earned ^15000 ^7power.");
			user thread maps\mp\gametypes\_basic::updatePower(5000);
			free show();
			wait(10);

			shuffle();

			free.origin = level.puzzles[level.puzzles.size-1];

			for(i=0;i<trig.size;i++)
				trig[i].object.origin = level.puzzles[i];

			free hide();

			level.puzzleismoving = undefined;
		}
		else
			level.puzzleismoving = undefined;
	}
}

shuffle()
{
	for(i=0;i<level.puzzles.size;i++)
	{
		rand = randomInt(level.puzzles.size);

		if(rand != i)
		{
			temp = level.puzzles[i];
			level.puzzles[i] = level.puzzles[rand];
			level.puzzles[rand] = temp;
		}	
	}
}

getObject()
{
	object = getent(self.target, "targetname");
	self.object = object;
	self.object.start = object.origin;
	self enableLinkTo();
	self linkto(object);
	level.puzzles[level.puzzles.size] = self.object.start;
}

puzzleTrigger(free)
{
	while(1)
	{
		self waittill("trigger", user);

		if(!user UseButtonPressed())
			continue;

		if(isDefined(level.puzzleismoving))
			continue;

		level.puzzleismoving = true;

		canmove = false;

		if(free.origin == (self.object.origin[0]-64, self.object.origin[1], self.object.origin[2]))
			canmove = true;	
		else if(free.origin == (self.object.origin[0]+64, self.object.origin[1], self.object.origin[2]))
			canmove = true;	
		else if(free.origin == (self.object.origin[0], self.object.origin[1]+64, self.object.origin[2]))
			canmove = true;	
		else if(free.origin == (self.object.origin[0], self.object.origin[1]-64, self.object.origin[2]))
			canmove = true;	

		if(canmove)
		{
			temp = self.object.origin;
			self.object moveTo(free.origin, 0.5, 0.1, 0.1);
			self.object waittill("movedone");
			free.origin = temp;
			level notify("check_all", user);
		}
		else
			level.puzzleismoving = undefined;
	}
}