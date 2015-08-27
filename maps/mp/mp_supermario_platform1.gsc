main()
{
thread lift();
}

lift()
{
lift=getent("platform1","targetname");
while(1)
{
wait (4);
lift movez (32,4,1,1);
lift waittill ("movedone");
wait (4);
lift movez(-32,4,1,1);
lift waittill ("movedone");
}
}
