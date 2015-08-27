main()
{
thread lift();
}

lift()
{
lift=getent("plateau1","targetname");
while(1)
{
wait (4);
lift movez (14,7,2,4);
lift waittill ("movedone");
wait (4);
lift movez(-14,7,2,4);
lift waittill ("movedone");
}
}
