main()
{
thread lift();
}

lift()
{
lift=getent("mario_wolk3","targetname");
while(1)
{
wait (4);
lift movey (56,7,2,2);
lift waittill ("movedone");
wait (4);
lift movey(-56,7,2,2);
lift waittill ("movedone");
}
}
