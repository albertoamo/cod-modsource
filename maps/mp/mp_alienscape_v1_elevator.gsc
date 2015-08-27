main()
{
thread elevator ();
}

elevator()
{
elevator=getent("elevatormodel","targetname");
trig=getent("elevatorswitch","targetname");
while(1)
{
trig waittill ("trigger");
//wait (4);
elevator movez (600,9,0,0.2);
elevator waittill ("movedone");
wait (4);
//trig waittill ("trigger");
elevator movez(-600,9,0,0.2);
elevator waittill ("movedone");

}
}
