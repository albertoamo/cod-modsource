main()
{
thread yelevator1();
}

yelevator1()
{
yelevator1=getent("elevator1","targetname");
while(1)
{
yelevator1 movez (-152,7,1.9,1.9);
yelevator1 waittill ("movedone");
wait(7);
yelevator1 movez (152,7,1.9,5);
yelevator1 waittill ("movedone");
wait(7);
}
}