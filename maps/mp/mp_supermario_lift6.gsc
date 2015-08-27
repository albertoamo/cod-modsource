main()
{
thread lift();
}

lift()
{
lift=getent("lift6","targetname");
while(1)
{
wait (4);
lift movez (224,4,1,1);
lift waittill ("movedone");
wait (4);
lift movez(-224,4,1,1);
lift waittill ("movedone");
}
}
