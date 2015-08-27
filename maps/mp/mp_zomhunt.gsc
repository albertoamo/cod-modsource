main()
{
	maps\mp\_load::main();
	maps\mp\mp_zomhunt_tele::main();
	maps\mp\mp_zomhunt_move::main();
	maps\mp\mp_zomhunt_text::main();
	thread fix();
}

fix()
{
	volume = [];
	volume[0] = -3410; // min (x)
	volume[1] = -557; // min (y)
	volume[2] = -1023; // min  (z)
	volume[3] = 817; // max  (x)
	volume[4] = 3225; // max  (y)
	volume[5] = -727; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
	trigger.dmg = 100000;
}
