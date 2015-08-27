main()
{
thread lift();
}

lift()
{
lift=getent("railtrain","targetname");
while(1)
{
wait (4);
lift movey (-888,10,2,2);
lift waittill ("movedone");
wait (4);
lift movey(888,7,2,2);
lift waittill ("movedone");
}
}
