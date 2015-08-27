main()
{
thread yplatform();
}

yplatform()
{
yplatform=getent("platform","targetname");
while(1)
{
yplatform movey (-232,4,0.9,0.9);
yplatform waittill ("movedone");
yplatform movex (-2104,4,0.9,0.9);
yplatform waittill ("movedone");
yplatform movez (192,4,0.9,0.9);
yplatform waittill ("movedone");
wait(14);
yplatform movez (-192,4,0.9,0.9);
yplatform waittill ("movedone");
yplatform movex (2104,4,0.9,0.9);
yplatform waittill ("movedone");
yplatform movey (232,4,0.9,0.9);
yplatform waittill ("movedone");
wait(7);
}
}