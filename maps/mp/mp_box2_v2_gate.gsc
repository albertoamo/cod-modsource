main() {

thread gate();
}

gate() 
{
liftpad=getent("gate","targetname");
trig1=getent("gate_trig1","targetname");
trig2=getent("gate_trig2","targetname");
trig3=getent("gate_trig3","targetname");
trig4=getent("gate_trig4","targetname");

while(1)
{
trig1 waittill ("trigger", user);
if(isDefined(user) && isPlayer(user))
{
	if(isDefined(user.debugmode))
	{
		user iprintln("Debug Mode: trig1 - gate");
	}
}
trig2 waittill ("trigger", user);
if(isDefined(user) && isPlayer(user))
{
	if(isDefined(user.debugmode))
	{
		user iprintln("Debug Mode: trig2 - gate");
	}
}
trig3 waittill ("trigger", user);
if(isDefined(user) && isPlayer(user))
{
	if(isDefined(user.debugmode))
	{
		user iprintln("Debug Mode: trig3 - gate");
	}
}
trig4 waittill ("trigger", user);
if(isDefined(user) && isPlayer(user))
{
	if(isDefined(user.debugmode))
	{
		user iprintln("Debug Mode: trig4 - gate");
	}
}
liftpad movez (193,1,0.75,0.25);
iprintlnbold ("^2Gate is open, you have 40 seconds.");
liftpad waittill ("movedone");
wait (40);
if(isDefined(user) && isPlayer(user))
{
	if(isDefined(user.debugmode))
	{
		user iprintln("Debug Mode: Gate Closing");
	}
}
liftpad movez (-193,1,0.75,0.25);
liftpad waittill ("movedone");
if(isDefined(user) && isPlayer(user))
{
	if(isDefined(user.debugmode))
	{
		user iprintln("Debug Mode: Gate Closed");
	}
}
wait (200);
}
}