main()
{
thread liftpad_slider ();
}

liftpad_slider()
{
liftpad=getent("liftpad","targetname");
trig=getent("lift_trigger","targetname");
while(1)
{
trig waittill ("trigger");
wait (4);
liftpad movez (4695,8,0,0.6);
liftpad playsound ("elevator");
liftpad waittill ("movedone");
wait (4);
//trig waittill ("trigger");
liftpad movez(-4695,8,0,0.6);
liftpad playsound ("elevator");
liftpad waittill ("movedone");

}
}