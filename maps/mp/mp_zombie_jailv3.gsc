main()
{
maps\mp\_load::main();
maps\mp\mp_zombie_jailv3_teleportenter::main(); 
	game["allies"] = "american";
	game["axis"] = "german";

	game["british_soldiertype"] = "normal";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";
thread liftpad_slider ();
thread liftpad_slider2 ();
thread liftpad_slider3 ();
thread liftpad_slider4 ();
thread liftpad_slider5 ();
thread door ();
thread door2();
thread boat2();
thread boat();
precacheShellShock("default_mp");
maps\mp\mp_zombie_jailv3_damage_control::main();
thread drawbridge_open ();
thread drawbridge_open2 ();

}
liftpad_slider5()
			{
trig=getent("free","targetname");
normdoor = getent("trapdoor","targetname");
while(1)
{
trig waittill ("trigger");
			normdoor rotateto( (0,-90,0),2);
			normdoor waittill ("rotatedone");
			wait (1);
			normdoor rotateto( (0,0,0),2);
			normdoor waittill ("rotatedone");
			}
}
liftpad_slider()
{
liftpad2=getent("cry","targetname");
while(1)
	{
wait(4);
liftpad2 movey (5478,20,4,5);
liftpad2 waittill ("movedone");
wait (4);
liftpad2 movey(-5478,20,4,5);
liftpad2 waittill ("movedone");
	}
}
boat()
{
liftpad2=getent("boat2","targetname");
while(1)
	{
wait (4);
liftpad2 movey (4078,20,4,5);
liftpad2 waittill ("movedone");
wait (4);
liftpad2 movey(-4078,20,4,5);
liftpad2 waittill ("movedone");
	}
}
boat2()
{
liftpad2=getent("boat3","targetname");
while(1)
	{
wait (4);
liftpad2 movex (-5088,20,4,5);
liftpad2 waittill ("movedone");
wait (4);
liftpad2 movex(5088,20,4,5);
liftpad2 waittill ("movedone");
	}
}
liftpad_slider3()
{
trig=getent("trig_washer","targetname");
liftpad3=getent("washer","targetname");
while(1)
	{
trig waittill ("trigger");
wait (4);
liftpad3 movez (3028,20,4,5);
liftpad3 waittill ("movedone");
wait (4);
liftpad3 movez(-3028,20,4,5);
liftpad3 waittill ("movedone");
	}
}
liftpad_slider4()
{
trig=getent("trig_twat67","targetname");
liftpad3=getent("twat67","targetname");
while(1)
	{
trig waittill ("trigger");
liftpad3 movez (2968,20,4,5);
liftpad3 waittill ("movedone");
wait (4);
liftpad3 movez(-2968,20,4,5);
liftpad3 waittill ("movedone");
	}
}
liftpad_slider2()
{
liftpad=getent("boat","targetname");
while(1)
	{
wait (4);
liftpad movey (3000,20,4,5);
liftpad waittill ("movedone");
wait (4);
liftpad movey(-3000,20,4,5);
liftpad waittill ("movedone");
	}
}
door2 ()
{
roll = getent("bope1", "targetname");
roll2 = getent("bope2", "targetname");

  trig1 = getent("bope11","targetname");
  trig2 = getent("bope22","targetname");
  trig2 enablelinkto();
  trig2 linkto(roll2);
normdoor2 = getent("bope","targetname");
trig1 enablelinkto();
trig1 linkto(roll);


while(1)
  {
    trig2 waittill("damage", dmg, other);
	if(dmg > 30)
	{
    	trig1 waittill("damage", dmg, other);
		if(dmg > 30)
		{
	wait(2);
	normdoor2 movez (-528,1,0);
	normdoor2 waittill ("movedone");
	wait (1);
	normdoor2 movez(528,1,0);
	normdoor2 waittill ("movedone");;
			
		}
	}
   }
}
door ()
{
ball1 = getent("hitthis1", "targetname");
ball2 = getent("hitthis2", "targetname");
ball3 = getent("hitthis3", "targetname");
  b_trig1 = getent("door1","targetname");
  b_trig2 = getent("door2","targetname");
  b_trig3 = getent("door3","targetname");
  b_trig2 enablelinkto();
  b_trig2 linkto(ball2);
normdoor=getent("doorR","targetname");
b_trig1 enablelinkto();
b_trig1 linkto(ball1);
b_trig3 enablelinkto();
b_trig3 linkto(ball3);

  while(1)
  {
    b_trig1 waittill("damage", dmg, other);
	if(dmg > 30)
	{
    	b_trig2 waittill("damage", dmg, other);
		if(dmg > 30)
		{
   	 	b_trig3 waittill("damage", dmg, other);
			if(dmg > 30)
			{
			normdoor rotateto( (0,-90,0),2);
			normdoor waittill ("rotatedone");
			wait (1);
			normdoor rotateto( (0,0,0),2);
			normdoor waittill ("rotatedone");
			}
		}
	}
   }
}
drawbridge_open()
{
drawbridge=getent("bridge","targetname");
drawbridge1=getent("bridge1","targetname");
trig=getent("bridgel","targetname");
drawbridge1 rotateto( (90,0,0),6);
drawbridge rotateto( (-90,0,0),6);
while(1)
{
trig waittill ("trigger");
drawbridge1 rotateto( (0,0,0),6);
drawbridge rotateto( (0,0,0),6);
drawbridge waittill ("rotatedone");
wait(10);
drawbridge1 rotateto( (90,0,0),6);
drawbridge rotateto( (-90,0,0),6);
} 
}	
drawbridge_open2()
{
drawbridge=getent("trap","targetname");
drawbridge1=getent("trap1","targetname");
trig=getent("die","targetname");
drawbridge1 rotateto( (0,0,0),6);
drawbridge rotateto( (0,0,0),6);
while(1)
{
trig waittill ("trigger");
drawbridge1 rotateto( (90,0,0),2);
drawbridge rotateto( (-90,0,0),2);
drawbridge waittill ("rotatedone");
wait(5);
drawbridge1 rotateto( (0,0,0),2);
drawbridge rotateto( (0,0,0),2);
} 
}