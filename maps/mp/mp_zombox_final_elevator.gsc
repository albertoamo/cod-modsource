main()
{
        level.elevatorDown = true;
        level.elevatorMoving = false;
        thread elevator_start(); 
}

elevator_start() { 
elevator = getentarray ("elevatorswitch","targetname"); 
if ( isdefined(elevator) ) 
for (i = 0; i < elevator.size; i++) 
elevator[i] thread elevator_think(); 
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
elevatormodel = getent ("elevatormodel", "targetname"); 
level.elevatorMoving = true; 
speed = 7; 
height = 2090; 
//wait (0); 
if (level.elevatorDown) { 
elevatormodel PlaySound ("elevator1"); 
wait (2);
elevatormodel moveZ (height, speed); 
elevatormodel waittill ("movedone"); 
level.elevatorDown = false; 
} 
else { 
elevatormodel PlaySound ("elevator1");
wait (1);
elevatormodel moveZ (height - (height * 2), speed); 
elevatormodel waittill ("movedone"); 
level.elevatorDown = true; 
} 
level.elevatorMoving = false; 
} 