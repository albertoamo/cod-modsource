//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
//Mitch: changed the height (prevent blocking)
main()
{
thread zeppelin();
}
zeppelin()
{
zeppelin = getent("zeppelin","targetname");
trig=getent("trig_zeppelin","targetname");
while(1)
{
trig waittill ("trigger");
zeppelin PlaySound("zeppe");
zeppelin movez (280,5,0.5,0.2);
zeppelin waittill ("movedone");
wait(2);
zeppelin PlaySound("zeppe1");
zeppelin movey (-950,5,0.5,0.2);
zeppelin waittill ("movedone");
zeppelin rotateyaw (90,2.5);
zeppelin waittill ("rotatedone");
wait(2);
zeppelin PlaySound("zeppe1");
zeppelin movex (1140,7,0.5,0.2);
zeppelin waittill ("movedone");
zeppelin rotateyaw (90,2.5);
zeppelin waittill ("rotatedone");
wait(2);
zeppelin PlaySound("zeppe1");
zeppelin movey (-300,5,0.5,0.2);
zeppelin waittill ("movedone");
wait(2);
zeppelin movez (-215,5,0.5,0.2);
zeppelin waittill ("movedone");
wait(2);
zeppelin movey (-500,3,0.5,0.2);
zeppelin waittill ("movedone");
wait(10);
zeppelin PlaySound("zeppe1");
zeppelin movey (800,5,0.5,0.2);
zeppelin waittill ("movedone");
wait(2);
zeppelin movez (215,5,0.5,0.2);
zeppelin waittill ("movedone");
zeppelin rotateyaw (90,2.5);
zeppelin waittill ("rotatedone");
wait(2);
zeppelin PlaySound("zeppe1");
zeppelin movex (-1140,7,0.5,0.2);
zeppelin waittill ("movedone");
zeppelin rotateyaw (90,2.5);
wait(1);
zeppelin PlaySound("zeppe1");
zeppelin movey (950,5,0.5,0.2);
zeppelin waittill ("movedone");
wait (1);
zeppelin movez (-280,5,0.5,0.2);
zeppelin waittill ("movedone");
} 
}  