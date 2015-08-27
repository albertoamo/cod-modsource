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
level thread maps\mp\mp_tierra_hostil_teleporters::main();
thread fix();

}

fix()
{
	volume = [];
	volume[0] = -2498; // min (x)
	volume[1] = -1451; // min (y)
	volume[2] = -1260; // min  (z)
	volume[3] = 1353; // max  (x)
	volume[4] = 850; // max  (y)
	volume[5] = -1152; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player suicide();
	}
}
  
ascensor() { 
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
speed = 7; 
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



