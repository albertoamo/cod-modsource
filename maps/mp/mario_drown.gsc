// Multiplayer drown script for CoD
//
// 	written by [D]delica
// 	based on _noprone.gsc by r0ger and the stock IW S&D scripts ;)
//	Modifed by Spikenaylor for COD2 using the tintscreen script from

//[Nip] Drowning Water Script v1
//[Nip] by BionicNipple (bionic.nipple@gmail.com)


//	To use this script, you'll need two trigger_multiples, set up pretty much the same 
//	way as r0gers' _noprone script. One should fill the area where you have water, so as 
//	long as the player is in the water they will be in contact with it. Open entity 
//	properties and give it the targetname 'drown'. Create another trigger_multiple above it, 
//      and connect it to the 'drown' trig as a target. (select 'drown' trig, then the target trig,
//	and press W.) The base of this trigger should be at the same level as the surface of 
//	your water, or a little above, depending on how soon you want people to start drowning.
//	This is all you need to do in radiant. Save, close and compile. 
//
//	In your yourmap.gsc, call _drown with "maps\mp\_drown::main();" (no quotes ;) ), and make 
//	sure you place _drown.gsc in the maps/mp folder of your iwd. For compatibility's sake, 
//	please rename _drown.gsc if you use it (viz "mp_mymapname_drown.gsc", so ppl can customise
//	it to their taste without creating problems with other mods/maps ;).
//
//	N.B: the sounds and fx used in this script are all custom. If you want the same sounds,
//	I suggest you rip them from Hamlet.pk3. Ditto the fx ^_^
//
//	delicauk@gmail.com

main()
{
	precacheShader("black");
	precacheShader("white");

	level.waterbarsize = 288;
	level.drowntime = 16;
	level.waterhurttime = 12;

	thread spawnTrigger();
}

spawnTrigger()
{
	volume = [];
	volume[0] = 65; // min (x)
	volume[1] = 607; // min (y)
	volume[2] = -145; // min  (z)
	volume[3] = 920; // max  (x)
	volume[4] = 870; // max  (y)
	volume[5] = -85; // max  (z)

	volume2 = [];
	volume2[0] = 65; // min (x)
	volume2[1] = 607; // min (y)
	volume2[2] = -85; // min  (z)
	volume2[3] = 920; // max  (x)
	volume2[4] = 870; // max  (y)
	volume2[5] = 0; // max  (z)

	dceiling = sim\_sf_triggers::spawnTrigger(  volume2, "multiple");

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);
	trigger thread Water(dceiling);
}

Water(dceiling)
{
	level endon("intermission");

	while (1)
	{
		self waittill("trigger", other);

		//other iprintln("water");
		
		//if(other sim\_sf_triggers::isTouchingTrigger(dceiling))
		//	other iprintln("dceiling");

		if(isPlayer(other) && other sim\_sf_triggers::isTouchingTrigger(self) && !other sim\_sf_triggers::isTouchingTrigger(dceiling))
			other thread drown(self, dceiling);
	}
}	
drown(trigger, dceiling)
{
	self endon("disconnect");

	if(isDefined(self.drowning))
		return;		
	self.drowning = true;

	self notify("DrownStart");
	self endon("DrownStart");

	while (isAlive(self) && self sim\_sf_triggers::isTouchingTrigger(trigger) && !self sim\_sf_triggers::isTouchingTrigger(dceiling))
	{
		wait .125;

		if(isDefined(self.water_vision)) self.water_vision destroy();

		if(!isDefined(self.water_vision))
		{
			self.water_vision = newClientHudElem(self);
			self.water_vision.x = 0;
			self.water_vision.y = 0;
			self.water_vision setshader ("white", 640, 480);
			self.water_vision.alignX = "left";
			self.water_vision.alignY = "top";
			self.water_vision.horzAlign = "fullscreen";
			self.water_vision.vertAlign = "fullscreen";
			self.water_vision.color = (.16, .38, .5);
		}

		self.water_vision.alpha = .75;

		if(!isDefined(self.waterprogressbg))
		{
			self.waterprogressbg = newClientHudElem(self);				
			self.waterprogressbg.alignX = "center";
			self.waterprogressbg.alignY = "middle";
			self.waterprogressbg.x = 320;
			self.waterprogressbg.y = 385;
			self.waterprogressbg.alpha = 0.5;
		}
		self.waterprogressbg setShader("black", (level.waterbarsize + 4), 14);		

		if(!isDefined(self.waterprogressbar))
		{
			self.waterprogressbar = newClientHudElem(self);				
			self.waterprogressbar.alignX = "left";
			self.waterprogressbar.alignY = "middle";
			self.waterprogressbar.x = (320 - (level.waterbarsize / 2.0));
			self.waterprogressbar.y = 385;
		}
		self.waterprogressbar setShader("white", 0, 8);			
		self.waterprogressbar scaleOverTime(level.drowntime, level.waterbarsize, 8);

		progresstime = 0;
		f = 0;

		while(isAlive(self) && self sim\_sf_triggers::isTouchingTrigger(trigger) && !self sim\_sf_triggers::isTouchingTrigger(dceiling) && progresstime < level.drowntime)
		{		
			f++;
		
			wait 0.05;
			progresstime += 0.05;

			if(progresstime >= level.waterhurttime)					
			{
				if(f >= 4)
				{
					self thread [[level.callbackPlayerDamage]](self, self, 1, 0, "MOD_GRENADE_SPLASH", "none", self.origin, (0,0,0), "none", 0);   
					f = 0;
				}
			}
		}

		if(isAlive(self) && self sim\_sf_triggers::isTouchingTrigger(trigger) && !self sim\_sf_triggers::isTouchingTrigger(dceiling) && progresstime >= level.drowntime)
		{
			if(isDefined(self.waterprogressbg)) self.waterprogressbg destroy();
			if(isDefined(self.waterprogressbar)) self.waterprogressbar destroy();

			wait 0.025;
			self thread [[level.callbackPlayerDamage]](self, self, 3000, 0, "MOD_GRENADE_SPLASH", "none", self.origin, (0,0,0), "none", 0);  

			deathmethod = [];
			deathmethod[0] = " ^7made a hole in the water and lay down quietly to rest forever.";	
			deathmethod[1] = " ^7paid a long lasting visit to Davy Jones's Locker.";
			deathmethod[2] = " ^7went diving without breathing apparatus.";
			deathmethod[3] = " ^7swam like a brick.";
			
			iprintln( self.name, deathmethod[randomInt(deathmethod.size)]);
		}
			
		wait .05;
	}

	if(isDefined(self.waterprogressbg)) self.waterprogressbg destroy();
	if(isDefined(self.waterprogressbar)) self.waterprogressbar destroy();

	self.drowning = undefined;

	if(isDefined(self.water_vision))
	{
		self.water_vision.alpha = .5;
		self.water_vision fadeOverTime(3);
		self.water_vision.alpha = 0;
		wait(3);
		self.water_vision destroy();
	}
}

