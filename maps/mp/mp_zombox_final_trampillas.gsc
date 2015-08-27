//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
thread door1_open();	
thread door2_open();
}
door1_open()
{
door1 = getent("door1", "targetname");	
trig = getent("door_trigger", "targetname");
while (1)
{
trig waittill("trigger");
door1 rotateto( (0,0,-90),2);
door1 waittill("rotatedone");
wait (4);
door1 rotateto( (0,0,0),2);
door1 waittill("rotatedone");
}}
door2_open()
{
door2 = getent("door2", "targetname");	
trig = getent("door_trigger", "targetname");
while (1)
{
trig waittill("trigger");
door2 rotateto( (0,0,90),2);
door2 waittill("rotatedone");
wait (4);
door2 rotateto( (0,0,0),2);
door2 waittill("rotatedone");
}}