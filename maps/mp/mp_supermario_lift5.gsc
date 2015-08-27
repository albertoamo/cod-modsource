main()
{
thread lift5();
}

lift5()
{
lift=getent("lift5","targetname");
while(1)
{
wait (4);
lift movez (200,5,2,2);
lift waittill ("movedone");
wait (4);
lift movez(-200,5,2,2);
lift waittill ("movedone");
}
}
