//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread help1 ();
}

help1()
{
help1=getent("help1","targetname");
trig=getent("trig_ayudante","targetname");
//while(1)
//{
//trig waittill ("trigger");
help1 movey (-60,2,0.5,0.5);
help1 waittill ("movedone");
trig delete();
//}
}