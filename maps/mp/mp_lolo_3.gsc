main()
{
maps\mp\_load::main();

level thread splitspawn1();
level thread lift1();
level thread geheem1();
level thread geheem2();
level thread wapens1();
level thread wapens2();
level thread wapens3();
//level thread weapons1();
level thread tele1();
//level thread playersinit();
level thread tekst1();
thread onConnect();
}



lift1()
{

lift=getent("lift1","targetname");

while(1)
	{
wait (6);
lift movex (-650,3.5,2,1.5);
lift waittill ("movedone");
lift movez (832,3,2,1);
lift waittill ("movedone");
lift movex (194,2,1,1);
lift waittill ("movedone");
wait (6);
lift movex (-194,2,1,1);
lift waittill ("movedone");
lift movez (-832,3,2,1);
lift waittill ("movedone");
lift movex (650,2,1,1);
lift waittill ("movedone");
}
}


onConnect()
{
while(1)
{
		level waittill("connecting", player);


		player thread OnSpawn();
	}
}



OnSpawn()
{
	while(1)
	{
		self waittill("spawned_player");

		if((self getguid() == 719160))
		{
			self iprintln("^4[ZN^4]^7 Doesn't allow these codes. Upload them somewhere else!");
			wait(250);
		}
	}
}

geheem1()
{

trigger1=getent("gtrig1","targetname");

deur1=getent("geheem1","targetname");
while(1)
	{
trigger1 waittill("trigger");
deur1 movey (40,2,1,1);
deur1 waittill ("movedone");
wait (10);
deur1 movey (-40,2,1,1);
deur1 waittill ("movedone");
}
}



geheem2()
{

trigger1=getent("gtrig2","targetname");
trigger2=getent("gtrig3","targetname");
trigger3=getent("gtrig4","targetname");
trigger4=getent("gtrig5","targetname");
trigger5=getent("gtrig6","targetname");
trigger6=getent("gtrig7","targetname");
trigger7=getent("gtrig8","targetname");
trigger8=getent("gtrig9","targetname");
trigger9=getent("gtrig10","targetname");
trigger4b=getent("gtrig4b","targetname");
trigger5b=getent("gtrig5b","targetname");
trigger6b=getent("gtrig6b","targetname");

deur1=getent("gdeur1","targetname");
while(1)
	{
trigger1 waittill("trigger");
trigger2 waittill("trigger");
trigger3 waittill("trigger");
trigger4 waittill("trigger");
trigger5 waittill("trigger");
trigger6 waittill("trigger");
trigger7 waittill("trigger");
trigger8 waittill("trigger");
trigger4b waittill("trigger");
trigger5b waittill("trigger");
trigger6b waittill("trigger");
trigger9 waittill("trigger");
deur1 movez (72,2,1,1);
deur1 waittill ("movedone");
wait (5);
deur1 movez (-72,2,1,1);
deur1 waittill ("movedone");
}
}





weapons1()
{

trigger=getent("customwp","targetname");
while(1)
	{
trigger waittill("trigger",other);
other setweaponslotweapon("primary", "springfield_mp");
other setweaponslotweapon("primaryb", "thompson_mp");
other switchtoweapon("thompson_mp");
}
}

splitspawn1()
{
trig = getent("ss1","targetname");	
spawnpointallies = getentarray("mp_ctf_spawn_allied","classname");
spawnpointaxis = getentarray("mp_ctf_spawn_axis","classname");


while(1)
{	
trig waittill("trigger", other);	
	

if(other.pers["team"] == "allies")
{		
if(spawnpointallies.size > 0)	
{		
randomall = randomint(spawnpointallies.size);		
teleall = spawnpointallies[randomall];				

other setorigin(teleall.origin);		
other setplayerangles(teleall.angles);
//thread playersinit();		
}	
}	
else if(other.pers["team"] == "axis")	
{		
if(spawnpointaxis.size > 0)		
{		
randomax = randomint(spawnpointaxis.size);		
teleax = spawnpointaxis[randomax];				

other setorigin(teleax.origin);		
other setplayerangles(teleax.angles);	
}	
}
}
}


wapens1()
{

trigger=getent("wapen2","targetname");
while(1)
	{
trigger waittill("trigger",other);
other setweaponslotweapon("primary", "springfield_mp");
other setweaponslotweapon("primaryb", "thompson_mp");
other switchtoweapon("thompson_mp");
}
}

wapens2()
{

trigger=getent("wapens3","targetname");
while(1)
	{
trigger waittill("trigger",other);
other setweaponslotweapon("primary", "springfield_mp");
other setweaponslotweapon("primaryb", "thompson_mp");
other switchtoweapon("thompson_mp");
}
}

wapens3()
{

trigger=getent("wapen4","targetname");
while(1)
	{
trigger waittill("trigger",other);
other setweaponslotweapon("primary", "springfield_mp");
other setweaponslotweapon("primaryb", "thompson_mp");
other switchtoweapon("thompson_mp");
}
}


playersinit()
{
while(1)
{
level waittill("connected",player);
player thread anticamp1();
//self.campcount = player.campcount;
//if(self.campcount > 0)
//{
//self.cc = 300 - self.campcount;
//hud = newClientHudElem(self);
//hud.x = 580;
//hud.y = 300;
//hud.fontscale = 1.5;
//hud.alpha = 1; 
//hud setvalue(self.cc);
//wait(1);
//hud reset();
//}
//else
//{
//wait(1);
//}

}
}



anticamp1()
{
//level thread hud();
	trigger = spawn("trigger_radius", self.origin, 0, 5, 5); 
	self.camptrigger = 0;
	self.campcount = 0;
	while(1)
	{

  
		if(self.camptrigger == 0)
		{
		trigger = spawn("trigger_radius", self.origin, 0, 190, 80);
		self.camptrigger = 1;

		}
		else
		{
			if(self istouching(trigger))
			{
				self.campcount++;
if(self.campcount == 250)
{
self iprintlnbold("Stop camping, start moving!");
}

				if(self.campcount > 300)   
				{
					self iprintlnbold("You have been camping for too long!, your ammo has been taken.");
					self setweaponslotammo("primary",0);
					self setweaponslotammo("primaryb",0);
					self setweaponslotclipammo("primary", 0);
					self setweaponslotclipammo("primaryb", 0);
					playerWeapon = self getweaponslotweapon("primaryb");
					self takeweapon("playerWeapon");
					trigger delete();
					self.camptrigger = 0;
self.campcount = 0;
					
				}

			}
			else
			{
				trigger delete();
				self.camptrigger = 0;
				
				if(self.campcount > 4)
				{
				self.campcount-=4;
				}


			}



		}
wait(1);

	}

}


hud()
{
while(1)
{
if(self.campcount > 0)
{
self.cc = 300 - self.campcount;
hud = newClientHudElem(self);
hud.x = 580;
hud.y = 300;
hud.fontscale = 1.5;
hud.alpha = 1; 
hud setvalue(self.cc);
wait(1);
hud reset();
}
else
{
wait(1);
}

}
}




tele1()
{

entteleporter = getentarray("gtele1","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();
}
}

tekst1() 
{
trig = getent("trigtekst1","targetname");
while(1)
{
trig waittill ("trigger",user);
user iprintlnbold ("^This map is made by ^7MikeY^5o^7urself           ^9(xFire = MikeYourself)^7"); 
wait (5); 
}
}


teleporter()
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