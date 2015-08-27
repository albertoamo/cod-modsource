main()
{
	level._effect["lantern_light"] = loadfx("fx/props/glow_latern.efx");
	maps\mp\_load::main();
	maps\mp\mp_zn_jungle_mortar::main();
	maps\mp\mp_zn_jungle_security::main();

	setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
	setCullFog(0, 10000, 0.55, 0.6, 0.55, 0);
	//ambientPlay("ambient_france");

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["american_soldiertype"] = "winterlight";
	game["german_soldiertype"] = "winterlight";

	setCvar("r_glowbloomintensity0", ".25");
	setCvar("r_glowbloomintensity1", ".25");
	setcvar("r_glowskybleedintensity0",".3");

	thread SecretDoorStart();
	thread ProtectionWall();
	thread ProtectionSecret();
	thread BlowUpTheWall();
	thread MineLift();
	thread JumpHelper();
	thread TrainCheck();
	thread TowerJump();
	thread StartPoint();
	thread Radio();
	thread OnConnect();
}

Radio()
{
	radio = getent("startradio1", "targetname");

	while(1)
	{
		radio playsound("zn_jungle_radio");
		wait(200); 
	}
}

OnConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player thread onMenu();
	}

}

onMenu()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("menuresponse", menu, response);

		if(response == "specialspawn" && menu == "ingame")
		{
			spawnpointname = "mp_ze_specialspawn";
			spawnpoints = getentarray(spawnpointname, "classname");
			spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);
      			self setorigin(spawnpoint.origin);
			self setplayerangles(spawnpoint.angles);
		}
	}
}

StartPoint()
{
	door = getent("start_door", "targetname");
	trig = getent("barrel_trig", "targetname");
	barrel_1 = getent("barrel_1", "targetname");
	barrel_2 = getent("barrel_2", "targetname");
	barrel_3 = getent("barrel_3", "targetname");
 	barrel_4 = getent("barrel_4", "targetname");
	clip = getent("barrel_clip", "targetname");

	origin1 = barrel_1 GetOrigin();
	origin2 = barrel_2 GetOrigin();
	origin3 = barrel_3 GetOrigin();
	origin4 = barrel_4 GetOrigin();

	while(1)
	{
		trig waittill("damage", dmg, user);

		if(dmg > 30)
		{
			playfx(game["Effect"]["barrel_explosion"], origin1);
			playfx(game["Effect"]["barrel_explosion"], origin2);
			playfx(game["Effect"]["barrel_explosion"], origin3);
			playfx(game["Effect"]["barrel_explosion"], origin4);
			
			barrel_1 hide();
			barrel_2 hide();
			barrel_3 hide();
			barrel_4 hide();

			barrel_1 notsolid();
			barrel_2 notsolid();
			barrel_3 notsolid();
			barrel_4 notsolid();
			clip notsolid();
			door hide();
			door notsolid();

			radiusDamage(origin1, 200, 70, 10);
			radiusDamage(origin2, 200, 70, 10); 
			radiusDamage(origin3, 200, 70, 10);
			radiusDamage(origin4, 200, 70, 10);

			self thread maps\mp\mp_zn_jungle_mortar::playSoundAtLocation("explo_metal_rand", origin1, .1 );
			self thread maps\mp\mp_zn_jungle_mortar::playSoundAtLocation("explo_metal_rand", origin2, .1 );
			self thread maps\mp\mp_zn_jungle_mortar::playSoundAtLocation("explo_metal_rand", origin3, .1 );
			self thread maps\mp\mp_zn_jungle_mortar::playSoundAtLocation("explo_metal_rand", origin4, .1 );
	
			earthquake(0.3, 3, origin1, 400);
			earthquake(0.3, 3, origin2, 400);
			earthquake(0.3, 3, origin3, 400);
			earthquake(0.3, 3, origin4, 400);
			break;
		}
	}
}

TowerJump()
{
	trig = getent("jump_trig", "targetname");

	while(1)
	{
		trig waittill("trigger", user);

		user setorigin( (9416,-4576,-528) );
		user setplayerangles( (0,180,0) );
	}
}

TrainCheck()
{
	trig = getentarray("train_trig","targetname");
	level.trainismoving = false;

	traindoor = getent("traindoor","targetname");
	traindoor2 = getent("traindoor2","targetname");

	traindoor moveX(-7, 0.1);
	traindoor waittill("movedone");

	traindoor moveY(-87, 0.1);
	traindoor waittill("movedone");

	traindoor2 moveY(96, 0.1);
	traindoor2 waittill("movedone");

	for(x=0;x<trig.size;x++)
		trig[x] thread Train_trig();

}

Train_trig()
{
	while(1)
	{
		self waittill("trigger");

		if(!level.trainismoving)
		{
			level.trainismoving = true;
			thread Train_move();
		}
	
	}
}

Train_move()
{
	train = getent("train","targetname");
	traindoor = getent("traindoor","targetname");
	traindoor2 = getent("traindoor2","targetname");

	traindoor moveY(87, 3);
	traindoor waittill("movedone");

	traindoor moveX(7, 1);
	traindoor waittill("movedone");

	traindoor2 moveY(-96, 1);
	traindoor2 waittill("movedone");

	traindoor2 linkto(train);
	traindoor linkto(train);

	train MoveY(-6300, 30);
	train waittill("movedone");

	wait(1);

	traindoor2 unlink();
	traindoor unlink();

	traindoor moveX(-7, 1);
	traindoor waittill("movedone");

	traindoor moveY(-87, 3);
	traindoor waittill("movedone");

	traindoor2 moveY(96, 1);
	traindoor2 waittill("movedone");


	wait(5);


	traindoor moveY(87, 3);
	traindoor waittill("movedone");

	traindoor moveX(7, 1);
	traindoor waittill("movedone");

	traindoor2 moveY(-96, 1);
	traindoor2 waittill("movedone");

	traindoor2 linkto(train);
	traindoor linkto(train);

	train MoveY(6300, 30);
	train waittill("movedone");

	wait(1);

	traindoor2 unlink();
	traindoor unlink();

	traindoor moveX(-7, 1);
	traindoor waittill("movedone");

	traindoor moveY(-87, 3);
	traindoor waittill("movedone");

	traindoor2 moveY(96, 1);
	traindoor2 waittill("movedone");

	wait(5);

	level.trainismoving = false;
}

JumpHelper()
{
	object = getent("danger_moveobject", "targetname");
	trig = getent("danger_moveobject_trig", "targetname");

	while(1)
	{
		trig waittill("trigger", user);

		object MoveY(284, 2);
		object waittill("movedone");

		wait(1.1);

		object MoveY(-284, 2);
		object waittill("movedone");

		wait(1.1);
	}
}

MineLift()
{
	lift = getent("minelift", "targetname");
	trig = getent("minelift_trig", "targetname");

	while(1)
	{
		trig waittill("trigger", user);
		
		lift MoveZ(-2194, 10);
		lift waittill("movedone");

		wait(5);

		lift MoveZ(2194, 10);
		lift waittill("movedone");
	}
}

BlowUpTheWall()
{
	trig = getent("secret", "targetname");
	wall = getent("dooropening", "targetname");
	tnt = getent("secret_bomb", "targetname");

	origin = (-1677,-7143,39);

	trig waittill("trigger", user);

	tnt playLoopSound("bomb_tick");

	wait(5);

	tnt stopLoopSound();

	tnt hide();
	playfx(game["Effect"]["tnt"], origin);

	radiusDamage( origin + (7,0,5), 300, 200, 10);
	self thread maps\mp\mp_zn_jungle_mortar::playSoundAtLocation("building_explosion2", origin, .1 );
	
	earthquake(0.3, 3, origin, 600);
	
	wall hide();
	wall notsolid();
	trig hide();
	trig delete();
}

ProtectionSecret()
{
	trig = getent("trig_block", "targetname");
	object = getent("blocksroom", "targetname");

	while(1)
	{
		trig waittill ("damage", dmg, user);
		if(dmg > 90)
		{
			object MoveZ(100, 3);
			object waittill("movedone");
			
			wait(1.1);

			object MoveZ(-100, 3);
			object waittill("movedone");
		}
	}

}

ProtectionWall()
{
	wall = getent("protectionwall", "targetname");
	trig = getent("trig_blockroom2", "targetname");

	wall hide();
	wall notsolid();

	while(1)
	{
		trig waittill ("damage", dmg, user);
		if(dmg > 90)
		{
			wall show();
			wall solid();

			wait(25);

			wall hide();
			wall notsolid();

			wait(10);
		}
	}

}

SecretDoorStart()
{	
	trig = getentarray("door_trig","targetname");
	level.openingsecretdoor = false;

	for(x=0;x<trig.size;x++)
		trig[x] thread SecretDoor_trig();
}

SecretDoor_trig()
{
	while(1)
	{

		self waittill("trigger", user);

		if(!level.openingsecretdoor)
		{
			level.openingsecretdoor = true;
			thread OpenSecretDoor();
		}

	}
}
	
OpenSecretDoor()
{
	door1 = getent("door1","targetname");
	door2 = getent("door2","targetname");
	part1 = getent("door_p1","targetname");
	part2 = getent("door_p2","targetname");
	part3 = getent("door_p3","targetname");


	wait 1.2;

	part1 thread rotatepart();
	part2 thread rotatepart();
	part3 rotatepart();

	wait 0.7;

	part3 movey(20, 2);
	part3 waittill("movedone");

	wait 0.3;

	part1 linkto(door2);
	part3 linkto(door2);
	part2 linkto(door1);
		
	door1 thread movepart( -90 );
	door2 movepart( 90 );

	wait 25;

	door1 thread movepart( 90 );
	door2 movepart( -90 );

	part1 unlink();
	part3 unlink();
	part2 unlink();

	wait 0.6;

	part3 movey(-20, 2);
	part3 waittill("movedone");

	wait 1.2;

	part1 thread rotatepart( 90 );
	part2 thread rotatepart( 90 );
	part3 rotatepart( 90 );

	wait 5;
	level.openingsecretdoor = false;
}

rotatepart( x )
{
	if(!isDefined(x)) x = -90;
	
	self rotateroll(x, 2.2);
	self waittill("rotatedone");
}

movepart( x )
{
	if(!isDefined(x)) x = 90;

	self movey(x, 3);
	self waittill("movedone");
}