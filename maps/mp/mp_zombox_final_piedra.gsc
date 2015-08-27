//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread piedra ();
}

piedra()
{
piedra=getent("blocker","targetname");
trig=getent("trig_blocker","targetname");
while(1)
{
trig waittill ("trigger");
piedra movez (79,2,0.5,0.5);
piedra waittill ("movedone");
trig delete();
}
}