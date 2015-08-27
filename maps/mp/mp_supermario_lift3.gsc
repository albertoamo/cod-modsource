main()
{
thread lift3();
}

lift3()
{
lift=getent("lift3","targetname");
while(1)
{
wait (4);
lift movez (176,5,2,2);
lift waittill ("movedone");
wait (4);
lift movez(-176,5,2,2);
lift waittill ("movedone");
}
}
