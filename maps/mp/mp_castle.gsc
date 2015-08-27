main()
{
maps\mp\_load::main();
thread elevator();
thread poort2();
thread schuifdeur();
thread camper();
thread naamsecret();
thread naamsecret1();
thread ring();
thread _tele1();
thread luik();
thread jail();
thread platform();
thread lift();
thread naamsecret2();
thread naamsecret3();
thread drie();


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
setcvar("r_glowskybleedintensity0",".3");

}

elevator()
{
elevator = getent ("elevator","targetname");
trigger = getent ("elevator_trig","targetname");
while(1)
{
trigger waittill ("trigger",user);
wait(2);
elevator moveZ (160,6,3,3);
elevator waittill ("movedone");
wait(60);
elevator moveZ (-160,6,3,3);
elevator waittill ("movedone");
wait(5);
}
}

poort2()
{
poort2 = getent ("poort2","targetname");
trigger = getent ("poort2_trig","targetname");
while(1)
{
trigger waittill ("trigger",user);
wait(2);
poort2 moveZ (160,6,3,3);
poort2 waittill ("movedone");
wait(60);
poort2 moveZ (-160,6,3,3);
poort2 waittill ("movedone");
wait(5);
}
}

schuifdeur()
{
schuifdeur1 = getent ("schuifdeur1", "targetname");
schuifdeur2 = getent ("schuifdeur2", "targetname");
schuifdeur3 = getent ("schuifdeur3", "targetname");
schuifdeur4 = getent ("schuifdeur4", "targetname");
trig = getent ("trigger", "targetname"); 

while(1)
{
trig waittill ("trigger");

schuifdeur1 movex (-300, 7);
schuifdeur2 movex (300, 7);
schuifdeur1 waittill ("movedone");
schuifdeur3 movez (150, 7);
schuifdeur4 movez (-150, 7);
schuifdeur3 waittill ("movedone");



wait(60);

schuifdeur1 movex (300, 7);
schuifdeur2 movex (-300, 7);
schuifdeur2 waittill ("movedone");
schuifdeur3 movez (-150, 7);
schuifdeur4 movez (150, 7);
schuifdeur4 waittill ("movedone");
wait (5);

}
}

camper()
{
camper1 = getent ("camper1", "targetname");
camper2 = getent ("camper2", "targetname");
trig = getent ("camper_trig", "targetname"); 

while(1)
{
trig waittill ("trigger",user);
wait(5);
camper1 movez (110, 5);
camper1 waittill ("movedone");
camper2 movez (-10, 4);
camper2 waittill ("movedone");
camper2 movey (-550, 6);
camper2 waittill ("movedone");


wait(3);

camper2 movey (550, 6);
camper2 waittill ("movedone");
camper2 movez (10, 4);
camper2 waittill ("movedone");
camper1 movez (-110, 5);
camper1 waittill ("movedone");

wait(5);


}
}

naamsecret()
{
naamsecret = getent("naamsecret","targetname");
trig = getent("naamsecret_trig","targetname");

while(true)
{
trig waittill("trigger", user);

if ((user.name == "Fristi") || isDefined(user.iscadmin) || IsSubStr(user.name,"ZN"))
{
naamsecret notsolid();
}
else
{
naamsecret solid();
}
}
}

naamsecret1()
{
naamsecret1 = getent("naamsecret1","targetname");
trig = getent("naamsecret1_trig","targetname");

while(true)
{
trig waittill("trigger", user);

if ((user.name == "Fristi") || (user.name == "I love Fristi") || isDefined(user.iscadmin) || IsSubStr(user.name,"ZN"))
{
naamsecret1 notsolid();
}
else
{
naamsecret1 solid();
}
}
}

ring()
{
	plat = getent("ring","targetname");
	trig = getent("bash_trig","targetname");

	while (1) 
		{ 
			trig waittill ("trigger",user);
                        plat notsolid();
                        user iprintln("You found a secret!");
			wait 10;
			plat solid();
		}
}


_tele1()
{

	entteleporter = getentarray("_teleporter","targetname");
	if(isdefined(entteleporter))
	{
		for(lp=0;lp<entteleporter.size;lp++)entteleporter[lp] thread teleportert();

	}
}
teleportert()
{
	while(true)
	{
		self waittill("trigger",other);
		entTarget = getent(self.target, "targetname");

		wait(0.10);
		other setorigin(entTarget.origin);
		other setplayerangles(entTarget.angles);
		wait(0.10);
	}
}

luik()
{
luik = getent ("luik", "targetname");
luik1 = getent ("luik1", "targetname");
trig = getent ("luiktrigger", "targetname"); 

while(1)
{
trig waittill ("trigger");

luik rotateyaw (-90,10);
luik1 rotateyaw (90,10);
luik1 waittill ("rotatedone");

wait 10;

luik rotateyaw (90,10);
luik1 rotateyaw (-90,10);
luik waittill ("rotatedone");


}
}

jail()
{
jail = getent ("jail","targetname");
trigger = getent ("jail_trig","targetname");
while(1)
{
trigger waittill ("trigger",user);
wait(1);
jail moveZ (180,6,3,3);
jail waittill ("movedone");
wait(5);
jail moveZ (-180,6,3,3);
jail waittill ("movedone");
wait(4);
}
}

platform()
{
	platform = getent ("platform","targetname");
	platform1 = getent ("platform1","targetname");
	trigger = getent ("platform_trig","targetname");

	volume = [];
	volume[0] = 143; // min (x)
	volume[1] = 400; // min (y)
	volume[2] = -1340; // min  (z)
	volume[3] = 300; // max  (x)
	volume[4] = 429; // max  (y)
	volume[5] = -1260; // max  (z)

	volume2 = [];
	volume2[0] = 137; // min (x)
	volume2[1] = 263; // min (y)
	volume2[2] = -1400; // min  (z)
	volume2[3] = 314; // max  (x)
	volume2[4] = 428; // max  (y)
	volume2[5] = -1320; // max  (z)

	prevent = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	prevent._color = (1,0,0);

	prevent2 = sim\_sf_triggers::spawnTrigger(  volume2, "multiple");
	prevent2._color = (1,0,0);

	ents = getentarray("trigger_hurt", "classname");
	ents[1] delete(); // under lift
	ents[4] delete(); // under lift back
	ents[7] delete(); // beam at exit

	while(1)
	{
		trigger waittill ("trigger",user);

		wait(2);
		platform thread platform_move("Z", -1365, 10, 3, 3);
		wait(3);
		platform1 thread platform_move("X", -190, 1.5, 0, 0);
		wait(7);

		prevent2 thread platform_hurt("platform_down");

		while(isDefined(platform.ismoving) || isDefined(platform1.ismoving))
			wait(0.05);

		prevent2 notify("platform_down");

		wait(10);

		platform thread platform_move("Z", 1365, 10, 3, 3);
		wait(3);
		prevent thread platform_hurt("platform_up");
		wait(3);
		platform1 thread platform_move("X", 190, 1.5, 0, 0);
		wait(4);

		while(isDefined(platform.ismoving) || isDefined(platform1.ismoving))
			wait(0.05);

		prevent notify("platform_up");
	}
}

platform_move(dir, dist, time, fast, slow)
{
	self.ismoving = true;

	if(dir == "Z")
		self moveZ(dist, time, fast, slow);
	else
		self moveX(dist, time, fast, slow);

	self waittill("movedone");

	self.ismoving = undefined;	
}

platform_hurt(notifystring)
{
	self endon(notifystring);

	while(1)
	{
		self waittill("trigger", player);

		player thread [[level.callbackPlayerDamage]](player, player, 5, 1, "MOD_SUICIDE", "none", player.origin, (0,0,0), "none",0);

		wait(0.05);
	}
}

lift()
{
lift = getent ("lift","targetname");
trigger = getent ("lift_trig","targetname");
while(1)
{
trigger waittill ("trigger",user);
wait(1);
lift moveZ (274,6,3,3);
lift waittill ("movedone");
wait(5);
lift moveZ (-274,6,3,3);
lift waittill ("movedone");
wait(4);
}
}

naamsecret2()
{
naamsecret2 = getent("naamsecret2","targetname");
trig = getent("naamsecret2_trig","targetname");

while(true)
{
trig waittill("trigger", user);

if (isDefined(user.iscadmin))
{
naamsecret2 notsolid();
}
else
{
naamsecret2 solid();
}
}
}


naamsecret3()
{
naamsecret3 = getent("naamsecret3","targetname");
trig = getent("naamsecret3_trig","targetname");

while(true)
{
trig waittill("trigger", user);

if (isDefined(user.isradmin))
{
naamsecret3 notsolid();
}
else
{
naamsecret3 solid();
}
}
}

drie()
{
	blok = getent ("drie", "targetname");
	t1 = getent ("trig_drie1", "targetname");
	t2 = getent ("trig_drie2", "targetname");
	t3 = getent ("trig_drie3", "targetname");
	
	blok solid();
	
	while(1)
	{
		t1 waittill ("trigger", user);
		if(isPlayer(user) && isDefined(user) && isDefined(user.debugmode) && user.debugmode) user iprintln("1");
		t2 waittill ("trigger", user);
		if(isPlayer(user) && isDefined(user) && isDefined(user.debugmode) && user.debugmode) user iprintln("2");
		t3 waittill ("trigger", user);
		if(isPlayer(user) && isDefined(user) && isDefined(user.debugmode) && user.debugmode) user iprintln("3");
		
		blok notsolid();
		
		wait 3;
		
		blok solid();
	}
}











