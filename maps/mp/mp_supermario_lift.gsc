main()
{
thread lift();
}

lift()
{
lift=getent("lift","targetname");
while(1)
{
wait (4);
lift movez (360,7,2,4);
lift waittill ("movedone");
wait (4);
lift movez(-360,7,2,4);
lift waittill ("movedone");
}
}
