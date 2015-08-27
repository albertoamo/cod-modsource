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

maps\mp\mp_zinvade_platform::main();
maps\mp\mp_zinvade_teleport::main();
maps\mp\mp_zinvade_platform2::main();
maps\mp\mp_zinvade_teleport2::main();

thread RemoveTurret();
thread hurt1();
thread hurt2();
}

hurt1()
{
	volume = [];
	volume[0] = 71; // min (x)
	volume[1] = 104; // min (y)
	volume[2] = 753; // min  (z)
	volume[3] = 232; // max  (x)
	volume[4] = -104; // max  (y)
	volume[5] = 820; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
	trigger.delay = 0.25;
}

hurt2()
{
	volume = [];
	volume[0] = -232; // min (x)
	volume[1] = 727; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = 422; // max  (x)
	volume[4] = 1000; // max  (y)
	volume[5] = 50; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
	trigger.delay = 0.25;
}

RemoveTurret()
{
	weapon = getentarray("misc_turret", "classname");

	for(i=0;i<weapon.size;i++)
	{
		if(weapon[i].origin == (-1032,-128,224) || weapon[i].origin == (-1032,160,224))
		{
			weapon[i] delete();
		}
	}
}