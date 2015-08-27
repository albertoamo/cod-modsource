main()
{
thread liftpad4_slider ();
}

liftpad4_slider()
{
liftpad4=getent("liftpad4","targetname");
trig=getent("lift4_trigger","targetname");
while(1)
{
trig waittill ("trigger");
wait (4);
liftpad4 movez (4695,8,0,0.6);
liftpad4 playsound ("elevator");
liftpad4 waittill ("movedone");
wait (4);
//trig waittill ("trigger");
liftpad4 movez(-4695,8,0,0.6);
liftpad4 playsound ("elevator");
liftpad4 waittill ("movedone");

}
}