main()
{

//setCullFog (550,  5000, .32, .36, .40, 0);
setCullFog (550, 4200, .157, .157, .157, 0);
maps\mp\_load::main();
ambientPlay("ambient_mp_Hb");


        game["allies"] = "american";
	game["axis"] = "german";

	game["british_soldiertype"] = "normandy";
	game["british_soldiervariation"] = "normal";
	game["german_soldiertype"] = "normandy";
	game["german_soldiervariation"] = "normal";

	game["attackers"] = "allies";
	game["defenders"] = "axis";


thread logo_zom();
thread lift();
thread lift2();
thread secret();
thread sdoor();
thread sdoor2();
thread drivein();
thread tajna2();
thread door();
thread free();
thread kill();
thread teleport();
thread teleport2();
thread door1();
thread door3();
thread logo_hb();
thread logo_vrtuljak();
thread namewall();
}



logo_zom()
{
d1 = getent("hbzom","targetname");
d2 = getent("zombies","targetname");
d1 hide();	
while (1)
{
d2 hide();
d1 show();
wait (1.5);
d1 hide();
d2 show();
wait (1.5);
}
}



lift()
{
elevator=getent("lift","targetname");
trig=getent("trig_lift","targetname");
while(1)
{
trig waittill ("trigger");
elevator movex (855,7,1.9,1.9);
elevator waittill ("movedone");
wait(2);
elevator movex (-1925,7,1.9,5);
elevator waittill ("movedone");
wait(2);
elevator movex (1070,7,1.9,5);
elevator waittill ("movedone");
trig waittill ("trigger");
} 
} 



lift2()
{
elevator=getent("lift2","targetname");
trig=getent("trig_lift2","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (120,2,1,1);
elevator waittill ("movedone");
wait(1);
elevator movez (-120,2,1,1);
elevator waittill ("movedone");
} 
} 


secret()
{
elevator=getent("vrata","targetname");
trig=getent("trig_vrata","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (-56.5,2,1.5,0.5);
elevator waittill ("movedone");
wait(5);
elevator movez (56.5,2,1.5,0.5);
elevator waittill ("movedone");
} 
} 

sdoor()
{
elevator=getent("sdoor","targetname");
trig=getent("trig_sdoor","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (-90,1,0.5,0.5);
elevator waittill ("movedone");
wait(10);
elevator movez (90,1,0.5,0.5);
elevator waittill ("movedone");
} 
} 

sdoor2()
{
elevator=getent("sdoor2","targetname");
trig=getent("trig_sdoor2","targetname");
while(1)
{
trig waittill ("trigger");
elevator movex (-60,1,0.5,0.5);
elevator waittill ("movedone");
wait(10);
elevator movex (60,1,0.5,0.5);
elevator waittill ("movedone");
} 
} 

drivein()
{
elevator=getent("drivein","targetname");
trig=getent("trig_drivein","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (272,2,1,1);
elevator waittill ("movedone");
wait(0);
elevator movex (696,4,2,2);
elevator waittill ("movedone");
wait(0);
elevator movez (504,2,1,1);
elevator waittill ("movedone");
wait(0);
elevator movey (400,2,1,1);
elevator waittill ("movedone");
wait(0);
elevator movex (-1200,4,2,2);
elevator waittill ("movedone");
wait(0);
elevator movey (-200,2,1,1);
elevator waittill ("movedone");
wait(0);
elevator movez (-496,4,2,2);
elevator waittill ("movedone");
wait(10);
elevator movez (400,4,2,2);
elevator waittill ("movedone");
wait(0);
elevator movex (504,4,2,2);
elevator waittill ("movedone");
wait(0);
elevator movey (-200,2,1,1);
elevator waittill ("movedone");
wait(0);
elevator movez (-680,2,1,1);
elevator waittill ("movedone");


} 
} 

tajna2()
{
elevator=getent("tajna2","targetname");
trig=getent("trig_tajna2","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (50,1,0.5,0.5);
elevator waittill ("movedone");
wait(0);
elevator movez (-50,1,0.5,0.5);
elevator waittill ("movedone");
} 
} 


door()
{
door1 = getent("door", "targetname");
trig = getent("trig_door", "targetname");
while (1)
{
trig waittill("trigger");
door1 rotateyaw(90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
wait (2);
door1 rotateyaw(-90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
}
}




free()
{
elevator=getent("free","targetname");
trig=getent("trig_free","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (150,7,2,1.9);
elevator waittill ("movedone");
wait(1);
elevator movez (-150,7,2,5);
elevator waittill ("movedone");
} 
} 




kill()
{
elevator=getent("kill","targetname");
trig=getent("trig_kill","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (200,0.2,0.1,0.1);
elevator waittill ("movedone");
wait(1);
elevator movez (-200,7,1.9,5);
elevator waittill ("movedone");
} 
} 


teleport()
{

  entTransporter = getentarray("enter","targetname");
  if(isdefined(entTransporter))
  {
    for(lp=0;lp<entTransporter.size;lp=lp+1)
      entTransporter[lp] thread Transporter();
  }


}


Transporter()
{
  while(true)
  {
    self waittill("trigger",other);
    entTarget = getent(self.target, "targetname");

    wait(0.10);
    other setorigin(entTarget.origin);
    other setplayerangles(entTarget.angles);
    //iprintlnbold ("");
    wait(0.10);
  }
}


teleport2()
{

  entTransporter = getentarray("enter2","targetname");
  if(isdefined(entTransporter))
  {
    for(lp=0;lp<entTransporter.size;lp=lp+1)
      entTransporter[lp] thread Transporter();
  }


}


Transporter2()
{
  while(true)
  {
    self waittill("trigger",other);
    entTarget = getent(self.target, "targetname");

    wait(1);
    other setorigin(entTarget.origin);
    other setplayerangles(entTarget.angles);
    //iprintlnbold ("");
    wait(1);
  }
}



door1()
{
door1 = getent("door1", "targetname");
trig = getent("trig_door1", "targetname");
while (1)
{
trig waittill("trigger");
door1 rotateyaw(-90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
wait (2);
door1 rotateyaw(90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
}
}




door3()
{
door1 = getent("door3", "targetname");
trig = getent("trig_door3", "targetname");
while (1)
{
trig waittill("trigger");
door1 rotateyaw(90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
wait (2);
door1 rotateyaw(-90, 1.5, 0.7, 0.7);
door1 waittill("rotatedone");
}
}


logo_hb()
{
logo=getent("hb","targetname");
while(1)
{
logo rotatevelocity ( (0, 45, 0),1800 );
logo waittill ("rotatedone");
}
}


logo_vrtuljak()
{
logo=getent("vrtuljak","targetname");
while(1)
{
logo rotatevelocity ( (0, 45, 0),1800 );
logo waittill ("rotatedone");
}
}


namewall()
	{
	wall = getent("lol","targetname"); 
	trig = getent("trig_lol","targetname");

	while(true)
	{
	trig waittill("trigger", user);

	if ((user.name == "^1S^7pecial ^1S^7olider"))
	{
	wall notsolid();
	user iprintlnbold("^1'^9Wall ^7Close ^1in^9:");
	wait(0);
	user iprintlnbold("^1'^95^7s^1e^9c^7!");
	wait(1);
	user iprintlnbold("^1'^94^7s^1e^9c^7!");
	wait(1);
	user iprintlnbold("^1'^93^7s^1e^9c^7!");
	wait(1);
	user iprintlnbold("^1'^92^7s^1e^9c^7!");
	wait(1);
	user iprintlnbold("^1'^91^7s^1e^9c^7!");
	wait(1);
	wall solid();
	}
	else
	{
	user iprintlnbold("^1'^9U ^7idiot^1! ^9Only ^7special ^1soldiers ^9can ^7go ^1throw ^9walls^7!");
	user suicide();
	}
	}
	}
