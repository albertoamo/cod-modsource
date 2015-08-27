init()
{
	thread Code();
}

Code()
{
	codes = getentarray("trig_code", "targetname");
	getcode = getent("getcode", "targetname");
	trig = getent("trig_code_reset", "targetname");
	range = getent("code_range", "targetname");

	for(i=0;i<codes.size;i++) codes[i] thread CodeTrigger(getcode, range);

	while(1)
	{
		trig waittill("damage", dmg, player);

		if(!isDefined(level.openingdoor) && player isTouching(range))
		{
			player.doorcode = "";

			player iprintlnbold("The code has been resetted.");

			wait(0.5);
		}
	}
}

CodeTrigger(getcode, range)
{
	while(1)
	{
		self waittill("trigger", player);

		if(!isDefined(player.doorcode))
			player.doorcode = "";

		if(!isDefined(level.openingdoor) && player isTouching(range))
		{
		
			if(player.doorcode.size >= 4)
				player.doorcode = self.script_label;
			else
				player.doorcode += self.script_label;

			player iprintlnbold("Code^1: ^7" + player.doorcode);

			if("5375" == player.doorcode)
			{
				player iprintlnbold("^2Accepted.");
				level.openingdoor = true;
				OpenDoor();
				player.doorcode = "";
				level.openingdoor = undefined;
			}
			else if(player.doorcode.size >= 4)
			{
				player iprintlnbold("^1Denied.");
				wait(0.05);
				player iprintlnbold("Join the Xfire Community (^1znationcomunnity^7) for the code^1!");
				wait(0.5);
			}
		}

		wait(0.5);
	}
}

OpenDoor()
{
	door = getent("code_door", "targetname");

	door moveZ(168, 2);
	door waittill("movedone");

	wait(0.5);

	door moveZ(-168, 1.5);
	door waittill("movedone");	
}