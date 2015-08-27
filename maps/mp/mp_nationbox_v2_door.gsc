main()
{
thread door1_rotate();
}
door1_rotate()
{
door1 = getent("door", "targetname");
trig = getent("trig_door", "targetname");
while (1)
{
trig waittill("trigger");
door1 rotateyaw(90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
wait (5);
door1 rotateyaw(-90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
wait (5);
}
}

