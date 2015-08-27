	main() 
{
	//How high is your map?
	level.mapheight = 1068;

	//What effect am I going to use for the rain?
	level._effect["rain"] = loadfx ("fx/misc/rain_heavy.efx");
	
	//I don't want to leave lonely rain() alone :)
	level thread rain(); 
} 

//Rain tells us who she is :P
rain()
{
	while(1)
	{
		players = getentarray("player", "classname");
		
		for(i=0; i<players.size; i++)
		{
			//I don't think dead people care about rain... :/
			if (!isAlive(players[i]))
				continue;
			
			//I don't want to make the rain show around the whole map!
			x = 1000 - randomint(1000);
			y = 1000 - randomint(1000);

			//Rain indoors is bad... :(
			above = bulletTrace( players[i].origin + (x, y, 100), (players[i].origin[0] + x, players[i].origin[1] + y, level.mapheight), false, false);
			if (above["fraction"] < .9) continue;
			
			//Please rain
			playfx(level._effect["rain"], above["position"]);
			
			wait .05;
		}
		
		wait .05;
	}
}