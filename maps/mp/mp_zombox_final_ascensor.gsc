main()
{
thread elevator();
}

elevator()
{
elevator=getent("ascensor","targetname");
trig=getent("ascensor2","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (-250,7,1.9,1.9);
elevator waittill ("movedone");
wait(1);
elevator movez (250,7,1.9,5);
elevator waittill ("movedone");
} 
}