main()
{
thread lift();
}

lift()
{
lift=getent("lift9","targetname");
while(1)
{
wait (4);
lift movez (256,5,1,1);
lift waittill ("movedone");
wait (4);
lift movez(-256,5,1,1);
lift waittill ("movedone");
}
}
