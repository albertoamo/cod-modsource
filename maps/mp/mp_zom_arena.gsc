main()
{
	
        // @Y, this is a very basic .gsc for a map,
        //     you can change the player types here below   	
        //     There is a list of player types on modsonline
        //     As you can see two // make a line into a remark
        //     So if you want to hear background noise
        //     remove the two // from //ambientplay
 

	// lets play some background sounds
	//ambientPlay("ambient_mp_brecourt");

	
	
	maps\mp\_load::main();
        maps\mp\mp_zom_arena_teleportenter::main();   //this calls up the teleportenter.gsc
	
        
        

		
	game["allies"] = "british";
	game["axis"] = "german";

	game["british_soldiertype"] = "commando";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
        
        
	

}