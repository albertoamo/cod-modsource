main()
{
	//thread lift();
}

lift()
{
lift=getent("lift10","targetname");
while(1)
{
wait (4);
lift movex (384,5,1,1);
lift waittill ("movedone");
wait (4);
lift movex(-384,5,1,1);
lift waittill ("movedone");
}
}
