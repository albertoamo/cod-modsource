
main()
{
maps\mp\_load::main();    
maps\mp\mp_box2_v2_gate::main();  
maps\mp\mp_box2_v2_weapons::main();
maps\mp\mp_box2_v2_jeeps::main();
maps\mp\mp_box2_v2_teleport1234::main();
maps\mp\mp_box2_v2_bomb1234::main();
maps\mp\mp_box2_v2_lights::main();
maps\mp\mp_box2_v2_drown::main();
maps\mp\mp_box2_v2_potato::main();
maps\mp\mp_box2_v2_bazooka::main();
thread scripted_door();
thread scripted_door2();
thread scripted_door3();
thread elevator1();
thread door_open();
thread ground_open();
thread ground_open2();
thread ground_open3();
thread ground_open4();
thread boat1();
thread boat2();
thread island_door();
}

scripted_door()
    {
    door = getent ("door1","targetname");
    trig = getent ("door_trig1","targetname");
    while (1)
    {
    trig waittill ("trigger");
    door rotateyaw ( -85, 1, 0.5, 0.5);
    trig delete();
    }
    }

scripted_door2()
{
liftpad2=getent("door2","targetname");
trig=getent("door_trig2","targetname");
while(1)
{
trig waittill ("trigger");
liftpad2 movez (184,1,0.75,0.25);
liftpad2 waittill ("movedone");
wait (4);
liftpad2 movez(-184,3,1,2);
liftpad2 waittill ("movedone");
}
}


scripted_door3()
{
liftpad=getent("door3","targetname");
trig=getent("door3_trig","targetname");
while(1)
{
trig waittill ("trigger");//
liftpad movez (192,1,0.75,0.25);
liftpad waittill ("movedone");
wait (4);
liftpad movez(-192,3,1,2);
liftpad waittill ("movedone");
}
}


 


elevator1()
{
liftpad2=getent("elevator1","targetname");
trig=getent("trigger1","targetname");
while(1)
{
trig waittill ("trigger");//
liftpad2 movey (-520,11,4,5);
liftpad2 waittill ("movedone");
wait (4);
liftpad2 movey(520,11,4,5);
liftpad2 waittill ("movedone");
}
}


ground_open()
{
door = getent("cage1_floor1", "targetname");	
trig = getent("cage_kill", "targetname");
while (1)
{
trig waittill("trigger");
door rotatepitch(90,2,1,1);
door waittill("rotatedone");
wait (4);
door rotatepitch(-90,2,1,1);
door waittill("rotatedone");
}
}


ground_open2()
{
door = getent("cage1_floor2", "targetname");	
trig = getent("cage_kill", "targetname");
while (1)
{
trig waittill("trigger");
door rotatepitch(-90,2,1,1);
door waittill("rotatedone");
wait (4);
door rotatepitch(90,2,1,1);
door waittill("rotatedone");
}
}




ground_open3()
{
door = getent("cage2_floor1", "targetname");	
trig = getent("cage2_move", "targetname");
while (1)
{
trig waittill("trigger");
door rotatepitch(90,2,1,1);
door waittill("rotatedone");
wait (4);
door rotatepitch(-90,2,1,1);
door waittill("rotatedone");
}
}


ground_open4()
{
door = getent("cage2_floor2", "targetname");	
trig = getent("cage2_move", "targetname");
while (1)
{
trig waittill("trigger");
door rotatepitch(-90,2,1,1);
door waittill("rotatedone");
wait (4);
door rotatepitch(90,2,1,1);
door waittill("rotatedone");
}
}




door_open()
{
liftpad = getent ("cage_door","targetname");
trig = getent ("cage_save","targetname");
while (1)
{
trig waittill ("trigger");
liftpad movez (-156,1,0.75,0.25);
liftpad waittill ("movedone");
wait (4);
trig waittill ("trigger");
liftpad movez(156,3,1,2);
liftpad waittill ("movedone");
wait (5);
}
}



boat1()
{
liftpad2=getent("boat1","targetname");
trig=getent("boat1_trig","targetname");
while(1)
{
trig waittill ("trigger");//
liftpad2 movex (-1368,20,10,10);
liftpad2 waittill ("movedone");
wait (4);
liftpad2 movex(1368,20,10,10);
liftpad2 waittill ("movedone");
}
}



boat2()
{
liftpad2=getent("boat2","targetname");
trig=getent("boat2_trig","targetname");
while(1)
{
trig waittill ("trigger");
liftpad2 movex (-1528,20,10,10);
liftpad2 waittill ("movedone");
wait (4);
liftpad2 movex(1528,20,10,10);
liftpad2 waittill ("movedone");
}
}


island_door()
{
door = getent("island_door", "targetname");	
trig = getent("island_door_trig", "targetname");
while (1)
{
trig waittill("trigger");
door rotatepitch(90,2,1,1);
door waittill("rotatedone");
wait (4);
door rotatepitch(-90,2,1,1);
door waittill("rotatedone");
}
}
