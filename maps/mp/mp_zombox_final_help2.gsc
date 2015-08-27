//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread help2 ();
}

help2()
{
help2=getent("help2","targetname");
trig=getent("trig_help2","targetname");
while(1)
{
trig waittill ("trigger");
help2 movey (60,2,0.5,0.5);
help2 waittill ("movedone");
trig delete();
}
}