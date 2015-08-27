//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread axafador ();
}

axafador()
{
axafador=getent("axafar","targetname");
trig=getent("trig_axafar","targetname");
while(1)
{
trig waittill ("trigger");
axafador movey (350,4,0.5,0.5);
axafador waittill ("movedone");
//trig waittill ("trigger");
axafador movey(-350,4,0.5,0.5);
axafador waittill ("movedone");

}
}