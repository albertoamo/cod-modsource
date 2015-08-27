//------------------------------------------------------------------------------
//
// Damage control for Cod/Uo/Cod2 Multi Player
// by <|WHC|>Grassy
// Version 2
// Updated December 27, 2006
//
//
// Usefull for controlling players who like to block
// doorways or other scripted events.
//
// Place trigger_multiples in these areas, as many as you need
// Give them all a KEY: targetname with a VALUE: dmg
//
// To set a delay use a KEY: script_delay and VALUE: XX
// where XX is any whole number you want as your delay before the player
// begins to take damage.
// Default delay if not set on the trigger is 5 seconds.
//
// This new version can now handle different Damage levels for each trigger.
// To set a damage level set a KEY: script_dmg and VALUE: XX
// where XX is any whole number for the level of damage inflicted
// on the player while in the trigger after the delay has been reached.
// Default damage level if not set is 10.
//
// This has been tested in Cod1 and UO but not Cod2
// If you find this script fails in Cod2 then it's more than
// likely the sound command line is the problem, to fix this
// change the sound alias to some other generic "tick" type of
// sound that Cod2 loads by default.
//
// I don't have Cod2 anyore so if someone wants to make this
// compatable then feel free to go ahead with it.
//
//
// To load, usual procedure. Place this script in maps/mp/ and call it damage_control.gsc
// Then add this line to your maps .gsc file.
// maps\mp\damage_control::main();
//
// I hope you find this little utility usefull, if you have problems you
// can get me on Xfire with username of grassy or drop into
// my clan website www.whcclan.com and leave me a msg there.
//
// Regards Grassy
//
//----------------------------------------------------------------------------------


main()
{
//collect delayed hurt triggers
ent = getentarray("dmg","targetname");

if(isdefined(ent))
{
for(d = 0 ; d < ent.size ; d ++)
{

//If a delay is defined use that - otherwise set it to 5
if(isdefined(ent[d].script_delay))
{
delay = ent[d].script_delay;
}
else
{
delay = 4;
}

//If damage level is defined use that - otherwise set it to 10
if(isdefined(ent[d].script_dmg))
{
dmg = ent[d].script_dmg;
}
else
{
dmg = 5;
}

ent[d] thread damage_handler(delay,dmg);
}
}
}

//-----------------------end of main-----------------------


damage_handler(delay,dmg)
{
for(;;)
{
counter = 0;
self waittill("trigger",other);


// loop until done killing player or dump out if:
// 1: Not touching the trigger anymore
// 2: not alive
// 3: You are a spectator

while(other istouching(self)
&& isAlive(other)
&& other.sessionstate != "spectator")
{
wait 1;
counter++;


if(counter >= delay)
{
	if(isDefined(other))
	{
		//dmg = 10;
		other.health -= dmg;

		if(other.health == 50)
			other iprintlnbold("^3Move or you will die!");

		other viewkick(96, other.origin);
		other shellshock("default_mp", 1);

		if(other.health <= 0)
		{
			other suicide();
			iprintln ("^1SERVER MESSAGE: ^7" + other.name + " ^1was punished for blocking.");
			other.sessionstate = "dead";
		}
	}
}
}
wait(1);
}
}