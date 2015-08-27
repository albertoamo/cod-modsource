main()
{
thread dip1();
thread dip2();
thread dip3();
thread dip4();
thread dip5();
thread dot();
}

dip1()
{
elevator = getent("dip1","targetname");
trig = getent ("dip1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator movey (-55,5,2,2);
elevator waittill ("movedone");
trig waittill ("trigger");
elevator movey (55,5,2,2);
elevator waittill ("movedone");
} 
} 

dip2()
{
elevator = getent("dip2","targetname");
trig = getent ("dip2trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator movey (-55,5,2,2);
elevator waittill ("movedone");
trig waittill ("trigger");
elevator movey (55,5,2,2);
elevator waittill ("movedone");
} 
} 

dip3()
{
elevator = getent("dip3","targetname");
trig = getent ("dip3trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator movey (-55,5,2,2);
elevator waittill ("movedone");
trig waittill ("trigger");
elevator movey (55,5,2,2);
elevator waittill ("movedone");
} 
} 

dip4()
{
elevator = getent("dip4","targetname");
trig = getent ("dip4trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator movey (-55,5,2,2);
elevator waittill ("movedone");
trig waittill ("trigger");
elevator movey (55,5,2,2);
elevator waittill ("movedone");
} 
} 

dip5()
{
elevator = getent("dip5","targetname");
trig = getent ("dip5trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator movex (-55,5,2,2);
elevator waittill ("movedone");
trig waittill ("trigger");
elevator movex (55,5,2,2);
elevator waittill ("movedone");
} 
} 

dot()
{
elevator = getent("dot","targetname");
trig = getent ("dottrigger", "targetname");
while(1)
{
elevator movey (500,5,2,2);
elevator waittill ("movedone");
trig waittill ("trigger");
elevator movey (-500,5,2,2);
elevator waittill ("movedone");
wait 15;
} 
} 