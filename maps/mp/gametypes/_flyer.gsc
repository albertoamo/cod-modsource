init()
{

	self thread Flyer();

}

Flyer()
{
	self endon("game_ended");
	self endon("disconnect");
	self endon("killed_player");

	if(!isdefined(self.flywait) || self.flywait == 0)
	{
		self.mover = spawn( "script_origin", self.origin );
		self.mover.angles = self.angles;
		self linkto (self.mover);
		self.islinkedmover = true;
		self.mover moveto( self.mover.origin + (0,0,25), 0.5 );

		self detachall();
        	self setmodel("xmodel/vehicle_p51_mustang");
		self setClientCvar("cg_thirdperson", "1");
		self setClientCvar("cg_thirdpersonrange", "185");

		self iprintlnbold( "^1You Are Now Flying." );
		self iprintlnbold( "^2Hold F To Go Up." );
		self iprintlnbold( "^6Hold SHIFT To Fly Verticaly." );
		self iprintlnbold( "^3Press Z To stop Flying." );
		self iprintlnbold( "^4Aim And You Go Faster!!!" );

		self thread OnZKey();
		self thread fireOnKey();

		while( self.islinkedmover == true )
		{
			angle = self getplayerangles();

			if ( self meleeButtonPressed() )
				self thread moveonangle(angle);

			if( self usebuttonpressed() )
				self fly_vertical( "up" );
				
			wait 0.001;
		}
	}
}

fly_vertical( dir )
{
	vertical = (0,0,50);
	vertical2 = (0,0,100);

	if( dir == "up" )
	{
		if( bullettracepassed( self.mover.origin,  self.mover.origin + vertical2, false, undefined ) )	
			self.mover moveto( self.mover.origin + vertical, 0.25 );
		else
		{
			self.mover moveto( self.mover.origin - vertical, 0.25 );
			
			self flyerKilled();
			self resetThirdPerson();
		}
	}

}

moveonangle( angle )
{
	forward = vector_scale(anglestoforward(angle), 50 );
	forward2 = vector_scale(anglestoforward(angle), 75 );

	if( bullettracepassed( self.origin, self.origin + forward2, false, undefined ) )
	{
  		if(self playerads() > 0.3)
   			self.mover moveto( self.mover.origin + forward, 0.1 );
		else
      			self.mover moveto( self.mover.origin + forward, 0.25 );
	}
  	else
	{
  		self.mover moveto( self.mover.origin - forward, 0.25 );
	
		self flyerKilled();
		self resetThirdPerson();	
	}
}

flyerKilled()
{	
	self unlink();
	self.mover delete();
	self.islinkedmover = false;
	self notify("ended_flyer");
	self playsound("explo_metal_rand");
	playfx(game["adminEffect"]["explode"], self.origin);
	self iprintlnbold("^1Next Time Dont Crash");		
	wait .10;		
	self suicide();
}


killflying( slot1count, slot1clip, slotclip, slotcount )
{

	self unlink();
	self.mover delete();
	self notify("ended_flyer");
	self.islinkedmover = false;
	self thread maps\mp\gametypes\_basic::loadTeamCfg();
	self thread maps\mp\gametypes\_teams::model();
	self resetThirdPerson();

	if(self.pers["team"] == "allies")
   	{
		if(isDefined(slot1count))
			self setWeaponSlotAmmo( "primary", slotcount );
		if(isDefined(slot1clip))
			self setWeaponSlotClipAmmo( "primary", slotclip );
		if(isDefined(slotclip))
			self setWeaponSlotAmmo( "primaryb", slot1count );
		if(isDefined(slotcount))
			self setWeaponSlotClipAmmo( "primaryb", slot1clip );
	}
	wait .5;
	
}

vector_scale(vec, scale) 
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}

fireOnKey()
{
	self endon("intermission");
	self endon("disconnect");
	self endon("killed_player");
	self endon("ended_flyer");

	fired = false;
	gun = 0;

	while(isDefined(self))
	{
		if( self AttackButtonPressed() ) 
		{
			if(!fired)
			{
				fired = true;
				self.mover playLoopSound( "stuka_guns" );
			}

			direction = anglesToForward( self.angles );
			directionForward = anglesToForward( self.angles );
			temp = maps\mp\_utility::vectorScale( directionForward, 40 );
			positionForward = self.origin + temp;
			directionRight = anglesToRight( self.angles );

			if(gun == 0)
			{
				gun = 1;
				temp = maps\mp\_utility::vectorScale( directionRight, 118 );
				positionRight = positionForward + temp;
				firePos = positionRight +  ( 0, 0, 1 );

				self thread cannonBullet( firePos, direction,2);
				fireForward = firePos + maps\mp\_utility::vectorScale( direction, 500000 );
				playfx( level._effect["20mm_tracer_flash"],firePos + direction,vectorNormalize(fireForward - firePos ) );
			}
			else
			{
				gun = 0;
				temp = maps\mp\_utility::vectorScale( directionRight, -118 );
				positionLeft = positionForward + temp;
				firePos = positionLeft + ( 0, 0, 1 );

				self thread cannonBullet( firePos, direction,2);
				fireForward = firePos + maps\mp\_utility::vectorScale( direction, 500000 );
				playfx( level._effect["20mm_tracer_flash"],firePos + direction,vectorNormalize(fireForward - firePos ) );
			}
		}
		else
		{
			fired = false;
			self.mover stopLoopSound( "stuka_guns" );
		}

		wait(0.2);
	}
}

OnZKey()
{
	self endon("intermission");
	self endon("disconnect");
	self endon("killed_player");
	self endon("ended_flyer");

	slotcount = 0;
	slot1count = 0;
	slot1clip = 0;
	slotclip = 0;

	weapon1 = self getweaponslotweapon("primary");
	weapon2 = self getweaponslotweapon("primaryb");

	if(getcvar("ze_debug_fly") == "1") iprintlnbold(weapon2);
	if(getcvar("ze_debug_fly") == "1") iprintlnbold(weapon1);

	if(weapon2 != "none")
	{
		slot1count = self getWeaponSlotAmmo("primaryb");
		if(getcvar("ze_debug_fly") == "1") iprintlnbold("Ammo: " + slot1count);
		slot1clip = self getWeaponSlotClipAmmo("primaryb");
		if(getcvar("ze_debug_fly") == "1") iprintlnbold("Ammo Clip: " + slot1clip);
	}

	if(weapon1 != "none")
	{
		slotcount = self getWeaponSlotAmmo("primary");
		if(getcvar("ze_debug_fly") == "1") iprintlnbold("Ammo: " + slotcount);
		slotclip = self getWeaponSlotClipAmmo("primary");
		if(getcvar("ze_debug_fly") == "1") iprintlnbold("Ammo Clip: " + slotclip);
	}

	self setWeaponSlotAmmo( "primary", 0 );
	self setWeaponSlotClipAmmo( "primary", 0 );
	self setWeaponSlotAmmo( "primaryb", 0 );
	self setWeaponSlotClipAmmo( "primaryb", 0 );


	wait(0.05);

	self maps\mp\gametypes\_basic::execClientCmd("bind z openscriptmenu -1 z");

	while(isDefined(self))
	{
		self waittill("key_z");
		if( !isDefined( self ) )
			return;

		self thread killflying( slot1count, slot1clip, slotclip, slotcount );			
	}
}

resetThirdPerson()
{
	if(!isdefined(self.thirdperson))
		self.thirdperson = false;

	if(!self.thirdperson)
		self setclientcvar("cg_thirdperson", 0);
	else
		self setclientcvar("cg_thirdperson", 1);

	self setClientCvar("cg_thirdpersonrange", "120");
}

cannonBullet( firePos, direction, iDamage )
{
	self endon( "intermission" );
	
	impactTime = ( 1.5 / 13020 );

	// TTL
	bulletTime = 4;
	fx = level._effect["20mm_wallexplode"];
	
	temp 		= maps\mp\_utility::vectorScale( direction, 400 );
	nextPos 	= firePos + temp;
	
	distance 	= distance( firePos, nextPos );
	waitTime 	= ( impactTime * (distance ) );
	
	firePos 	= nextPos;
	
	if( waitTime <= 0 )
		return;

	wait( waitTime - (1 / distance) );

	while( bulletTime > 0 )
	{
		temp 	= maps\mp\_utility::vectorScale( direction, 1000 );
		nextPos = firePos + temp;
		
		trace = bulletTrace( firePos, nextPos, true, true );
		ent = trace["entity"];
		
		distance = distance( firePos, trace["position"] );
		
		waitTime = ( impactTime * distance );
		
		fx = level._effect["20mm_wallexplode"];
		
		if(  isDefined( ent )  || 
		      trace["surfacetype"] != "none" &&  trace["surfacetype"] != "default" )
		{
			distance = distance( firePos, trace["position"] );
			position = trace["position"];
			

			bullet = spawn( "script_origin", position );

			bullet playSound( "bullet_ap_" + trace["surfacetype"], position );
			
			
			if( isPlayer(ent) )
			{
				fx = level.impact["flesh"];
				if( isDefined( self ) )
				{
					self maps\mp\gametypes\_plane::manualRadiusDamage( self ,position,"plane_mp","MOD_EXPLOSIVE", 80,15, 1000 ,true);
				}
			}
			else if( isDefined( ent ) )
			{
				if( isDefined( ent.parent ) )
					ent = ent.parent;
					
				if( isDefined( ent.damage ) && isDefined( ent.maxDamage ) )
				{
					if( isDefined( self.peep ) )
					{
						ent.hitBy = self.peep;
					}
					ent.hitWeapon = self.weaponName;

					ent notify("plane_hit");
					
					iADamage = true;
					
					tempPeep = self.peep;
					
					if( isDefined( tempPeep ) )
					{
						if( isDefined( ent.peep ) && isDefined( self.peep ) )
							self.peep iprintln("hit on ", ent.peep );
						else if( isDefined( self.peep ) )
							self.peep iprintln("hit on ", ent.vehicleType );
					}
					
					if ( isDefined( tempPeep ) && ( ent.vehicleType == "jeep" || ent.vehicleType == "truck" ) )
					{
						if( isDefined( ent.driver ) )
							if( ent.driver.pers["team"] == tempPeep.pers["team"] )
								iADamage = false;
						if( isDefined( ent.passenger1 ) )
							if( ent.passenger1.pers["team"] == tempPeep.pers["team"] )
								iADamage = false;
							
					}
					else if( isDefined( tempPeep ) && ent.vehicleType == "plane" )
					{
						if( isDefined( ent.peep ) )
							if( ent.peep.pers["team"] == tempPeep.pers["team"] )
								iADamage = false;
					
					}
					else if( isDefined( tempPeep ) && ent.vehicleType == "aa" )
					{
						if( isDefined( ent.peep ) )
							if( ent.peep.pers["team"] == tempPeep.pers["team"] )
								iADamage = false;
					
					}
					else if( isDefined( tempPeep ) && ent.vehicleType == "tank" )
					{
						if( isDefined( ent.peep ) )
							if( ent.peep.pers["team"] == tempPeep.pers["team"] )
								iADamage = false;
					
					}
					
					if( iADamage == true )
						ent.damage += iDamage;
					
				}
				fx = level._effect["20mm_wallexplode"];
			}
			else
			{				
			    	fx = level._effect["20mm_wallexplode"];
			}	

			playFX( fx, position );
			
			if( isDefined( self ) )
				self maps\mp\gametypes\_plane::manualRadiusDamage( self, position,"plane_mp","MOD_EXPLOSIVE", 80,15, 1000 ,true);
			else
				radiusDamage( position + ( 0, 0, 10 ), 60, 200, 10 );
			
			
				
			
			wait ( 0.5 );
			bullet delete();
			break;
			
		}
		else
		{
			firePos = nextPos;
		}

		tempwait = waitTime - (1.5 / distance);

		if(tempwait < 0)
			tempwait = 0.25;
		
		wait( tempwait );
		
		bulletTime -= waitTime;
		firePos     = nextPos;
	}
	
}
