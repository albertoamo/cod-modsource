main()
{
thread LOL();
}

LOL()
{
LOL=getent("lol","targetname");
trig=getent("trig_lol","targetname");
while(1)
{
trig waittill ("trigger");
LOL movez (-840,7,1.9,1.9);
LOL waittill ("movedone");
wait(5);
trig waittill ("trigger");
LOL movez (840,7,1.9,5);
LOL waittill ("movedone");
} 
}