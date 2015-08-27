main()
{
thread yelevator2();
}

yelevator2()
{
yelevator2=getent("elevator2","targetname");
while(1)
{
yelevator2 movex (248,7,1.9,1.9);
yelevator2 waittill ("movedone");
wait(5);
yelevator2 movex (-248,7,1.9,5);
yelevator2 waittill ("movedone");
wait(10);
}
}