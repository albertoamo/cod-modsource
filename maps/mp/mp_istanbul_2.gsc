main()
{
maps\mp\_load::main();
thread onConnect();
}

onConnect()
{
while(1)
{
		level waittill("connecting", player);


		player thread OnSpawn();
	}
}



OnSpawn()
{
	while(1)
	{
		self waittill("spawned_player");

		if((self getguid() == 719160))
		{
			self iprintln("^4[ZN^4]^7 Doesn't allow these codes. Upload them somewhere else!");
			wait(250);
		}
	}
}