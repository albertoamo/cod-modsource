main()
{
	maps\mp\_load::main();
        maps\mp\mp_alienscape_v1_elevator::main();
        maps\mp\mp_alienscape_v1_fx::main();
        
        maps\mp\mp_alienscape_v1_jumpers::main();

	setExpFog(0.00008, .58, .57, .57, 0);
	ambientPlay("ambient_mp_alienscape_v1");

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["russian_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";
}