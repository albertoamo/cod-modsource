/*
  Basicaly done this map because i needed some stupid map for 
my mod and i thought was good to have some map made by myself,as you will see this map contains some prefabs by other people,idk who did them ,if u read this and u know who did those prefabs pls contact with me via xfire(punishman1993)Have fun!!
*/

main()
{
	maps\mp\_load::main();
	level thread Boat();
	level thread SecretDoor();
	level thread KillJail();
	level thread OpenJail();
	level thread maps\mp\mp_znhq_teleporters::main();
	level thread Fxspawn();
	level thread SiloFix1();
	level thread SiloFix2();
	level thread GlitchFix1();

	game["allies"] = "american";
	game["axis"] = "german";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["russian_soldiertype"] = "normandy";
	game["german_soldiertype"] = "normandy";

	game["boat"]["splash1"] = loadfx("fx/misc/boat_enginespray_higgins.efx");
	game["fire"]["jail"] = loadfx("fx/misc/jailfire.efx");
	level._effect["water_pipe"] = loadfx("fx/misc/water_pipe.efx");
	game["boat"]["splash2"] = loadfx("fx/misc/boat_splash_small_buffalo.efx");
}

GlitchFix1()
{
	volume = [];
	volume[0] = -2099; // min (x)
	volume[1] = 2806; // min (y)
	volume[2] = 320; // min  (z)
	volume[3] = -2067; // max  (x)
	volume[4] = 2875; // max  (y)
	volume[5] = 350; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(!isDefined(player.isglitchchecking))		
			player thread GlitchFixTest(trigger);

		wait(0.05);
	}
}

GlitchFixTest(trigger)
{
	self endon("disconnect");

	self.isglitchchecking = true;

	wait(5);

	if(self sim\_sf_triggers::isTouchingTrigger(trigger) && isAlive(self))
		self SetOrigin((-223,3347,332));

	self.isglitchchecking = undefined;
}

SiloFix1()
{
	volume = [];
	volume[0] = -1756; // min (x)
	volume[1] = 1501; // min (y)
	volume[2] = 192; // min  (z)
	volume[3] = -1696; // max  (x)
	volume[4] = 1551; // max  (y)
	volume[5] = 300; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player SetOrigin((-223,3347,332));
	}
}

SiloFix2()
{
	volume = [];
	volume[0] = -1912; // min (x)
	volume[1] = 1501; // min (y)
	volume[2] = 192; // min  (z)
	volume[3] = -1848; // max  (x)
	volume[4] = 1551; // max  (y)
	volume[5] = 300; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player SetOrigin((-223,3347,332));
	}
}

addSpawn() // doesnt work
{
	spawnpoint = Spawn( "mp_tdm_spawn", (-114,4225,464) );
	spawnpoint.angles = (0,270,0);
	spawnpoint PlaceSpawnPoint();
}

Fxspawn()
{
//Pipe water
maps\mp\_fx::loopfx("water_pipe", (1272,3800,304), 0.5);
}


Boat()//Nuub script,yeah,did it fast...No time to waste in this..
{

   boat=getent("boat","targetname");
   point1=getent("point1","targetname");
   point2=getent("point2","targetname");
   point3=getent("point3","targetname");
   point4=getent("point4","targetname");
   point5=getent("point5","targetname");
   point6=getent("point6","targetname");
   point7=getent("point7","targetname");
   p2=(-960,2760,0);
   pointstart=getent("pointstart","targetname");
   pointbt1=getent("pointbt1","targetname");
   trig_boat=getent("trig_boat","targetname");
   waitime = 4;

   while(1)//loop...
   {

      trig_boat waittill ("trigger");
      boat playsound("ship_sinking1");
      boat moveto (point1.origin,4);
      boat waittill ("movedone");
      boat rotateyaw (90,3);
      boat moveto (point2.origin,3);
      boat waittill ("movedone");
      wait 3;
      boat moveto(p2,2);
      boat waittill ("movedone");
      boat rotateyaw (-90,4);
      boat moveto (pointbt1.origin,4);
      boat waittill ("movedone");
      boat rotateyaw (-75,4);
      boat moveto (point3.origin,4);
      boat waittill ("movedone");
      boat rotateyaw (-15,4);
      boat moveto (point4.origin,4);
      boat waittill ("movedone");

      wait waitime;

      boat playsound("ship_sinking1");
      boat rotateyaw (-90,4);
      boat moveto (point5.origin,4);
      boat waittill ("movedone");
      boat rotateyaw (-90,4);
      boat moveto (point6.origin,4);
      boat waittill ("movedone");
      boat rotateyaw (-90,6);
      boat moveto (point7.origin,6);
      boat waittill ("movedone");
      boat moveto (pointstart.origin,9);
      boat waittill ("movedone");

      }

}

SecretDoor()//When i make those scripts i feel noob...lol
{
   door=getent("door1","targetname");
   trig_door1=getent("trig_door1","targetname");
   trig_door2=getent("trig_door2","targetname");
   waitdoor = 10;

   while(1)//loop...
   {

      trig_door1 waittill ("trigger",basher);
      trig_door2 waittill ("trigger",basher);
      door rotateyaw(89,1);
      door playsound("shutter_move");
      basher iprintlnbold("^1You found the secret!!!");
      basher iprintlnbold("^1You have 10 secs!!!");
      iprintln(basher.name + " ^1Found the secret!!!");
      wait waitdoor;
      door rotateyaw(-89,1);
      door playsound("shutter_move");

      }

}

KillJail()
{
   trig_killjail=getent("trig_killjail","targetname");
   trig_jailldead=getent("trig_jailldead","targetname");
   trig_jailldead thread maps\mp\_utility::triggerOff();
   waitkill = 1;
   waitnew = 2;
   waitdelay = 0.3;
   fxpos1 = (-288,3344,312);
   fxpos2 = (-160,3344,312);

   while(1)//loop...
   {

      trig_killjail waittill ("trigger",killer);
      killer iprintlnbold("^1Burning!!!");
      wait waitkill;
      PlayFX( game["fire"]["jail"],fxpos1 ); 
      PlayFX( game["fire"]["jail"],fxpos2 ); 
      trig_jailldead playsound("elm_pipe_stress");
      wait waitdelay;
      PlayFX( game["fire"]["jail"],fxpos1 ); 
      PlayFX( game["fire"]["jail"],fxpos2 ); 
      trig_jailldead thread maps\mp\_utility::triggerOn();
      trig_jailldead playloopsound("bigfire");
      trig_jailldead playsound("elm_industry,5");
      wait waitnew;
      trig_jailldead thread maps\mp\_utility::triggerOff();
      trig_jailldead stoploopsound();
      
      }
}
      
OpenJail()
{
   trig_savejail=getent("trig_savejail","targetname");
   doorjail1=getent("jaildoor1","targetname");
   doorjail2=getent("jaildoor2","targetname");
   waitopen = 6;

   while(1)//loop...
   {

      trig_savejail waittill ("trigger",saver);
      doorjail1 playsound("shutter_move");
      doorjail1 rotateyaw(60,1);
      doorjail2 rotateyaw(-60,1);
      wait waitopen;
      doorjail1 rotateyaw(-60,1);
      doorjail2 rotateyaw(60,1);
      doorjail1 playsound("shutter_move");
      doorjail2 waittill ("rotatedone");
      
      }
}



