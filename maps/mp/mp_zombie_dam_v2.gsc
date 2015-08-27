
main()
{
maps\mp\_load::main();
level thread tower_elevator1();  
level thread rail_shuttle();   
level thread island_bridge();
level thread boat_slide1();
level thread boat_slide2();
level thread jail_save();
level thread jail_kill();
level thread boat_move();
level thread tower_elevator2();  
level thread maps\mp\mp_zombie_dam_v2_teleporters::main();

level.elevatorDown = true;
level.elevatorMoving = false;
level.elevatorDown2 = true;
level.elevatorMoving2 = false;
}
 
jail_kill()
{
trig_jail_kill=getent("trig_jail_kill","targetname");
jail_trap1=getent("jail_trap1","targetname");
jail_trap2=getent("jail_trap2","targetname");
//jail_nocoll=getent("jail_nocoll","targetname");
while(1)
{
trig_jail_kill waittill ("trigger");
//jail_nocoll hide();
jail_trap1 rotatepitch(-90, 0.7, 0.5, 0.2);
jail_trap2 rotatepitch(90, 0.7, 0.5, 0.2);
jail_trap2 waittill("rotatedone");
wait(4);
jail_trap1 rotatepitch(90, 2, 1.2, 0.8);
jail_trap2 rotatepitch(-90, 2, 1.2, 0.8);
jail_trap2 waittill("rotatedone");
//jail_nocoll show();
}
}

jail_save()
{
trig_jail_save=getent("trig_jail_save","targetname");
jail_plat1=getent("jail_plat1","targetname");
jail_door=getent("jail_door","targetname");
while(1)
{
trig_jail_save waittill ("trigger");
jail_plat1 movey (90,2.5,1.2,1.2);
jail_plat1 waittill("movedone");
jail_door rotateyaw(-90, 2.5, 1.2, 1.2);
jail_door waittill("rotatedone");
wait(5);
jail_door rotateyaw(90, 2.5, 1.2, 1.2);
jail_door waittill("rotatedone");
jail_plat1 movey (-90,2.5,1.2,1.2);
jail_plat1 waittill("movedone");
}
}

boat_move()
{
boat_move=getent("boat_move","targetname");
trig_boat_move=getent("trig_boat_move","targetname");
p1= (1776,1416,-128);
while(1)
{
trig_boat_move waittill ("trigger");
wait(1);
boat_move movey (992,6,3.2,2.8);
boat_move waittill("movedone");
boat_move rotateyaw(-90, 2.5, 1.25, 1.25);
boat_move waittill("rotatedone");
boat_move movex (168,2,1,1);
boat_move waittill("movedone");
boat_move rotateyaw(90, 2.5, 1.2, 1.2);
boat_move waittill("rotatedone");
boat_move movey (1700,9,5,4);
boat_move waittill("movedone");
boat_move rotateyaw(90, 2.5, 1.2, 1.2);
boat_move waittill("rotatedone");
boat_move movex (-2100,8,4,4);
boat_move waittill("movedone");
boat_move rotateyaw(90, 2.5, 1.2, 1.2);
boat_move waittill("rotatedone");
boat_move movey (-2400,9,4,5);
boat_move waittill("movedone");
boat_move rotateyaw(90, 2.5, 1.2, 1.2);
boat_move waittill("rotatedone");
boat_move movex (1950,8,4,4);
boat_move waittill("movedone");
boat_move rotateyaw(90, 2.5, 1.2, 1.2);
boat_move waittill("rotatedone");
boat_move moveto (p1,2);
//boat_move waittill("movedone");

}
}			

tower_elevator1() { 
elevator_left_trig= getentarray ("trig_elevator_left","targetname"); 
if ( isdefined(elevator_left_trig) ) 
for (i = 0; i < elevator_left_trig.size; i++) 
elevator_left_trig[i] thread elevator_think(); 
} 

elevator_think() { 
while (1) { 
self waittill ("trigger"); 
if (!level.elevatorMoving) 
thread elevator_move();
wait (2); 
} 
} 

elevator_move() { 
elevator_left = getent ("tower_elevator_left", "targetname"); 
level.elevatorMoving = true; 
speed = 15; 
height = 2000; 
wait (0); 
if (level.elevatorDown) { 
elevator_left PlaySound ("elevator1"); 
wait (0);
elevator_left moveZ (height, speed); 
elevator_left waittill ("movedone"); 
level.elevatorDown = false; 
} 
else { 
elevator_left PlaySound ("elevator1");
wait (1);
elevator_left moveZ (height - (height * 2), speed); 
elevator_left waittill ("movedone"); 
level.elevatorDown = true; 
} 
level.elevatorMoving = false; 
} 

tower_elevator2() { 
elevator_right_trig= getentarray ("trig_elevator_right","targetname"); 
if ( isdefined(elevator_right_trig) ) 
for (i = 0; i < elevator_right_trig.size; i++) 
elevator_right_trig[i] thread elevator_think2(); 
} 

elevator_think2() { 
while (1) { 
self waittill ("trigger"); 
if (!level.elevatorMoving2) 
thread elevator_move2();
wait (2); 
} 
} 

elevator_move2() { 
elevator_right = getent ("tower_elevator_right", "targetname"); 
level.elevatorMoving2 = true; 
speed2 = 15; 
height2 = 2000; 
wait (0); 
if (level.elevatorDown2) { 
elevator_right PlaySound ("elevator1"); 
wait (0);
elevator_right moveZ (height2, speed2); 
elevator_right waittill ("movedone"); 
level.elevatorDown2 = false; 
} 
else { 
elevator_right PlaySound ("elevator1");
wait (1);
elevator_right moveZ (height2 - (height2 * 2), speed2); 
elevator_right waittill ("movedone"); 
level.elevatorDown2 = true; 
} 
level.elevatorMoving2 = false; 
} 

rail_shuttle()
{
rail_shuttle=getent("rail_shuttle","targetname");
trig_shuttle=getent("trig_shuttle","targetname");
while(1)
{
trig_shuttle waittill ("trigger");
wait(1);
rail_shuttle movey (3978,10,1.9,1.9);
rail_shuttle waittill ("movedone");
wait(5);
rail_shuttle movey (-3978,10,1.9,5);
rail_shuttle waittill ("movedone");
} 
}

island_bridge()
{
bridge_back=getent("bridge_back","targetname");
bridge_front=getent("bridge_front","targetname");
trig_bridge=getent("trig_bridge","targetname");
bridge_back rotateroll(50, 1.5, 0.7, 0.7);
bridge_front rotateroll(-50, 1.5, 0.7, 0.7);
while(1)
{
trig_bridge waittill ("trigger");
wait(1);
bridge_back rotateroll(-50, 5, 0.7, 0.7);
bridge_front rotateroll(50, 5, 0.7, 0.7);
bridge_front waittill("rotatedone");
wait(12);
bridge_back rotateroll(50, 5, 0.7, 0.7);
bridge_front rotateroll(-50, 5, 0.7, 0.7);
bridge_front waittill("rotatedone");
} 
}

boat_slide1()
{
boat_slide1=getent("boat_slide1","targetname");
trig_boat_slide1=getent("trig_boat_slide1","targetname");
while(1)
{
trig_boat_slide1 waittill ("trigger");
wait(1);
boat_slide1 movey (1920,8,1.9,1.9);
boat_slide1 waittill ("movedone");
wait(5);
boat_slide1 movey (-1920,8,1.9,1.9);
boat_slide1 waittill ("movedone");

} 
}

boat_slide2()
{
boat_slide2=getent("boat_slide2","targetname");
trig_boat_slide2=getent("trig_boat_slide2","targetname");
while(1)
{
trig_boat_slide2 waittill ("trigger");
wait(1);
boat_slide2 movey (1920,8,1.9,1.9);
boat_slide2 waittill ("movedone");
wait(5);
boat_slide2 movey (-1920,8,1.9,1.9);
boat_slide2 waittill ("movedone");

} 
}