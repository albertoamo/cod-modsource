main()
{
thread lift();
}

lift()
{
lift=getent("platform2","targetname");
while(1)
{
wait (4);
lift movez (6,5,1,1);
lift waittill ("movedone");
wait (4);
lift movez(-6,5,1,1);
lift waittill ("movedone");
}
}
