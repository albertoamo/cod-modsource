main()
{
thread lift2();
}

lift2()
{
lift=getent("lift2","targetname");
while(1)
{
wait (4);
lift movez (272,5,2,2);
lift waittill ("movedone");
wait (4);
lift movez(-272,5,2,2);
lift waittill ("movedone");
}
}
