main()
{
thread val();
thread val2();
thread brug();
}

val()
{
elevator = getent("val","targetname");
trig = getent ("valtrigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator movex (160,2,0.5,0.5);
elevator waittill ("movedone");
wait 20;
elevator movex (-160,2,0.5,0.5);
elevator waittill ("movedone");
} 
} 

val2()
{
elevator = getent("val2","targetname");
trig = getent ("val2trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator movex (-160,2,0.5,0.5);
elevator waittill ("movedone");
wait 20;
elevator movex (160,2,0.5,0.5);
elevator waittill ("movedone");
} 
} 

brug()
{
elevator = getent("brug","targetname");
trig = getent ("brugtrigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator movey (-68,3,1,1);
elevator waittill ("movedone");
wait 20;
elevator movey (68,3,1,1);
elevator waittill ("movedone");
} 
} 