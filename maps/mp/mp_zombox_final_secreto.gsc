main()
{
thread secreto ();
}

secreto()
{
secreto=getent("secreto","targetname");
trig=getent("trig_secreto","targetname");
while(1)
{
trig waittill ("trigger");
secreto movez (300,2,0.5,0.5);
secreto waittill ("movedone");
//trig waittill ("trigger");
secreto movez (-300,2,0.5,0.5);
secreto waittill ("movedone");

}
}