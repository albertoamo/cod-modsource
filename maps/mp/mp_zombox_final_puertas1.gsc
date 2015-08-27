//Scripted By PwN3R
//Xfire:punishman1993
main()
{
thread slidedoor_slider3 ();
thread slidedoor_slider4 ();

}

slidedoor_slider3()
{
slidedoor=getent("puerta3","targetname");
trig=getent("puertas2","targetname");
while(1)
{
trig waittill ("trigger");
slidedoor movex (-60,2,0.5,0.5);
slidedoor waittill ("movedone");
wait (4);
//trig waittill ("trigger");
slidedoor movex(60,2,0.5,0.5);
slidedoor waittill ("movedone");
}
}
slidedoor_slider4()
{
slidedoor=getent("puerta4","targetname");
trig=getent("puertas2","targetname");
while(1)
{
trig waittill ("trigger");
slidedoor movex (60,2,0.5,0.5);
slidedoor waittill ("movedone");
wait (4);
//trig waittill ("trigger");
slidedoor movex(-60,2,0.5,0.5);
slidedoor waittill ("movedone");
}
}