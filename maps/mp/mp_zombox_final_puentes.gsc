//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread puente1();	
thread puente2();
}
puente1()
{
puente1 = getent("puente1", "targetname");	
trig = getent("trig_puentes", "targetname");
while (1)
{
trig waittill("trigger");
puente1 rotateto( (0,0,-90),2);
puente1 waittill("rotatedone");
wait (4);
puente1 rotateto( (0,0,0),2);
puente1 waittill("rotatedone");
}}
puente2()
{
puente2 = getent("puente2", "targetname");	
trig = getent("trig_puentes", "targetname");
while (1)
{
trig waittill("trigger");
puente2 rotateto( (0,0,90),2);
puente2 waittill("rotatedone");
wait (4);
puente2 rotateto( (0,0,0),2);
puente2 waittill("rotatedone");
}}