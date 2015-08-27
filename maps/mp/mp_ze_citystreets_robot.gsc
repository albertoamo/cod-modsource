main()
{

thread pwfence();
thread door1_rotate();
thread gates();
}

pwfence()
{
    wall = getentarray("gates","targetname");
    trig = getent("trig_pwfence","targetname");
          while(1)

                 {
                 trig waittill("trigger", user);

if ((user.name == "LilPimpOwnz") || (user.name == "HyperOwnz"))
{
for(i=0;i<wall.size;i++)
	wall[i] notsolid();
user iprintlnbold (user.name + " is Correct");
user iprintlnbold ("The gates will vanish now");
}
else
{
for(i=0;i<wall.size;i++)
	wall[i] solid();
user iprintlnbold (user.name + " ^7is Invalid");
user iprintlnbold ("Invalid Password");
}
}
}

door1_rotate()
{
door1 = getent("robotdoor", "targetname");
trig = getent("robotdoor_trigger", "targetname");
while (1)
{
trig waittill("trigger");
door1 rotateYaw(90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
wait (5);
door1 rotateYaw(-90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
}
}

gates()
{
trig1 = getent( "gatestrigger", "targetname" );
while (1)
{
trig1 waittill( "trigger", player );
wait (1);
{			
player iprintlnbold ( "Hmmm...The door seems to be broken" );
player iprintlnbold ( "Try to go through the tunnels" );
player iprintlnbold ( "or" );
player iprintlnbold ( "Jump over the gates into the castle" );
}	
}
}

