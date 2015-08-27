main()
{
thread liftpad3_slider ();
}

liftpad3_slider()
{
liftpad3=getent("liftpad3","targetname");
trig=getent("lift3_trigger","targetname");
while(1)
{
trig waittill ("trigger");
wait (4);
liftpad3 movez (4695,8,0,0.6);
liftpad3 playsound ("elevator");
liftpad3 waittill ("movedone");
wait (4);
//trig waittill ("trigger");
liftpad3 movez(-4695,8,0,0.6);
liftpad3 playsound ("elevator");
liftpad3 waittill ("movedone");

}
}