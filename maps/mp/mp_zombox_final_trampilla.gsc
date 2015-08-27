main() 
{
thread trap_rotate();
}
trap_rotate()
{
door2 = getent("trap64", "targetname");
trig = getent("trap1", "targetname");
while (1)
{
trig waittill("trigger");
door2 rotatepitch(90, 1.5, 0.7, 0.7);
door2 PlaySound ("trap1_open"); 
door2 waittill("rotatedone");
wait (5);
door2 rotatepitch(-90, 1.5, 0.7, 0.7);
door2 waittill("rotatedone"); 
door2 PlaySound ("trap1_close");
}
}

