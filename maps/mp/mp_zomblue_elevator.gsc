main()
{
thread elevator();
}

elevator()
{
elevator=getent("elevator","targetname");
while(1)
{
elevator movey (1960,7,1.9,1.9);
elevator waittill ("movedone");
wait(10);
elevator movey (-1960,7,1.9,5);
elevator waittill ("movedone");
wait(10);
}
}