main()
{
maps\mp\_load::main();
maps\mp\mp_zn_hideout_bars::main();
maps\mp\mp_zn_hideout_wep::main();
maps\mp\mp_zn_hideout_lazer::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_france");

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");

thread secret();
thread secret2();
thread ladderTower(35);
}

ladderTower(dmg)
{
	precacheModel("xmodel/prop_ladder_wood_14_ft_static");

	model = Spawn( "script_model", (533, 187, -207));
	model setModel("xmodel/prop_ladder_wood_14_ft_static");

	volume = [];
	volume[0] = 529; // min (x)
	volume[1] = 174; // min (y)
	volume[2] = -170; // min  (z)
	volume[3] = 553; // max  (x)
	volume[4] = 200; // max  (y)
	volume[5] = -60; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "axis")
		{	
			player.health += dmg;
			angles = VectorToAngles( (player.origin[0], player.origin[1], 450) - player.origin );
			player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, AnglesToForward(angles), "none", 0 );

			if(int(player.origin[2]) >= -110)
				player setOrigin((624, 368, 140));
		}

		wait(0.05);	
	}
}

secret()
{
	trig = getent("trig_secret", "targetname");
	one = getent("secretdoor1", "targetname");
	two = getent("secretdoor2", "targetname");

	while(1)
	{
		trig waittill("trigger", player);
		
		if(player UseButtonPressed())
		{
			one thread MoveDoors(-90);
			two thread MoveDoors(90);

			wait(1);
			
			while(isDefined(one.ismoving) || isDefined(two.ismoving))
				wait(0.05);
		}

		wait(0.05);
	}
}

secret2()
{
	trig = getent("trig_secret2", "targetname");
	door = getent("door_secret2", "targetname");

	while(1)
	{
		trig waittill("trigger", player);
		
		if(player UseButtonPressed())
		{
			door MoveX(-76, 2);
			door waittill("movedone");

			wait(3);
			
			door MoveX(76, 2);
			door waittill("movedone");
		}

		wait(0.05);
	}
}

MoveDoors(dir)
{
	self.ismoving = true;
	self RotateYaw(dir, 2);
	self waittill("rotatedone");
	wait(6);
	self RotateYaw(dir*-1, 2);
	self waittill("rotatedone");
	self.ismoving = undefined;
}