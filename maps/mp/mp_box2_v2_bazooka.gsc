main()
{
thread bazooka();
}


bazooka()
{
bazooka=getent("flying_bazooka","targetname");
trig=getent("bazooka_trig","targetname");
while(1)
{
trig waittill ("trigger");
bazooka movey (-320,5,2.5,2.5);
bazooka waittill ("movedone");

bazooka movex (344,5,2.5,2.5);
bazooka waittill ("movedone");

bazooka movey(320,5,2.5,2.5);
bazooka waittill ("movedone");

bazooka movex (-344,5,2.5,2.5);
bazooka waittill ("movedone");
}
}