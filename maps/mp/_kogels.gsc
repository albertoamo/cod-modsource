main()
{
thread elevator7();
thread elevator8();
thread elevator9();
thread elevator10();
thread elevator11();
thread elevator12();
thread kog1();
thread kog2();
thread kog3();
thread kog4();
}

kog1()
{
elevator = getent("kog1","targetname");
while(1)
{
elevator movex (50000,20,2,2);
elevator waittill ("movedone");
elevator movex (-60000,24,2,2);
elevator waittill ("movedone");
elevator movex (10000,4,2,2);
elevator waittill ("movedone");
} 
} 
kog4()
{
elevator = getent("kog4","targetname");
while(1)
{
elevator movex (-50000,30,2,2);
elevator waittill ("movedone");
elevator movex (60000,36,2,2);
elevator waittill ("movedone");
elevator movex (-10000,6,2,2);
elevator waittill ("movedone");
} 
} 

kog2()
{
elevator = getent("kog2","targetname");
while(1)
{
elevator movex (-50000,25,2,2);
elevator waittill ("movedone");
elevator movex (60000,30,2,2);
elevator waittill ("movedone");
elevator movex (-10000,5,2,2);
elevator waittill ("movedone");
} 
} 
kog3()
{
elevator = getent("kog3","targetname");
while(1)
{
elevator movex (-50000,20,2,2);
elevator waittill ("movedone");
elevator movex (60000,24,2,2);
elevator waittill ("movedone");
elevator movex (-10000,4,2,2);
elevator waittill ("movedone");
} 
} 
elevator7()
{
elevator7 = getent("kogel1","targetname");
trig = getent ("kogel1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator7 movey (8000,10,3,2);
elevator7 waittill ("movedone");
wait(1);
elevator7 movey (-8000,1,0.4,0.4);
elevator7 waittill ("movedone");
wait(1);
} 
} 

elevator8()
{
elevator8 = getent("kogel2","targetname");
trig = getent ("kogel2trigger", "targetname");
while(1)
{
trig waittill ("trigger");
elevator8 movey (8000,10,3,2);
elevator8 waittill ("movedone");
wait(1);
elevator8 movey (-8000,1,0.4,0.4);
elevator8 waittill ("movedone");
wait(1);
} 
} 

elevator11()
{
elevator11 = getent("kogel3","targetname");
trig = getent ("kogel2trigger", "targetname");
while(1)
{
trig waittill ("trigger");
wait(1);
elevator11 movey (8000,10,3,2);
elevator11 waittill ("movedone");
wait(1);
elevator11 movey (-8000,1,0.4,0.4);
elevator11 waittill ("movedone");
wait(1);
} 
} 

elevator12()
{
elevator12 = getent("kogel4","targetname");
trig = getent ("kogel1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
wait(1);
elevator12 movey (8000,10,3,2);
elevator12 waittill ("movedone");
wait(1);
elevator12 movey (-8000,1,0.4,0.4);
elevator12 waittill ("movedone");
wait(1);
} 
} 

elevator9()
{
elevator9 = getent("kogel5","targetname");
trig = getent ("kogel2trigger", "targetname");
while(1)
{
trig waittill ("trigger");
wait(2);
elevator9 movey (8000,10,3,2);
elevator9 waittill ("movedone");
wait(1);
elevator9 movey (-8000,1,0.4,0.4);
elevator9 waittill ("movedone");
wait(1);
} 
} 

elevator10()
{
elevator10 = getent("kogel6","targetname");
trig = getent ("kogel1trigger", "targetname");
while(1)
{
trig waittill ("trigger");
wait(2);
elevator10 movey (8000,10,3,2);
elevator10 waittill ("movedone");
wait(1);
elevator10 movey (-8000,1,0.4,0.4);
elevator10 waittill ("movedone");
wait(1);
} 
} 