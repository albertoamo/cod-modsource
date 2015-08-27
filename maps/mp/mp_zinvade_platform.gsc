main()
{
maps\mp\_load::main();

thread elevator();
}

elevator()
{
elevator=getent("elevator","targetname");
trig=getent("trig_elevator","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (685,7,1.9,1.9);
elevator waittill ("movedone");
wait(4);
elevator movez (-685,7,1.9,5);
elevator waittill ("movedone");
} 
} 