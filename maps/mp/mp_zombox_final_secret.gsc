//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
players_obj = getentarray("players1","targetname");
players = getentarray( "player", "classname" );
if(isdefined(players))
{
 	for ( i = 0; i < players.size; i++ )
 	{

   level.player = players[i];


iprintln ("^1Winner of the last round was^7 " + level.player.name );
					level.player iprintlnbold("^3You get 5 bonus points as winner");
					bonus = 5;
					level.player.score = level.player.score + bonus;
	}
}
}
