main()
{
maps\mp\_load::main();

thread elevator();
}

elevator()
{
elevator=getent("elevator1","targetname");
trig=getent("trig_elevator1","targetname");
while(1)
{
trig waittill ("trigger");
elevator movex (600,7,1.9,1.9);
elevator waittill ("movedone");
wait(4);
elevator movex (-600,7,1.9,5);
elevator waittill ("movedone");
} 
} 