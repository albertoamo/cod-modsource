main()
{
thread up();
thread kill();
thread secret();
}

secret()
{
lift=getent("secret","targetname");
//trig=getent("trigger_secret","targetname");
while(1)
{
	wait(5);
	lift movey (1500,0.1,0,0);
	lift waittill ("movedone");
	lift hide();
	wait(5);
	lift show();
	lift movey (-1500,0.1,0,0);
	lift waittill ("movedone");
}
}

up()
{
lift=getent("up","targetname");
trig=getent("trigger_up","targetname");
while(1)
{
trig waittill ("trigger");
wait(2);
lift movez (2120,6,0.5,0.5);
lift waittill ("movedone");
wait(6);
lift movez (-2120,6,0.5,0.5);
lift waittill ("movedone");
}
}

kill()
{
lift=getent("kill","targetname");
trig=getent("trigger_kill","targetname");
while(1)
{
trig waittill ("trigger");
wait(2);
lift movez (744,4,0.5,0.5);
lift waittill ("movedone");
wait(4);
lift movez (-744,4,0.5,0.5);
lift waittill ("movedone");
}
}