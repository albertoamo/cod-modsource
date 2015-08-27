main()
{
thread lift();
}

lift()
{
lift=getent("wwlift2","targetname");
while(1)
{
wait (4);
lift movez (160,7,2,2);
lift waittill ("movedone");
wait (4);
lift movez(-160,7,2,2);
lift waittill ("movedone");
}
}
