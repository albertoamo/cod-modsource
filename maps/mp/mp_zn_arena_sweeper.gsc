main()
{
	thread monitor();
	thread door();
}

door()
{
	trig = getent("doortrig","targetname");

	while(1)
	{
		trig waittill("trigger");
		sweeper();
	}
}

sweeper()
{
	elevator = getent("swieper","targetname");
	elevator1 = getent("swiepervorm","targetname");

	wait(15);
	elevator1 movez (272,9);
	elevator1 waittill ("movedone");
	wait(5);
	elevator1 movez (-272 * 2 + 20,9);
	elevator1 waittill ("movedone");
	wait(1);
	level notify("start_sweeper");
	itime = 9;
	wait (1);
	endrotate = false;

	while(!endrotate)
	{
		elevator rotateyaw (-360,itime);
		elevator waittill ("rotatedone");
		itime = itime - 0.5;
		
		if(itime<2)
			itime = 2;

		if(level.endsweeper)
		{
			endrotate = true;
		}
		
	}

	elevator1 movez (252,5);
	elevator1 waittill ("movedone");
}

monitor()
{
	paal = getentarray("paal","targetname");

	for(;;)
	{
		level waittill("start_sweeper");
		level.endsweeper = false;

		playersonsweeper = checkPalen(paal);

		if(playersonsweeper == 0)
			level.endsweeper = true;
		else
		{	
			//iprintlnbold("^7Number of players^1: ^7" + playersonsweeper);
			thread monitorallplayers(paal);
			//thread time();
			level waittill("end_sweeper");
			level.endsweeper = true;
		}
	}

}

time()
{
	time = 0;

	while(!level.endsweeper)
	{
		time++;
		wait(1);
	}

	iprintlnbold("Total time of this round^1: ^7" + time);
}

monitorallplayers(paal)
{
	playersleft = true;
	gamewon = undefined;
	
	while(playersleft)
	{
		player = checkPalen(paal);
		
		if(player == 1 && !isDefined(gamewon))
		{
			last = getLastPlayer(paal);

			if(isPlayer(last))
			{
				last iprintlnbold(last.name + "^7 won^1!");
				iprintln(last.name + "^7 won a sweeper round^1!");
				last.score += 3;
			}
			
			gamewon = true;
		}


		if(player == 0)
			playersleft = false;
		if(player != 0)
			wait (2);
	}

	level notify("end_sweeper");

}

getLastPlayer(paal)
{
	for(i=0;i<paal.size;i++)
	{
		if(isDefined(level.paal[i]) && isPlayer(level.paal[i]))
			return level.paal[i];
	}

	return undefined;
}

checkPalen(paal)
{
	players = getentarray("player", "classname");

	level.paal = [];
	count = 0;

	for(i=0;i<players.size;i++)
	{
		_p = players[i];

		for(j=0;j<paal.size;j++)
		{
			if(isPlayer(_p) && _p istouching(paal[j]) && !isDefined(level.paal[j]))
			{	
				level.paal[j] = _p;
				count++;
			}
			else if(isPlayer(_p) && _p istouching(paal[j])  && isDefined(level.paal[j]))
			{
				//_p iprintlnbold(_p.name + "^1: You are player #2^1!");
			}
		}

		wait 0.1;
	}

	return count;
}