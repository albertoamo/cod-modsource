main()
{
thread liftpad1_slider ();
}

liftpad1_slider()
{
liftpad1=getent("liftpad1","targetname");
trig=getent("lift1_trigger","targetname");
while(1)
{
trig waittill ("trigger");
wait (4);
liftpad1 movez (4695,8,0,0.6);
liftpad1 playsound ("elevator");
liftpad1 waittill ("movedone");
wait (4);
//trig waittill ("trigger");
liftpad1 movez(-4695,8,0,0.6);
liftpad1 playsound ("elevator");
liftpad1 waittill ("movedone");

}
}