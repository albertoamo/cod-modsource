main()
{
maps\mp\_load::main();

game["allies"] = "american";
game["axis"] = "german";
game["american_soldiertype"] = "normandy"; 
game["german_soldiertype"] = "normandy"; 

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");

thread Teleport();
//thread Teleport2(); // -------
		      // _ I I I
//thread Teleport3(); // not needed
thread forward1(2200);

}

forward1(dmg)
{
	volume = [];
	volume[0] = -199; // min (x)
	volume[1] = -1364; // min (y)
	volume[2] = 16; // min  (z)
	volume[3] = -100; // max  (x)
	volume[4] = -1274; // max  (y)
	volume[5] = 50; // max  (z)

	if(!isDefined(dmg))
		dmg = 2200;

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player.health += dmg;
		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(player GetPlayerAngles()), 1000), "none", 0 );

		wait(0.05);
	}
}

Teleport()
{
	volume = [];
	volume[0] = 120; // min (x)
	volume[1] = -656; // min (y)
	volume[2] = 88; // min  (z)
	volume[3] = 100; // max  (x) -176 -656 88
	volume[4] = -666; // max  (y)
	volume[5] = 200; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "use");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin((-43,668,96));
		wait(0.05);
	}
}

Teleport2()
{
	volume = [];
	volume[0] = -156; // min (x)
	volume[1] = -656; // min (y)
	volume[2] = 88; // min  (z)
	volume[3] = -190; // max  (x)
	volume[4] = -666; // max  (y)
	volume[5] = 200; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "use");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin((239,291,80));
		wait(0.05);
	}
}

Teleport3()
{
	volume = [];
	volume[0] = -60; // min (x)
	volume[1] = -530; // min (y)
	volume[2] = -300; // min  (z)
	volume[3] = -12; // max  (x)
	volume[4] = -470; // max  (y)
	volume[5] = -130; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "use");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player setOrigin((-31,-860,-231));
		wait(0.05);
	}
}