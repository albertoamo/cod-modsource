main()
{
thread lift();
}

lift()
{
lift=getent("mario_facelift2","targetname");
while(1)
{
wait (4);
lift movey (464,8,1,1);
lift waittill ("movedone");
wait (4);
lift movey(-464,8,1,1);
lift waittill ("movedone");
}
}
