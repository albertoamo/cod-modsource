CodeCallback_StartGameType()
{
	if(!isDefined(level.gametypestarted) || !level.gametypestarted)
	{
		//thread maps\mp\gametypes\_wallfire::main();
		[[level.callbackStartGameType]]();
            	level maps\mp\gametypes\_admin::init();
            	level maps\mp\gametypes\_commanders::Commander();
		level.gametypestarted = true; 
	}
}

CodeCallback_PlayerConnect()
{
	self endon("disconnect");
	[[level.callbackPlayerConnect]]();
}

/*================
Called when a player drops from the server.
Will not be called between levels.
self is the player that is disconnecting.
================*/
CodeCallback_PlayerDisconnect()
{
	self notify("disconnect");
	[[level.callbackPlayerDisconnect]]();
}

/*================
Called when a player has taken damage.
self is the player that took damage.
================*/
CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset)
{
	self endon("disconnect");
	[[level.callbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}


/*================
Called when a player has been killed.
self is the player that was killed.
================*/
CodeCallback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration)
{
	self endon("disconnect");
	[[level.callbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}

//=============================================================================

/*================
Setup any misc callbacks stuff like defines and default callbacks
================*/
SetupCallbacks()
{
	SetDefaultCallbacks();
	
	// Set defined for damage flags used in the playerDamage callback
	level.iDFLAGS_RADIUS			= 1;
	level.iDFLAGS_NO_ARMOR			= 2;
	level.iDFLAGS_NO_KNOCKBACK		= 4;
	level.iDFLAGS_NO_TEAM_PROTECTION	= 8;
	level.iDFLAGS_NO_PROTECTION		= 16;
	level.iDFLAGS_PASSTHRU			= 32;
}

/*================
Called from the gametype script to store off the default callback functions.
This allows the callbacks to be overridden by level script, but not lost.
================*/
SetDefaultCallbacks()
{
	level.default_CallbackStartGameType = level.callbackStartGameType;
	level.default_CallbackPlayerConnect = level.callbackPlayerConnect;
	level.default_CallbackPlayerDisconnect = level.callbackPlayerDisconnect;
	level.default_CallbackPlayerDamage = level.callbackPlayerDamage;
	level.default_CallbackPlayerKilled = level.callbackPlayerKilled;
}

/*================
Called when a gametype is not supported.
================*/
AbortLevel()
{
	println("Aborting level - gametype is not supported");

	level.callbackStartGameType = ::callbackVoid;
	level.callbackPlayerConnect = ::callbackVoid;
	level.callbackPlayerDisconnect = ::callbackVoid;
	level.callbackPlayerDamage = ::callbackVoid;
	level.callbackPlayerKilled = ::callbackVoid;
	
	setcvar ("sv_maprotationcurrent", "gametype zom map mp_toujane");

	exitLevel(false);
}

/*================
================*/
callbackVoid()
{
}
