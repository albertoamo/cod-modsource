main()
{
maps\mp\_load::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_france");

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3") ;


	entTransporter = getentarray("enter","targetname");
	
	if(isdefined(entTransporter))
	{
		for(lp = 0; lp < entTransporter.size; lp++)
			entTransporter[lp] thread Transporter();
	}

thread baros();
thread baros2();
thread baros3();
thread moveDoor();
thread pont1_rotate();
thread roue_rotate();
thread stairs_rotate();
thread moveDoord();
thread fleur1_rotate();
thread fleur2_rotate();
thread fleur3_rotate();
thread fleur4_rotate();
thread ce_rotate();
thread protec();
thread anneau_rotate();
thread pont2();
thread ponts_rotate();
thread blocks_rotate();
thread barox();
thread porte();
thread porte2_rotate();
thread porte3_rotate();
thread portev_rotate();
thread piece();
thread ut3();
thread tonneau_rotate();
thread tonneaufin_rotate();
thread rond_rotate();
thread parle();
thread etoile();
thread sept();
thread randomplayer();
}

baros()
{
baros=getent("baros","targetname");
while(1)
{
baros movez (-140,1000,0,0);
baros waittill ("movedone");
}
}


baros2()
{
baros2=getent("baros2","targetname");
trig=getent("trig_baros2","targetname");
while(1)
{
trig waittill ("trigger",user);
baros2 movez (-114,5,2,2);
baros2 waittill ("movedone");
iprintlnbold (user.name +"^7 has opened the jail doors -> say ^1thanks^7!");
wait(30);
baros2 movez (114,5,2,2);
baros2 waittill ("movedone");
wait(15);
}
}

pont1_rotate()
{
pont1=getent("pont1","targetname");
while(1)
{
wait(180);
pont1 rotateyaw(-180,6,1,4);
pont1 waittill("rotatedone");
iprintlnbold ("the ^4blue ^7bridge is open!");
wait(9999);
}
}

moveDoor()
{
	doortrig = getent("doortrig","targetname");
	door1 = getent("door1","targetname");
	door2 = getent("door2","targetname");
	door3 = getent("door3","targetname");
	door4 = getent("door4","targetname");
	
	while(1)
	{
		doortrig waittill("trigger");
		door1 movez(92,1);
		door2 movey(-80,1);
		door3 movez(-92,1);
		door4 movey(80,1);
		wait (2);
		door1 movez(-92,1);
		door2 movey(80,1);
		door3 movez(92,1);
		door4 movey(-80,1);
		wait (2);

	}
}

baros3()
{
baros3=getent("baros3","targetname");
while(1)
{
wait(800);
baros3 movez(168,5,2,2);
baros3 waittill("movedone");
iprintlnbold ("the way to the ^1red ^7door is free!");
wait(9999);
}
}

roue_rotate()
{
roue=getent("roue","targetname");
while(1)
{
wait(500);
roue rotateroll(-57,6,1,4);
roue waittill("rotatedone");
iprintlnbold ("the lower rooms are now available!");
wait(9999);
}
}


stairs_rotate()
{
stairs=getent("stairs","targetname");
while(1)
{
wait(1000);
stairs rotateyaw(-90,3,1,1);
stairs waittill("rotatedone");
iprintlnbold ("the ^4blue ^7stairs have rotated!");
wait(9999);
}
}

moveDoord()
{
	trig1 = getent("trig_jaune1","targetname");
	trig2 = getent("trig_jaune2","targetname");
	trig3 = getent("trig_jaune3","targetname");
	door5 = getent("door5","targetname");
	door6 = getent("door6","targetname");
	door7 = getent("door7","targetname");
	door8 = getent("door8","targetname");
	door9 = getent("door9","targetname");
	door10 = getent("door10","targetname");
	door11 = getent("door11","targetname");
	door12 = getent("door12","targetname");
	
	while(1)
	{
		trig1 waittill("trigger",user);
		trig2 waittill("trigger",user);
		trig3 waittill("trigger",user);
		door5 movez(92,1);
		door6 movey(-80,1);
		door7 movez(-92,1);
		door8 movey(80,1);
		wait (2);
		door9 movez(92,1);
		door10 movey(-80,1);
		door11 movez(-92,1);
		door12 movey(80,1);
		iprintlnbold ("the ^3yellow ^7door has been opened for 90 seconds by "+user.name);
		wait (90);
		door5 movez(-92,1);
		door6 movey(80,1);
		door7 movez(92,1);
		door8 movey(-80,1);
		wait (2);
		door9 movez(-92,1);
		door10 movey(80,1);
		door11 movez(92,1);
		door12 movey(-80,1);
		wait (5);

	}
}

fleur1_rotate()
{
	fleur1 = getent("fleur1", "targetname");

	while (1)
	{
		fleur1 rotateyaw(360,7,1,1);
		fleur1 waittill("rotatedone");
		wait (2);

	}
}

fleur2_rotate()
{
	fleur2 = getent("fleur2", "targetname");

	while (1)
	{
		fleur2 rotateyaw(360,7,1,1);
		fleur2 waittill("rotatedone");
		wait (2);

	}
}

fleur3_rotate()
{
	fleur3 = getent("fleur3", "targetname");

	while (1)
	{
		fleur3 rotateyaw(360,7,1,1);
		fleur3 waittill("rotatedone");
		wait (2);

	}
}

fleur4_rotate()
{
	fleur4 = getent("fleur4", "targetname");

	while (1)
	{
		fleur4 rotateyaw(360,7,1,1);
		fleur4 waittill("rotatedone");
		wait (2);

	}
}

ce_rotate()
{
	ce = getent("ce", "targetname");

	while (1)
	{
		ce rotateyaw(360,5,0,0);
		ce waittill("rotatedone");

	}
}


protec()
{
protec=getent("protec","targetname");
trig=getent("trig_protec","targetname");
while(1)
{
trig waittill ("trigger");
protec movez (-152,5,2,2);
protec waittill ("movedone");
wait(15);
protec movez (152,5,2,2);
protec waittill ("movedone");
wait(15);
}
}

pont2()
{
pont2=getent("pont2","targetname");
while(1)
{
wait(360);
pont2 movex(-272,7,3,3);
pont2 waittill("movedone");
iprintlnbold ("the ^2green ^7bridge has opened!");
wait(9999);
}
}

anneau_rotate()
{
	anneau = getent("anneau", "targetname");

	while (1)
	{
		anneau rotateyaw(360,5,0,0);
		anneau waittill("rotatedone");

	}
}

ponts_rotate()
{
ponts = getent("ponts", "targetname");
trig = getent("trig_ponts", "targetname");
while (1)
{
trig waittill("trigger");
ponts rotateroll(-40,4,1,1);
ponts waittill("rotatedone");
wait (30);
ponts rotateroll(40,3,1,1);
ponts waittill("rotatedone");
wait (90);
}
}

blocks_rotate()
{
blocks = getent("blocks", "targetname");
trig = getent("trig_blocks", "targetname");
while (1)
{
trig waittill("trigger");
blocks rotateroll(-130,4,1,1);
blocks waittill("rotatedone");
wait (30);
blocks rotateroll(130,3,1,1);
blocks waittill("rotatedone");
wait (60);
}
}

barox()
{
barox=getent("barox","targetname");
trig=getent("trig_barox","targetname");
while(1)
{
trig waittill ("trigger");
barox movez (-112,5,2,2);
barox waittill ("movedone");
wait(40);
barox movez (112,5,2,2);
barox waittill ("movedone");
wait(70);
}
}

porte()
{
porte=getent("porte","targetname");
while(1)
{
wait(1200);
porte hide();
porte notsolid();
iprintlnbold ("the ^4blue ^7door has been deleted!");
wait(9999);
}
}

porte2_rotate()
{
	trig1=getent("trig_porte21","targetname");
	trig2=getent("trig_porte22","targetname");
	porte2=getent("porte2","targetname");

	while(true)
	{
		trig1 waittill("damage");
		trig2 waittill("damage");
		porte2 rotatepitch(90,2,1,1);
		porte2 waittill("rotatedone");
		wait (1);
		porte2 rotatepitch(-90,2,1,1);
		porte2 waittill("rotatedone");
		wait (5);
	}
}


porte3_rotate()
{
	trig1=getent("trig_secretdoor1","targetname");
	trig2=getent("trig_secretdoor2","targetname");
	trig3=getent("trig_secretdoor3","targetname");
	issue=getent("secretdoor","targetname");

	while(true)
	{
		trig1 waittill("damage");
		trig2 waittill("damage");
		trig3 waittill("damage");
		issue rotateroll(-90,2,1,1);
		issue waittill("rotatedone");
		wait (3);
		issue rotateroll(90,2,1,1);
		issue waittill("rotatedone");
		wait (5);
	}
}

portev_rotate()
{
portev = getent("uneporte", "targetname");
trig = getent("trig_uneporte", "targetname");
while (1)
{
trig waittill("trigger");
portev rotateroll(90,2,1,1);
portev waittill("rotatedone");
wait (1);
portev rotateroll(-90,2,1,1);
portev waittill("rotatedone");
}
}


piece()
{
	trig1=getent("trig_newdeal","targetname");
	door=getent("newdeal","targetname");

	while(true)
	{
		trig1 waittill("trigger",user);
		door hide();
		door notsolid();
		iprintlnbold (user.name+"^7 is awesome: he made the fast-way-down now available!");
		wait(9999);
	}
}


ut3()
{
    situtrouve = getent("situtrouve","targetname");
    while(true)
	{
		situtrouve waittill("trigger", user);

		if ((user getGuid() == 1684701))
		{
iprintlnbold ("my ^1YouTube ^7 user name is ");
wait (3);
iprintlnbold ("SITUTROUVE");
wait (3);
iprintlnbold ("don't hesitate to go check my ^4channel ");
wait (6);
		}
		else
		{
iprintlnbold ("^4HA^7HA^1HA");
wait(25);
		}
	}
}

Transporter()
{
while(true)
{
self waittill("trigger",other);
entTarget = getent(self.target, "targetname");

other setorigin(entTarget.origin);
other setplayerangles(entTarget.angles);
wait(0.2);
other iprintlnbold ("You have been teleported^1!!");

}
}

tonneau_rotate()
{
	tonneau = getent("tonneau", "targetname");

	while (1)
	{
		tonneau rotateroll(360,5,0,0);
		tonneau waittill("rotatedone");

	}
}


tonneaufin_rotate()
{
	tonneaufin = getent("tonneaufin", "targetname");
	trig1=getent("trig_tonneaufin","targetname");

	while (1)
	{
		trig1 waittill("trigger");
		tonneaufin rotateyaw(-90,3,0,0);
		tonneaufin waittill("rotatedone");
		wait(6);
		tonneaufin rotateyaw(90,3,0,0);
		tonneaufin waittill("rotatedone");
		wait(3);

	}
}



rond_rotate()
{
	trig1=getent("trig_rond1","targetname");
	trig2=getent("trig_rond2","targetname");
	rond=getent("rond","targetname");

	while(true)
	{
		trig1 waittill("trigger",user);
		trig2 waittill("trigger",user);
		rond rotateroll(110,3,1,1);
		rond waittill("rotatedone");
		iprintlnbold (user.name +"^7 has opened the ^1red ^7circle =  the fame shop is now available");
		wait (9999);

	}
}


parle()
{
trigger = getent ("trig_parle","targetname");
while(1)
{
trigger waittill ("trigger",user);
switch(randomint(11))
{
	case 0:
		iprintlnbold(user.name+" ^7 is a pro!");
		break;
	case 1:
		iprintlnbold(user.name+" ^7 rocks!");
		break;
	case 2:
		iprintlnbold(user.name+" ^7 owns all!");
		break;
	case 3:
		iprintlnbold(user.name+" ^7 is way too good!");
		break;
	case 4:
		iprintlnbold(user.name+" ^7 is pwnin'!");
		break;
	case 5:
		iprintlnbold("^7 everybody fears "+user.name);
		break;
	case 6:
		iprintlnbold(user.name+" ^7 is a zombie slayer!");
		break;
	case 7:
		iprintlnbold(user.name+" ^7 is way too dangerous!");
		break;
	case 8:
		iprintlnbold("^7 respect "+user.name);
		break;
	case 9:
		iprintlnbold("^7 nobody stands a chance against "+user.name);
		break;
	case 10:
		iprintlnbold("^7nothing scares "+user.name);
		break;
}
wait(9);
}
}


sept()
{
	trig1=getent("trig_sept1","targetname");
	trig2=getent("trig_sept2","targetname");
	trig3=getent("trig_sept3","targetname");
	lol=getent("sept","targetname");

	while(true)
	{
		trig1 waittill("trigger",user);
		trig2 waittill("trigger",user);
		trig3 waittill("trigger",user);
		lol hide();
		lol notsolid();
		iprintlnbold (user.name +"^7 has freed the way to the ^4blue ^7star =  the infamy shop is now available");
		wait (9999);

	}
}

etoile()
{
    wall = getent("etoile","targetname");
    trig = getent("trig_etoile","targetname");
	trig setHintString("very comon insult");
    while(true)
	{
		trig waittill("trigger", user);

		if (user.name == "^4KURWA")
		{
			wall notsolid();
			user iprintlnbold("Welcome to the infamy shop!");
			wait(3);
			wall solid();
			wait(5);
		}
		else
		{
			wall solid();
			user iprintlnbold ("sorry man, Try again when you pwned hgshout");
			wait(5);
			
		}
	}
}


randomplayer()
{
	trig=getent("trig_parle2", "targetname");

	while(1)
	{
		wait 3;
		trig waittill("trigger",user);

		player=getentarray("player", "classname");
		rnd=randomInt(player.size);


		switch(randomint(12))
{
	case 0:
		iprintlnbold(user.name+ " ^7thinks that "+ player[rnd].name +" ^7 is behind!");
		break;
	case 1:
		iprintlnbold(user.name+ " ^7thinks that "+ player[rnd].name+ " ^7 sucks!");
		break;
	case 2:
		iprintlnbold(user.name+ " ^7realizes that "+ player[rnd].name+ " ^7 never pwns'!");
		break;
	case 3:
		iprintlnbold(user.name+ " ^7must admit "+ player[rnd].name+ " ^7 is way too bad!");
		break;
	case 4:
		iprintlnbold(user.name+ " ^7thinks that "+ player[rnd].name+ " ^7 will never be good'!");
		break;
	case 5:
		iprintlnbold("^7 everybody laughs (v41/v91) at "+player[rnd].name);
		break;
	case 6:
		iprintlnbold(user.name+ " ^7thinks that "+ player[rnd].name+ "^7 has no idea of how to handle a gun");
		break;
	case 7:
		iprintlnbold(user.name+ " ^7 must say that "+ player[rnd].name+ "^7 is lost in such a tough world");
		break;
	case 8:
		iprintlnbold(user.name+ " ^7thinks that "+ player[rnd].name+ "^7 has lost his gun");
		break;
	case 9:
		iprintlnbold(user.name+ " ^7has come to the conclusion that "+ player[rnd].name+ "^7 is harmless");
		break;
	case 10:
		iprintlnbold(user.name+ " ^7thinks that "+ player[rnd].name+ "^7 seriously needs help");
		break;
	case 11:
		iprintlnbold(user.name+ " ^7thinks that "+ player[rnd].name+ "^7 should get skillz");
		break;
}

	}
}
