main()
{
maps\mp\_load::main();

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

level thread ascensor();
level thread maps\mp\mp_tierra_hostil_v2_teleporters::main();
}
  
ascensor() { 
level.elevatorMoving1 = false;
level.elevatorDown1 = true;

trig_piolin_ascensor= getentarray ("trig_piolin_ascensor","targetname"); 
if ( isdefined(trig_piolin_ascensor) ) 
for (i = 0; i < trig_piolin_ascensor.size; i++) 
trig_piolin_ascensor[i] thread elevator_think1(); 
} 

elevator_think1() { 
while (1) { 
self waittill ("trigger"); 
if (!level.elevatorMoving1) 
thread elevator_move1();
wait (2); 
} 
} 

elevator_move1() { 
piolin_ascensor = getent ("piolin_ascensor", "targetname"); 
level.elevatorMoving1 = true; 
speed = 4; 
height = 566; 
wait (0); 
if (level.elevatorDown1) { 
piolin_ascensor PlaySound ("elevator1"); 
wait (0);
piolin_ascensor moveZ (height, speed); 
piolin_ascensor waittill ("movedone"); 
level.elevatorDown1 = false; 
} 
else { 
piolin_ascensor PlaySound ("elevator1");
wait (1);
piolin_ascensor moveZ (height - (height * 2), speed); 
piolin_ascensor waittill ("movedone"); 
level.elevatorDown1 = true; 
} 
level.elevatorMoving1 = false; 
} 



