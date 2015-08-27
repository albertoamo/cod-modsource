main()
{
thread lift();
}

lift()
{
lift=getent("mario_facelift1","targetname");
while(1)
{
wait (4);
lift movey (512,8,1,1);
lift waittill ("movedone");
wait (4);
lift movey(-512,8,1,1);
lift waittill ("movedone");
}
}
