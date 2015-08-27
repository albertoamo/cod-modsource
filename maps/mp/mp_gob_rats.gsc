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
        maps\mp\mp_gob_rats_teleportenter::main();   //this calls up the teleportenter.gsc
	
        
        

		
	game["allies"] = "american";
	game["axis"] = "german";

	game["american_soldiertype"] = "normandy";
	game["american_soldiervariation"] = "normal";
	game["german_soldiertype"] = "normandy";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
        
        
	

}