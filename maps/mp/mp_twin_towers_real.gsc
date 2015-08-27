main()
{
	maps\mp\_load::main();
	maps\mp\mp_twin_towers_real_liftpad4::main();
	maps\mp\mp_twin_towers_real_liftpad3::main();
	maps\mp\mp_twin_towers_real_liftpad::main();
	maps\mp\mp_twin_towers_real_liftpad1::main();
	maps\mp\mp_twin_towers_real_teleportenter::main();

	game["allies"] = "british";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "Winterlight";
	game["german_soldiertype"] = "Winterlight";

	setCvar("r_glowbloomintensity0", ".25");
	setCvar("r_glowbloomintensity1", ".25");
	setcvar("r_glowskybleedintensity0",".3");
}