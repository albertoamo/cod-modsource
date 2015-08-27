///////////////////////////////////////////////
///////Don't delete this script!//////////////
//////Don't change the names in this script//
/////////////Thank you and have fun/////////
////////////Stick & Fristi/////////////////

main()
{
	thread initPlayers();
}


initPlayers()
{
	level endon("intermission");

	for(;;)
	{
		level waittill("connecting", player); // notify wordt gegeven als je aan het connecten bent
		player thread waitForSpawn();
	}

}
waitForSpawn()
{
	self endon("disconnect");

	self waittill("spawned_player"); // notify wordt gegeven als je spawned
	self iprintlnbold("^3[^7This map is made by ^7St^4i^7ck ^9(xfire = fushion123) ^7& ^7FRISTI ^9(xfire = laurensdev)^3]");
}