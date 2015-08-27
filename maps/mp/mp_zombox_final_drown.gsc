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

	drownage = getentarray("gap1","targetname");
	if (isDefined("drownage"))
	{
		precacheShader("black");
		precacheShader("white");



		level.barsize = 288;
		level.drowntime = 8;
		level.hurttime = 6;

		for(d = 0; d < drownage.size; d++)
		{
			drownage[d] thread water();
		}
	}
}

Water()
{
while (1)
	{
	self waittill("trigger", other);

	if(isPlayer(other) && other istouching(self))
		other thread drown(self);
	}
}	
drown(trigger)
{
	dceiling = getent(trigger.target,"targetname");
	water_vision = undefined;
	while (isAlive(self) && self istouching(trigger) && !self istouching(dceiling))
	{
		wait .125;
		if(isDefined(self.drowning))
			return;		
		self.drowning = true;

	if(!isDefined(water_vision))
	{
		water_vision = newClientHudElem(self);
		water_vision.x = 0;
		water_vision.y = 0;
		water_vision setshader ("white", 640, 480);
		water_vision.alignX = "left";
		water_vision.alignY = "top";
		water_vision.horzAlign = "fullscreen";
		water_vision.vertAlign = "fullscreen";
		water_vision.color = (.16, .38, .5);
		water_vision.alpha = .75;
	}


	level.barincrement = (level.barsize / (20.0 * level.drowntime));
//	level.player allowProne(false);
	if(!isDefined(self.progressbackground))
	{
		self.progressbackground = newClientHudElem(self);				
		self.progressbackground.alignX = "center";
		self.progressbackground.alignY = "middle";
		self.progressbackground.x = 320;
		self.progressbackground.y = 385;
		self.progressbackground.alpha = 0.5;
	}
	self.progressbackground setShader("black", (level.barsize + 4), 14);		

	if(!isDefined(self.progressbar))
	{
		self.progressbar = newClientHudElem(self);				
		self.progressbar.alignX = "left";
		self.progressbar.alignY = "middle";
		self.progressbar.x = (320 - (level.barsize / 2.0));
		self.progressbar.y = 385;
	}
	self.progressbar setShader("white", 0, 8);			
	self.progressbar scaleOverTime(level.drowntime, level.barsize, 8);

	self.progresstime = 0;
	d = 0;
	f = 0;

	while(isalive(self) && self istouching(trigger) && !self istouching(dceiling) && (self.progresstime < level.drowntime))
	{		
		d ++;
		f ++;
		
		wait 0.05;
		self.progresstime += 0.05;


		if(self.progresstime >= level.hurttime)					
			{
			if(f >= 4)
				{
				radiusDamage(self.origin,9, 1, 1);
				f = 0;
				}
			}
	}

	if(isalive(self) && self istouching(trigger) && !self istouching(dceiling) && (self.progresstime >= level.drowntime))
	{

		self.progressbackground destroy();
		self.progressbar destroy();

		wait 0.025;
		radiusDamage(self.origin,22, 3000, 3000);

		self.drowning = undefined;
		self.sounder = undefined;



		randb = randomInt(4);
		deathmethod1 = " made a hole in the water and lay down quietly to rest forever.";	
		deathmethod2 = " paid a long lasting visit to Davy Jones's Locker.";
		deathmethod3 = " went diving without breathing apparatus.";
		deathmethod4 = " swam like a brick.";
		
		if (randb == 0)
		iPrintLn( self.name, deathmethod1);
		if (randb == 1)
		iPrintLn( self.name, deathmethod2);
		if (randb == 2)
		iPrintLn( self.name, deathmethod3);
		if (randb == 3)
		iPrintLn( self.name, deathmethod4);
		wait .05;
		water_vision destroy();
	}
	else
	{
		water_vision.alpha = .5;
		water_vision fadeOverTime(3);
		water_vision.alpha = 0;
		wait 0.05;
		self.progressbackground destroy();
		self.progressbar destroy();
		self.drowning = undefined;
		self.sounder = undefined;
	}			
	wait .05;
	}
}
