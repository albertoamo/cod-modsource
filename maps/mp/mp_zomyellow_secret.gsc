main()
{
	thread ysecret();
}

ysecret()
{
	ysecret=getent("topsecret","targetname");

	volume = [];
	volume[0] = -1899; // min (x)
	volume[1] = -884;  // min (y)
	volume[2] = 512;   // min (z)
	volume[3] = -1875; // max (x)
	volume[4] = -843;  // max (y)
	volume[5] = 610;   // max (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "use");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player MeleeButtonPressed())
		{
			wait(1);

			if(!player UseButtonPressed())
			{
				ysecret movez (2000,0.7,0.19,0.19);
				ysecret waittill ("movedone");

				ysecret movey (-300, 0.05);
				ysecret waittill("movedone");

				ysecret movez (-2000,0.05);
				ysecret waittill ("movedone");

				wait(1);

				trigger waittill("trigger", player);

				ysecret movey (300, 0.1,0.019,0.05);
				ysecret waittill("movedone");
			}
		}
	}
}