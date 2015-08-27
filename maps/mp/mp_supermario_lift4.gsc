main()
{
thread lift4();
}

lift4()
{
lift=getent("lift4","targetname");
while(1)
{
wait (4);
lift movez (344,5,2,2);
lift waittill ("movedone");
wait (4);
lift movez(-344,5,2,2);
lift waittill ("movedone");
}
}
