main()
{
maps\mp\_load::main();

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "africa";

level thread Roller1();
level thread Roller2();
level thread RollDoor1();
level thread elevator_right();
level thread elevator_left();
level thread Hurt();

}

Hurt()
{
	volume = [];
	volume[0] = 2080; // min (x)
	volume[1] = 197; // min (y)
	volume[2] = 336; // min  (z)
	volume[3] = 2672; // max  (x)
	volume[4] = 254; // max  (y)
	volume[5] = 436; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "hurt");
	trigger._color = (1,0,0);
	trigger.dmg = 1000;
}


Roller1()
{
trig_roller1 = getent("trig_roller1","targetname");
roller1 = getent("roller1","targetname");
 
 for(;;)
  {

  trig_roller1  waittill("trigger",user1);
   user1 iprintlnbold("Gate Opening");
  roller1 movex (200,4);
   roller1 playsound ("elm_pipe_stress"); 
  wait 4;
   trig_roller1  waittill("trigger",user1);
  user1 iprintlnbold("Gate Closing");
   roller1 movex (-200,4);
  roller1 playsound ("elm_pipe_stress"); 
   wait 4;
   }

}

Roller2()
{
trig_roller2 = getent("trig_roller2","targetname");
roller2 = getent("roller2","targetname");
 
 for(;;)
  {

  trig_roller2  waittill("trigger",user2);
   user2 iprintlnbold("Gate Opening");
  roller2 movex (-200,4);
   roller2 playsound ("elm_pipe_stress"); 
  wait 4;
   trig_roller2  waittill("trigger",user2);
  user2 iprintlnbold("Gate Closing");
   roller2 movex (200,4);
  roller2 playsound ("elm_pipe_stress"); 
   wait 4;
   }

}

RollDoor1()
{
	trig_gatezs = getent("trig_gatezs","targetname");
	gatez1 = getent("gatez1","targetname");
	gatez2 = getent("gatez2","targetname");
 
	for(;;)
	{
		trig_gatezs waittill("trigger",user3); 

		gatez1 thread MoveWaittill("y", 50, 1); // movey (50,1);
		gatez2 thread MoveWaittill("y", -50, 1); // movey (-50,1);

		gatez1 playsound ("elm_pipe_stress");
 
		wait 6;

		while(isDefined(gatez1.ismoving) && isDefined(gatez2.ismoving))
			wait(0.25);

		gatez1 thread MoveWaittill("y", -50, 1); //  movey (-50,1);
		gatez2 thread MoveWaittill("y", 50, 1); //  movey (50,1);

		gatez2 playsound ("elm_pipe_stress"); 

		wait 4;

		while(isDefined(gatez1.ismoving) && isDefined(gatez2.ismoving))
			wait(0.25);
	}
}

MoveWaittill(dir, dist, time)
{
	self.ismoving = true;	

	if(dir == "y")
		self MoveY (dist, time);
	
	if(dir == "z")
		self MoveZ (dist, time);

	self waittill("movedone");
	self.ismoving = undefined;
}


elevator_right()
{
	elevator_right = getent("elevator_right","targetname");
	trig_elevator_right = getent("trig_elevator_right","targetname");
	elevator_right_extdoor1 = getent("elevator_right_extdoor1","targetname");
	elevator_right_extdoor2 = getent("elevator_right_extdoor2","targetname");
	elevator_right_intdoor1 = getent("elevator_right_intdoor1","targetname");
	elevator_right_intdoor2 = getent("elevator_right_intdoor2","targetname");
	elevator_right_downdoor1 = getent("elevator_right_downdoor1","targetname");
	elevator_right_downdoor2 = getent("elevator_right_downdoor2","targetname");
 
	for(;;)
	{
		trig_elevator_right waittill("trigger",user3); 
		elevator_right_extdoor1 thread MoveWaittill("y", 50, 2); // movey (50,2);
		elevator_right_extdoor2 thread MoveWaittill("y", -50, 2); //movey (-50,2);
		wait 1;

		elevator_right_intdoor1 thread MoveWaittill("y", 50, 2); //movey (50,2);
		elevator_right_intdoor2 thread MoveWaittill("y", -50, 2); //movey (-50,2);
		wait 5;

		while(isDefined(elevator_right_extdoor1.ismoving) || isDefined(elevator_right_extdoor2.ismoving) || isDefined(elevator_right_intdoor1.ismoving) || isDefined(elevator_right_intdoor2.ismoving))
			wait(0.25);

		elevator_right_extdoor1 thread MoveWaittill("y", -50, 2); // movey (-50,2);
		elevator_right_extdoor2 thread MoveWaittill("y", 50, 2); // movey (50,2);
		wait 1;
		elevator_right_intdoor1 thread MoveWaittill("y", -50, 2); //movey (-50,2);
		elevator_right_intdoor2 thread MoveWaittill("y", 50, 2); //movey (50,2);

		wait 2;

		while(isDefined(elevator_right_extdoor1.ismoving) || isDefined(elevator_right_extdoor2.ismoving) || isDefined(elevator_right_intdoor1.ismoving) || isDefined(elevator_right_intdoor2.ismoving))
			wait(0.25);

		elevator_right movez (-2089,4);
		elevator_right_intdoor1 movez (-2089,4);
		elevator_right_intdoor2 movez (-2089,4);
		elevator_right waittill("movedone");

		elevator_right_intdoor1 thread MoveWaittill("y", 50, 2); // movey (50,2);
		elevator_right_intdoor2 thread MoveWaittill("y", -50, 2); // movey (-50,2);

		wait 1;

		elevator_right_downdoor1 thread MoveWaittill("y", 50, 2); // movey (50,2);
		elevator_right_downdoor2 thread MoveWaittill("y", -50, 2); // movey (-50,2);

		wait 6;

		while(isDefined(elevator_right_downdoor1.ismoving) || isDefined(elevator_right_downdoor2.ismoving) || isDefined(elevator_right_intdoor1.ismoving) || isDefined(elevator_right_intdoor2.ismoving))
			wait(0.25);

		elevator_right_downdoor1 thread MoveWaittill("y", -50, 2); // movey (-50,2);
		elevator_right_downdoor2 thread MoveWaittill("y", 50, 2); // movey (50,2);

		wait 1;
		elevator_right_intdoor1 thread MoveWaittill("y", -50, 2); // movey (-50,2);
		elevator_right_intdoor2 thread MoveWaittill("y", 50, 2); // movey (50,2);

		wait 2;

		while(isDefined(elevator_right_downdoor1.ismoving) || isDefined(elevator_right_downdoor2.ismoving) || isDefined(elevator_right_intdoor1.ismoving) || isDefined(elevator_right_intdoor2.ismoving))
			wait(0.25);

		elevator_right movez (2089,4);
		elevator_right_intdoor1 movez (2089,4);
		elevator_right_intdoor2 movez (2089,4);
		elevator_right waittill("movedone");
	}
}

elevator_left()
{
	elevator_left = getent("elevator_left","targetname");
	trig_elevator_left = getent("trig_elevator_left","targetname");
	elevator_left_extdoor1 = getent("elevator_left_extdoor1","targetname");
	elevator_left_extdoor2 = getent("elevator_left_extdoor2","targetname");
	elevator_left_intdoor1 = getent("elevator_left_intdoor1","targetname");
	elevator_left_intdoor2 = getent("elevator_left_intdoor2","targetname");
	elevator_left_downdoor1 = getent("elevator_left_downdoor1","targetname");
	elevator_left_downdoor2 = getent("elevator_left_downdoor2","targetname");
 
	for(;;)
	{
		trig_elevator_left waittill("trigger",user3);

		elevator_left_extdoor1 thread MoveWaittill("y", 50, 2); //  movey (50,2);
		elevator_left_extdoor2 thread MoveWaittill("y", -50, 2); //  movey (-50,2);

		wait 1;

		elevator_left_intdoor1 thread MoveWaittill("y", 50, 2); //  movey (50,2);
		elevator_left_intdoor2 thread MoveWaittill("y", -50, 2); //  movey (-50,2);

		wait 5;

		while(isDefined(elevator_left_intdoor1.ismoving) || isDefined(elevator_left_intdoor2.ismoving) || isDefined(elevator_left_extdoor1.ismoving) || isDefined(elevator_left_extdoor2.ismoving) )
			wait(0.25);

		elevator_left_extdoor1 thread MoveWaittill("y", -50, 2); //  movey (-50,2);
		elevator_left_extdoor2 thread MoveWaittill("y", 50, 2); //  movey (50,2);
		wait 1;

		elevator_left_intdoor1 thread MoveWaittill("y", -50, 2); //  movey (-50,2);
		elevator_left_intdoor2 thread MoveWaittill("y", 50, 2); //  movey (50,2);

		wait 2;

		while(isDefined(elevator_left_intdoor1.ismoving) || isDefined(elevator_left_intdoor2.ismoving) || isDefined(elevator_left_extdoor1.ismoving) || isDefined(elevator_left_extdoor2.ismoving) )
			wait(0.25);

		elevator_left movez (-2089,4);
		elevator_left_intdoor1 movez (-2089,4);
		elevator_left_intdoor2 movez (-2089,4);
		elevator_left waittill("movedone");

		elevator_left_intdoor1 thread MoveWaittill("y", 50, 2); //  movey (50,2);
		elevator_left_intdoor2 thread MoveWaittill("y", -50, 2); //  movey (-50,2);

		wait 1;

		elevator_left_downdoor1 thread MoveWaittill("y", 50, 2); //  movey (50,2);
		elevator_left_downdoor2 thread MoveWaittill("y", -50, 2); //  movey (-50,2);

		wait 6;

		while(isDefined(elevator_left_intdoor1.ismoving) || isDefined(elevator_left_intdoor2.ismoving) || isDefined(elevator_left_downdoor1.ismoving) || isDefined(elevator_left_downdoor2.ismoving) )
			wait(0.25);

		elevator_left_downdoor1 thread MoveWaittill("y", -50, 2); //  movey (-50,2);
		elevator_left_downdoor2 thread MoveWaittill("y", 50, 2); //  movey (50,2);

		wait 1;

		elevator_left_intdoor1 thread MoveWaittill("y", -50, 2); //  movey (-50,2);
		elevator_left_intdoor2 thread MoveWaittill("y", 50, 2); //  movey (50,2);

		wait 2;

		while(isDefined(elevator_left_intdoor1.ismoving) || isDefined(elevator_left_intdoor2.ismoving) || isDefined(elevator_left_downdoor1.ismoving) || isDefined(elevator_left_downdoor2.ismoving) )
			wait(0.25);

		elevator_left movez (2089,4);
		elevator_left_intdoor1 movez (2089,4);
		elevator_left_intdoor2 movez (2089,4);
		elevator_left waittill("movedone");
	}
}