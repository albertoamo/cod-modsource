main()
{
thread door1_rotate();
}

door1_rotate()
{
door1 = getent("door1", "targetname");
trig = getent("door_trigger1", "targetname");
while (1)
{
trig waittill("trigger");
door1 playsound("dooropen");
door1 rotateYaw(90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
wait (3);
door1 playsound("doorclose");
door1 rotateYaw(-90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
}
}