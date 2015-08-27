main()
{
	maps\mp\_load::main();
	level._effect["gas"] = loadfx ("fx/gas/gas.efx");
	setExpFog(0.0001, 0.55, 0.6, 0.55, 2);
	maps\mp\mp_ze_poison_teleport::main();
	thread gas();
}

gas()
{
	trigger = getent("gas_trigger","targetname");
	die = getent("die", "targetname");

	//pos = (113, 524, -48);
	//pos1 = (-176, 522, -48);
	//pos2 = (-176, 686, -48);
	//pos3 = (111, 689, -48);
	//pos4 = (-31, 606, -48);

	pos = getent("cage", "targetname");
	pos1 = getent("cage1", "targetname");
	pos2 = getent("cage2", "targetname");
	pos3 = getent("cage3", "targetname");

	while(1)
   	{
		trigger waittill("trigger", player);
		die thread gaskill(player);

		playfx (level._effect["gas"], pos.origin);
		playfx (level._effect["gas"], pos1.origin);
		playfx (level._effect["gas"], pos2.origin);
		playfx (level._effect["gas"], pos3.origin);
		//playfx (level._effect["gas"], pos4);

		wait(3);
		die notify("stop_gas");
	}
}

gaskill(player)
{
	self endon("stop_gas");
			
	while(1)
	{
		self waittill("trigger", user);

		attacker = user;
		
		if(user.pers["team"] != player.pers["team"])			
			attacker = player;
			
		user thread [[level.callbackPlayerDamage]](attacker, attacker, 20, 1, "MOD_SUICIDE", "gas_mp", user.origin, (0,0,0), "none",0);

		wait(0.05);
	}
}