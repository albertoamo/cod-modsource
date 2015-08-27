main()
{
thread elevator123();
}
elevator123()
{
elevator123 = getent("trap","targetname");
trig = getent ("traptrigger", "targetname"); 
while(1)
{
trig waittill ("trigger");
elevator123 movez (-40,3,1,1);
elevator123 waittill ("movedone");
wait(2);
elevator123 movez (40,3,1,1);
elevator123 waittill ("movedone");
wait(7);
} 
} 

