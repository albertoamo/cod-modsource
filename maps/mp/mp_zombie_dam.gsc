
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
level thread maps\mp\mp_zombie_dam_teleporters::main();
level thread maps\mp\mp_zombie_dam_damage_control::main();
level thread rail_shuttleBack();
level thread boat_slide1Back();
level thread boat_slide2Back();
level thread ladderTower1(35);
level thread ladderTower2(35);
level thread ladderTower3(35);
level thread ladderTower4(35);
level thread teleport();

level.elevatorDown = true;
level.elevatorMoving = false;
level.elevatorDown2 = true;
level.elevatorMoving2 = false;

precacheShellShock("default_mp");
precacheModel("xmodel/prop_doghouse1");
precacheShader( "gfx/icons/hint_usable" );
}

teleport()
{
	model = spawn("script_model", (803, 410, 720));
	model.angles = (0, 50, 0);
	model setModel("xmodel/prop_doghouse1");

	trigger = spawn("trigger_radius", (797, 407, 720), 0, 7, 10);
	
	while(1)
	{
		trigger waittill("trigger", player);

		player thread showButton(trigger);

		if(player UseButtonPressed())
		{
			player setOrigin((1032, 3203, 8.125));
			player setPlayerAngles((0, 95, 0));
		}
		
		wait(0.05);
	}
}

showButton(trigger)
{
	if(isDefined(self.dogboxtext))
		return;

	if(!isdefined(self.dogboxtext))
	{
		self.dogboxtext = newClientHudElem(self);
		self.dogboxtext.x = 0;

		if(level.splitscreen)
			self.dogboxtext.y = 70;
		else
			self.dogboxtext.y = 104;

		self.dogboxtext.alignX = "center";
		self.dogboxtext.alignY = "middle";
		self.dogboxtext.horzAlign = "center_safearea";
		self.dogboxtext.vertAlign = "center_safearea";
		self.dogboxtext.alpha = 1;
	}


	self.dogboxtext SetShader( "gfx/icons/hint_usable", 30, 30 );

	while(isDefined(trigger) && isDefined(self) && self isTouching(trigger) && isAlive(self))
		wait(0.05);

	self.dogboxtext Destroy();
}

ladderTower1(dmg)
{
	volume = [];
	volume[0] = 489; // min (x)
	volume[1] = 2778; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = 605; // max  (x)
	volume[4] = 2792; // max  (y)
	volume[5] = 388; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "axis" && !isDefined(player.laddertowerdmg))
		{
			player.laddertowerdmg = true;
			player thread ladderTowerDmg(dmg);
		}

		wait(0.05);	
	}
}

ladderTowerDmg(dmg)
{
	self.health += dmg;
	angles = VectorToAngles( (self.origin[0], self.origin[1], 450) - self.origin );
	self FinishPlayerDamage( self, self, dmg, 1, "MOD_EXPLOSIVE", "none", self.origin, AnglesToForward(angles), "none", 0 );
	self.laddertowerdmg = undefined;
}

ladderTower2(dmg)
{
	volume = [];
	volume[0] = 489; // min (x)
	volume[1] = 3736; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = 605; // max  (x)
	volume[4] = 3750; // max  (y)
	volume[5] = 388; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "axis" && !isDefined(player.laddertowerdmg))
		{
			player.laddertowerdmg = true;
			player thread ladderTowerDmg(dmg);
		}

		wait(0.05);	
	}
}

ladderTower3(dmg)
{
	volume = [];
	volume[0] = 1706; // min (x)
	volume[1] = 3736; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = 1822; // max  (x)
	volume[4] = 3750; // max  (y)
	volume[5] = 388; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "axis" && !isDefined(player.laddertowerdmg))
		{
			player.laddertowerdmg = true;
			player thread ladderTowerDmg(dmg);
		}

		wait(0.05);	
	}
}

ladderTower4(dmg)
{
	volume = [];
	volume[0] = 1696; // min (x)
	volume[1] = 2778; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = 1814; // max  (x)
	volume[4] = 2792; // max  (y)
	volume[5] = 388; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(player.pers["team"] == "axis" && !isDefined(player.laddertowerdmg))
		{
			player.laddertowerdmg = true;
			player thread ladderTowerDmg(dmg);
		}

		wait(0.05);	
	}
}

rail_shuttleBack()
{
	volume = [];
	volume[0] = 2199; // min (x)
	volume[1] = 4759; // min (y)
	volume[2] = 192; // min  (z)
	volume[3] = 2408; // max  (x)
	volume[4] = 5042; // max  (y)
	volume[5] = 232; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(!isDefined(level.railshuttleismoving))
			rail_shuttle_move();
		else
			wait(0.05);
	}
}

boat_slide1Back()
{
	volume = [];
	volume[0] = -272; // min (x)
	volume[1] = 2626; // min (y)
	volume[2] = -103; // min  (z)
	volume[3] = -533; // max  (x)
	volume[4] = 2939; // max  (y)
	volume[5] = -63; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(!isDefined(level.boatslide1ismoving))
			boat_slide1_move();
		else
			wait(0.05);
	}
}

boat_slide2Back()
{
	volume = [];
	volume[0] = -810; // min (x)
	volume[1] = 2647; // min (y)
	volume[2] = -103; // min  (z)
	volume[3] = -565; // max  (x)
	volume[4] = 2948; // max  (y)
	volume[5] = -63; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(!isDefined(level.boatslide2ismoving))
			boat_slide2_move();
		else
			wait(0.05);
	}
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
jail_trap1 rotatepitch(-90, 0.8, 0.5, 0.2);
jail_trap2 rotatepitch(90, 0.8, 0.5, 0.2);
jail_trap2 waittill("rotatedone");
wait(4);
jail_trap1 rotatepitch(90, 2.1, 1.2, 0.8);
jail_trap2 rotatepitch(-90, 2.1, 1.2, 0.8);
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
boat_move waittill("movedone");

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
speed = 8; 
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
speed2 = 8; 
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
	trig_shuttle=getent("trig_shuttle","targetname");

	while(1)
	{
		trig_shuttle waittill ("trigger");

		if(!isDefined(level.railshuttleismoving))
			rail_shuttle_move();
		else
			wait(0.05);
	} 
}

rail_shuttle_move()
{
	level.railshuttleismoving = true;

	rail_shuttle=getent("rail_shuttle","targetname");
	wait(1);

	rail_shuttle movey (3978,10,1.9,1.9);
	rail_shuttle waittill ("movedone");

	wait(5);

	rail_shuttle movey (-3978,10,1.9,5);
	rail_shuttle waittill ("movedone");

	level.railshuttleismoving = undefined;
}

island_bridge()
{
	bridge_back=getent("bridge_back","targetname");
	bridge_front=getent("bridge_front","targetname");
	trig_bridge=getent("trig_bridge","targetname");
	bridge_back rotateroll(50, 1.5, 0.7, 0.7);
	bridge_front rotateroll(-50, 1.5, 0.7, 0.7);

	bridge_back.ismoving = false;
	bridge_front.ismoving = false;

	while(1)
	{
		trig_bridge waittill ("trigger");
		wait(1);

		bridge_back thread BridgeRoll(-50);
		bridge_front BridgeRoll(50);

		while(bridge_back.ismoving || bridge_front.ismoving)
			wait(0.05);

		wait(12);

		bridge_back thread BridgeRoll(50);
		bridge_front BridgeRoll(-50);

		while(bridge_back.ismoving || bridge_front.ismoving)
			wait(0.05);
	} 
}

BridgeRoll(amount)
{
	self.ismoving = true;
	self rotateroll(amount, 5, 0.7, 0.7);
	self waittill("rotatedone");
	self.ismoving = false;
}

boat_slide1()
{
	trig_boat_slide1=getent("trig_boat_slide1","targetname");

	while(1)
	{
		trig_boat_slide1 waittill ("trigger");
		
		if(!isDefined(level.boatslide1ismoving))
			boat_slide1_move();
		else
			wait(0.05);
	} 
}

boat_slide1_move()
{
	level.boatslide1ismoving = true;

	boat_slide1=getent("boat_slide1","targetname");

	wait(1);

	boat_slide1 movey (1920,8,1.9,1.9);
	boat_slide1 waittill ("movedone");

	wait(5);

	boat_slide1 movey (-1920,8,1.9,1.9);
	boat_slide1 waittill ("movedone");

	level.boatslide1ismoving = undefined;
}

boat_slide2()
{
	trig_boat_slide2=getent("trig_boat_slide2","targetname");

	while(1)
	{
		trig_boat_slide2 waittill ("trigger");

		if(!isDefined(level.boatslide2ismoving))
			boat_slide2_move();
		else
			wait(0.05);
	} 
}

boat_slide2_move()
{
	level.boatslide2ismoving = true;

	boat_slide2=getent("boat_slide2","targetname");

	wait(1);

	boat_slide2 movey (1920,8,1.9,1.9);
	boat_slide2 waittill ("movedone");

	wait(5);

	boat_slide2 movey (-1920,8,1.9,1.9);
	boat_slide2 waittill ("movedone");

	level.boatslide2ismoving = undefined;
}