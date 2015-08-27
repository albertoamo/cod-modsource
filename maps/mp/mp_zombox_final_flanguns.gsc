main()
{
thread aa ();
}


aa()
{
	precacheStuff();
	
	level thread onPlayerConnected();

	if( getCvar("dvar_aaMaxDamage") == "" )
		setCvar("dvar_aaMaxDamage","15" );	

	if( getCvar("dvar_aaRateOfFire") == "" )
		setCvar("dvar_aaRateOfFire","0.09" ); // default 0.15		

	level.aaMaxDamage = getCvarInt("dvar_aaMaxDamage");
	level.aaRateOfFire = getCvarFloat("dvar_aaRateOfFire");
	wait 5;

	thread aa_spawn();	
	//thread aa_spawn2();	// remove the "//" to enable the second aa gun. 
}

onPlayerConnected()
{
	self endon("intermission");
	iLinked = false;
	while(1)
	{
		self waittill("connected", player );
		
		player thread onPlayerSpawned();
	}
		
}

onPlayerSpawned()
{
	self endon("intermission");
	self endon("disconnect");
	
	
	while(1)
	{
		self waittill("spawned_player");
		self notify("detached_gunner");
		
		self.cancelSprint = undefined;		
//		origin = (-38169, 14043, -280 );
		//origin = (-25283, 11017, 559 );
//		self setOrigin( origin );
		
	}
}

precacheStuff()
{
	game["aa"] = "xmodel/german_artillery_flakveirling";
	game["aad"] = "xmodel/german_artillery_flakveirling_d";
	
	game["mortar"] = "xmodel/prop_mortar_ammunition";
	
	level._effect["20mm_tracer_flash"]    	= loadfx ("fx/un/20mm_tracer_flash.efx");
	level._effect["armoredcar_explosion"]	= loadFX("fx/explosions/armoredcar_explosion.efx");

	precachemodel( game["aa"] );
	precachemodel( game["aad"] );
	
	precachemodel( game["mortar"] );
	
	game["reloadingdone"] = &"^2READY!";
	game["reloading"]     = &"^1RELOADING!";

	precacheString( game["reloadingdone"] );	
	precacheString( game["reloading"] );	
	
	game["target"] 		= &"^9.      .";
	precacheString( game["target"] );

	level.impact["flesh"] 	 		= loadFX("fx/impacts/flesh_hit.efx");
	level._effect["20mm_wallexplode"]    	= loadfx ("fx/explosions/20mm_wallexplode.efx");
}

manualRadiusDamage(attacker,origin,weapon,mdeath, range,damage, maxDamage ,killIfBlocking)
{
	if( isDefined( mdeath ) )
		mDeath = "MOD_EXPLOSIVE";
	
	if( !isDefined( weapon ) )
		weapon = "none";
		
	damageMultiplier = range / maxDamage;
	//iprintlnbold("new ckill");
	players = getentarray("player", "classname");
	for( j = 0; J < players.size; j++ )
    	{
    		peep = players[j];
    		
    		if( peep == self )
    			continue;
    		pOrigin = peep getOrigin();
    		dist = distance( origin, pOrigin );
    		if( dist > range )
    			continue;
    		
    		currDamage = int(dist / damageMultiplier);
    		
    		if( currDamage < damage )
    			currDamage = damage;
    			
    		trace = bulletTrace( origin + (0,0,10 ), pOrigin + ( 0 ,0 ,40 ), true, undefined );
    		
    		ent = trace["entity"];
    		
    		if( isDefined( ent ) && ent != peep )
    			if( killIfBlocking != true )
    				continue;
    		
    		direction = vectorToAngles( pOrigin - origin );
    		direction = anglesToForward( direction );
    		
    		peep thread [[level.callbackPlayerDamage]](self, attacker, currDamage, 1, mdeath, weapon, pOrigin, direction, "none",0);
    		
    	}
    	
}

monitorExKeys()
{
	self endon( "intermission" );
	self endon("disconnect");

	if( isDefined( self.monitorExtraKeys ) )
		return;
	self.monitorExtraKeys = true;
	wait (1);
	if( !isDefined( self )  )
		return;
	
	
	while( isDefined( self )  )
	{
		self waittill("menuresponse", menu, response);

		if(  menu == "-1" && isAlive( self ) )
		{
			self notify( "key_" + response );
		}
		else
		{
		}
	}
}

cannonBullet( firePos, direction, iDamage )
{
	self endon( "intermission" );
	
	impactTime = ( 1 / 13020 );

	// TTL
	bulletTime = 4;
	fx = level._effect["20mm_wallexplode"];
	
	temp 		= vector_scale( direction, 400 );
	nextPos 	= firePos + temp;
	
	distance 	= distance( firePos, nextPos );
	waitTime 	= ( impactTime * (distance ) );
	
	firePos 	= nextPos;
	
	if( waitTime <= 0 )
		return;

	wait( waitTime);

	while( bulletTime > 0 )
	{
		temp 	= vector_scale( direction, 1000 );
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
				if( isDefined( self.peep ) )
				{
					self.peep iprintlnbold( "Direct hit on ", trace["entity"] );
					self.peep manualRadiusDamage( self.peep ,position,self.weaponName,"MOD_EXPLOSIVE", 70,10, 1000 ,true);
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
					
					if ( isDefined( tempPeep ) && ent.vehicleType == "jeep" )
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
			
			if( isDefined( self.peep ) )
				self.peep manualRadiusDamage( self.peep, position,self.weaponName,"MOD_EXPLOSIVE", 70,10, 1000 ,true);
			else
				radiusDamage( position + ( 0, 0, 10 ), 50, 200, 10 );
			
			
				
			
			wait ( 0.5 );
			bullet delete();
			break;
			
		}
		else
		{
			firePos = nextPos;
		}
		
		wait( waitTime );
		
		bulletTime -= waitTime;
		firePos     = nextPos;
	}
	
}

//*****************************************************
// Util
//*****************************************************
getDiffV2(rollNew, rollOld)
{
	
	val1 = positiveMod( rollNew );
	val2 = positiveMod( rollOld );

	if( val1 > val2 )
	{
		temp = val1;
		val1 = val2;
		val2 = temp;
	}	
		
	if( ( val2 - val1 ) < 180 )
		return val2 - val1;
	else
	{
		return ( ( 360 - val2) + val1 ) ;
	}

}

//*****************************************************
// Util mod
//*****************************************************
miscMod(rollNew)
{
		if( rollNew < 0 )
		{
			if( rollNew < -1000 )
			{
				temp = int( rollNew / -360) - 1;
				
				rollNew -= ( -360 * temp );
			}
			
			while( rollNew <= -360 )
				rollNew += 360;

			//rollNew = (360 + rollNew ) ;
		}
		else if( rollNew > 0 )
		{
			if( rollNew > 1000 )
			{
				temp = int( rollNew / 360 ) - 1;
				
				rollNew -= ( 360 * temp );
			}
			
			while( rollNew >= 360 )
				rollNew -= 360;
		
		}
		

	return rollNew;
}

//**********************************************
// Util turn direction 
//**********************************************
turnDirection( newDirection, oldDirection)
{
	iResult = 0;
	newDirection = miscMod( newDirection  );
	olddirection = miscMod( oldDirection );


	if( newDirection <= 180 )
	{
		temp = newDirection + 180;
			
		if( oldDirection >= newDirection && oldDirection <= temp  )
		
			iResult = 1;
		else
			iResult = -1;
	}
	else
	{
		temp = newDirection - 180;
		if( oldDirection >= temp && oldDirection <= newDirection )
			iResult = -1;
		else
			iResult = 1;
	}
	
	return iResult;

}

//*****************************************************
// Util
//*****************************************************

positiveMod(rollNew)
{
		if( rollNew < 0 )
		{
			if( rollNew < -1000 )
			{
				temp = int( rollNew / -360) - 1;
				
				rollNew -= ( -360 * temp );
			}
			
			while( rollNew < -360 )
				rollNew += 360;

			rollNew = (360 + rollNew ) ;
		}
		else if( rollNew > 0 )
		{
			if( rollNew > 1000 )
			{
				temp = int( rollNew / 360 ) - 1;
				
				rollNew -= ( 360 * temp );
			}
			
			while( rollNew > 360 )
				rollNew -= 360;
		
		}
		

	return rollNew;
}

vector_scale(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}


//********************************************
// Spawn AA cannon
//********************************************
aa_spawn2()
{

	self endon("intermission");

	origin = (512.0,4000.0,-2192.0);	

	aa = spawn("script_model", origin );
	aa setModel( game["aa"] );
	aa show();
	aa rotatevelocity ( (0, -90, 0),1 );
	//iprintln("^1NEW AA AVAILABLE!!!!!!!! [^3", team, "^1]");
	
	aa.cannonRounds = [];
	//aa.properties = [];

	anglesF = anglesToForward( aa.angles );
	anglesR = anglesToRight( aa.angles );
	anglesU = anglesToUp( aa.angles );
	
	// GUNS GUNS GUNS 
	aa.properties["gun0"]["f"] = 100;
	aa.properties["gun0"]["r"] = -19;
	aa.properties["gun0"]["u"] = 56.5;
	
	aa.properties["gun1"]["f"] = 100;
	aa.properties["gun1"]["r"] = 19;
	aa.properties["gun1"]["u"] = 39.5;


	aa.properties["gun2"]["f"] = 100;
	aa.properties["gun2"]["r"] = -19;
	aa.properties["gun2"]["u"] = 40;

	aa.properties["gun3"]["f"] = 100;
	aa.properties["gun3"]["r"] = 19;
	aa.properties["gun3"]["u"] = 56;

	maxRounds = 40;

	aa.cannonRounds[ aa.cannonRounds.size ] = maxRounds;
	aa.cannonRounds[ aa.cannonRounds.size ] = maxRounds;
	aa.cannonRounds[ aa.cannonRounds.size ] = maxRounds;
	aa.cannonRounds[ aa.cannonRounds.size ] = maxRounds;

/////////////////////////////////////

	// GUNNER
	aa.properties["gunner"]["f"] = -30;
	aa.properties["gunner"]["r"] = 1;
	aa.properties["gunner"]["u"] = 20;
	

	aa.gunner = undefined;
	aa.gunner = undefined;

	// END GUNNER
	
	aa.fireSetting = 1;
	aa.weaponName = "aa_mp";
	aa.damage = 0;
	aa.maxDamage = level.aaMaxDamage;
	aa.vehicleType = "aa";
	aa thread scriptedTrigger( 75.0);
	aa thread onTrigger( );
	aa thread trackDamage();
	

	//////////////////////////////////////////////////////
	

}

aa_spawn()
{

	self endon("intermission");

	origin = (512.0,2148.0,-1936.0);	

	aa = spawn("script_model", origin );
	aa setModel( game["aa"] );
	aa show();
	aa rotatevelocity ( (0, 90, 0),1 );
	//iprintln("^1NEW AA AVAILABLE!!!!!!!! [^3", team, "^1]");
	
	aa.cannonRounds = [];
	//aa.properties = [];

	anglesF = anglesToForward( aa.angles );
	anglesR = anglesToRight( aa.angles );
	anglesU = anglesToUp( aa.angles );
	
	// GUNS GUNS GUNS 
	aa.properties["gun0"]["f"] = 100;
	aa.properties["gun0"]["r"] = -19;
	aa.properties["gun0"]["u"] = 56.5;
	
	aa.properties["gun1"]["f"] = 100;
	aa.properties["gun1"]["r"] = 19;
	aa.properties["gun1"]["u"] = 39.5;


	aa.properties["gun2"]["f"] = 100;
	aa.properties["gun2"]["r"] = -19;
	aa.properties["gun2"]["u"] = 40;

	aa.properties["gun3"]["f"] = 100;
	aa.properties["gun3"]["r"] = 19;
	aa.properties["gun3"]["u"] = 56;

	maxRounds = 40;

	aa.cannonRounds[ aa.cannonRounds.size ] = maxRounds;
	aa.cannonRounds[ aa.cannonRounds.size ] = maxRounds;
	aa.cannonRounds[ aa.cannonRounds.size ] = maxRounds;
	aa.cannonRounds[ aa.cannonRounds.size ] = maxRounds;

/////////////////////////////////////

	// GUNNER
	aa.properties["gunner"]["f"] = -30;
	aa.properties["gunner"]["r"] = 1;
	aa.properties["gunner"]["u"] = 20;
	

	aa.gunner = undefined;
	aa.gunner = undefined;

	// END GUNNER
	
	aa.fireSetting = 1;
	aa.weaponName = "aa_mp";
	aa.damage = 0;
	aa.maxDamage = level.aaMaxDamage;
	aa.vehicleType = "aa";
	aa thread scriptedTrigger( 75.0);
	aa thread onTrigger( );
	aa thread trackDamage();
	

	//////////////////////////////////////////////////////
	

}
//**********************************************
// Track Damage
//**********************************************
trackDamage()
{
	self endon("intermission");
	
	while( isDefined( self ) &&  self.damage < self.maxDamage )
	{
		wait .1;
		
	}
	
	self destroyMe();

}

//**********************************************
// Destroy me
//**********************************************
destroyMe()
{
	self endon("intermission");
	
	temp = 4;
	self playSound("mortar_explosion" + randomIntRange(1,5) ,temp);
	playFX( level._effect["armoredcar_explosion"], self.origin );
	
	self setModel( game["aad"] );
	
	
	peep = self.gunner;

	if( isDefined( peep ) )
	{
		//iprintlnbold("dset2");
		
		peep dettachGunner();
		if( isAlive( peep ) )
			peep suicide();
	}
	self notify("destroyed_aa");
	wait 1;
	wait( randomIntRange( 2,10 ) );
	self delete();
	
}

//**********************************************
// Handle trigger
//**********************************************
onTrigger()
{
	self endon("intermission");
	self endon("destroyed_aa");
	
	while( isDefined( self ) )
	{
		self waittill("trigger1", player );
		
		if( player useButtonPressed() == true )
		{
			while( player useButtonPressed() == true )
				wait(0.1);
				
			player attachGunner( self );
			
		}

		
	}
}
//**********************************************
// Attach gunner
//**********************************************
attachGunner( aa )
{
	if( isDefined( self.vehicle ) )
		return;
	if( !isDefined( aa ) )
		return;
	if( isDefined( aa.gunner ) && isAlive( self ) )
	{
		return;
	}
	else if( isDefined( aa.gunner ) && !isAlive( self ) )
	{
		self.aa = undefined;
		aa.gunner = undefined;
		aa.gunner = undefined;
	}
	//self iprintlnbold( self," attach" );
	
	aa.gunner = self;
	aa.peep = self;
	self.aa = aa;
	
	origin = aa getOrigin();
	anglesF = anglesToForward( aa.angles );
	anglesR = anglesToRight( aa.angles );
	anglesU = anglesToUp( aa.angles );
	
	temp = vector_scale( anglesF, aa.properties["gunner"]["f"] );
	temp += vector_scale( anglesR, aa.properties["gunner"]["r"] );
	temp += vector_scale( anglesU, aa.properties["gunner"]["u"] );
	temp += origin;
	
	self setOrigin( temp );
	self linkTo( aa );
	self disableWeapon();
	self.cancelSprint = true;
	
	self.vehicle = aa;
	
	self thread planePilot( aa );
	aa thread gunner();
	
	self thread detachPlayer();
	self initHud();
	self thread onKey();
	self thread onReload();
}

//*****************************************************
// Monitor player incase he wants to run like a chicken
//*****************************************************
detachPlayer()
{
	self endon("intermission");
	
	while( isDefined( self ) && isAlive( self ) )
	{
		if( self useButtonPressed() == true )
		{
			while( self useButtonPressed() == true )
				wait(0.1);
				
			//self iprintlnbold(self, " detach");
			break;			
		}
		
		wait(0.1);
	}

	self dettachGunner();

}
//**********************************************
// Attach gunner
//**********************************************
dettachGunner()
{
	if( !isDefined( self ) || !isDefined( self.aa ) )
		return;

	self destroyHud();
	if( !isDefined( self.aa.gunner ) || 
	  ( isDefined( self.aa.gunner) && self.aa.gunner != self ) )
	{
		self.vehicle = undefined;
		self.aa = undefined;
		return;
	}
	
	self.vehicle = undefined;
	self enableWeapon();
	self.cancelSprint = undefined;

	self.aa notify("detached_gunner");

	self notify("detached_gunner");
	//iprintlnbold("detac");

	self.aa.gunner = undefined;
	self.aa = undefined;
	self unlink();
	
	
}

//**********************************************
// Spawns are extreamly expensive
//**********************************************
scriptedTrigger( iDist)
{
	self endon("intermission");
	self endon("destroyed_aa");
	
	origin = self getOrigin();
	while( isDefined( self ) )
	{

		players = getentarray("player", "classname");
		for( j = 0; j < players.size; j++ )
		{
			player = players[j];
		
			if( isDefined( player ) && isAlive( player ) && !isDefined( player.aa ))
			{
				currDist = distance( origin , player getOrigin() );
				if( currDist < iDist )
				{
					temp = vectorToAngles( player getOrigin() - origin );
					anglesF = anglesToForward( temp );
					
					temp = vector_scale( anglesF, 80 );
					
					temp += origin;
					
					trace = bulletTrace( temp + (0,0,500), temp - (0,0,500), false, self );
					
					player setOrigin( trace["position"] );
					
					//iprintln("dist = ", currDist );
					self notify( "trigger1", player );
				}	
			}
		}
		wait 0.05;
		
	}
	
}
initHud()
{
	self destroyHud();
	
	self.planeHudTarget 		= newClientHudElem(self); 
	self.planeHudTarget.horzAlign 	= "center_safearea";
	self.planeHudTarget.vertAlign 	= "center_safearea";
    	self.planeHudTarget.alignX 	= "center";
    	self.planeHudTarget.alignY 	= "middle";   
    	self.planeHudTarget.x 		= 0; 
    	self.planeHudTarget.y 		= 2; 
    	self.planeHudTarget.color 	= (0, 1, 0);   
    	self.planeHudTarget.font 	= "default";    
    	self.planeHudTarget.fontscale 	= 1;
    	self.planeHudTarget.alpha 	= .5;
	self.planeHudTarget setText( game["target"] );
	
}

destroyHud()
{
	if( isDefined( self.planeHudTarget ) )
		self.planeHudTarget destroy();
		
		
}
//**********************************************
// Pilot
//**********************************************
planePilot( plane)
{
	self endon("intermission");
	self endon("killed_player");
	self endon("disconnect");
	self endon("plane_shutdown");
	self endon("destroyed_plane");
	
	plane.anglePitch = plane.angles[0];
	plane.angleYaw   = plane.angles[1];
	plane.angleRoll  = plane.angles[2];
	plane.shutdown = 0;
	tempRoll = 0;
	iOldPitch = 0;
	iOldYaw = 0;
	iTempP = 0;
	iTempY = 0;
	iTempR = 0;
	iOldRoll = 0;
	while( isDefined( plane ) && isPlayer( self ) &&  isAlive( self ) && isDefined( self.aa )  )
	{
		angles = self getPlayerAngles();
		planeAngles = plane.angles;
		origin = plane getOrigin();
		
		anglesForward      = anglesToForward( angles );
		planeAnglesForward = anglesToForward( planeAngles);
		
		temp = vector_scale( anglesForward, 10000 );
		temp += origin;
		lookDirection = vectorToAngles( temp - origin ); 
		
		temp = vector_scale( planeAnglesForward, -10000 );
		temp += origin;
		
		backDirection = vectorToAngles( temp - origin );
		
		hdirection = turnDirection( lookDirection[1], backDirection[1] );
		vdirection = turnDirection( planeAngles[0], lookDirection[0] );

		//*************************************************
		// Vertical direction
		//*************************************************
		
		
		
		temp = miscMod(lookDirection[0]);
		if( temp > 90 || temp < -90)
			temp -= 360;
		vdirection = turnDirection( planeAngles[0], temp );	
	
		//*************************************************
		// End Vertical direction
		//*************************************************

		hdiff = getDiffV2( lookDirection[1], plane.angles[1] );
		vdiff = getDiffV2( lookDirection[0], planeAngles[0] );
		
		d1 = positiveMod(plane.angles[1]);
		d2 = positiveMod(lookDirection[1]);
		
		
		

		if( hdirection != 0 )
		{
			//self.minefield = true;
			tempYaw = hdirection;
			tempRoll = hdirection;


			//*****************************************
			// Handle Yaw
			//*****************************************
			iYaw = hdiff;
			//if( iYaw > 40 )
			//	plane planeDecel();

			if( iYaw > 80 )
			{
			//	plane planeDecel();
				//plane planeDecel();
				iYaw = 80;
			}

			tempYaw *= ( hdiff * ( 15/ (15 + (iYaw )) ) );
						
			
			iTempY = tempYaw;
			plane.angleYaw = plane.angles[1] + tempYaw;
		}
		
		
		iPitch = 0;
		if( vdirection != 0  )
		{
			//tempYaw *= ( hdiff * ( 10/ (100 + (iYaw * 1.5)) ) );
			if( vdirection == -1 ) // up
				iPitch = vdirection * ( vdiff * ( 10/ ( 30 ) ) );
			else // down
				iPitch = vdirection * ( vdiff * ( 10/ ( 30 ) ) );
			
			plane.anglePitch = plane.angles[0] + iPitch;
			iTempP = iPitch;
		}

		if( self meleebuttonpressed() == true )
		{
			//plane.anglePitch = plane.angles[0] + iOldPitch;
			plane.angleYaw = plane.angles[1] + iOldYaw;
		}
		else
		{
			iOldPitch = iTempP;
			iOldYaw   = iTempY;
		}

		
		if( plane.anglePitch > 5 )
			plane.anglePitch = 5;
			
		
		
		
		plane rotateTo( ( plane.anglePitch, plane.angleYaw, 0 ), .1, 0, 0 );

		wait(0.1);
	}
}


gunner()
{
	self endon("intermission");
	self endon("killed_player");
	self endon("disconnect");
	self endon("detached_gunner");
	igun = 0;
	iAllEmpty = 1;
	iDoubles = 1;
	roFire = level.aaRateOfFire;
	peep = self.gunner;

	while( isDefined( self ) && isDefined( self.gunner) && isPlayer( self.gunner ) && isAlive( self.gunner ) && isDefined( self.gunner.aa ) )
	{
		
		if( isDefined( self.reloadMags ) )
		{
			wait(0.1);
			continue;
		}
		
		iAllEmpty = 1;
		
		if(self.cannonRounds[igun] > 1 )
		{
			iAllEmpty = 0;

			anglesF = anglesToForward( self.angles );
			anglesR = anglesToRight( self.angles );
			anglesU = anglesToUp( self.angles );
			origin = self getOrigin();

			if( self.fireSetting == 1 )
			{
				
				if( isDefined( self.gunner ) && isAlive( self.gunner ) && self.gunner attackButtonPressed() == true )
				{	
					roFire = level.aaRateOfFire;
					temp = vector_scale( anglesF,  self.properties["gun" + igun]["f"] );
					temp += vector_scale( anglesR, self.properties["gun" + igun]["r"] );
					temp += vector_scale( anglesU, self.properties["gun" + igun]["u"] );

					//temp += origin;
					origin += temp;

					self.direction = anglesToForward( self.angles );

					firePos = origin;

					fireForward =  firePos + vector_scale( self.direction, 500000 );

					playfx( level._effect["20mm_tracer_flash"],firePos + self.direction,vectorNormalize(fireForward - firePos ) );

					//playFx( level._effect["aaflash"],firePos + self.direction,vectorNormalize(fireForward - firePos ) ); 
					self.cannonRounds[igun]--;

					self playSound( "rocket_explode_default", origin );

					self thread cannonBullet( firePos, self.direction , 1.5 );
					igun++;
				}
			}
			else if( self.fireSetting == 2 )
			{
				if( isDefined( self.gunner ) && isAlive( self.gunner ) && self.gunner attackButtonPressed() == true )
				{
						
					if( iDoubles == 1 )
					{
						temp = vector_scale( anglesF,  self.properties["gun0"]["f"] );
						temp += vector_scale( anglesR, self.properties["gun0"]["r"] );
						temp += vector_scale( anglesU, self.properties["gun0"]["u"] );

						temp2 = vector_scale( anglesF,  self.properties["gun3"]["f"] );
						temp2 += vector_scale( anglesR, self.properties["gun3"]["r"] );
						temp2 += vector_scale( anglesU, self.properties["gun3"]["u"] );
						
						self.cannonRounds[0]--;
						self.cannonRounds[3]--;
						iDoubles = 0;

					}
					else
					{
						temp = vector_scale( anglesF,  self.properties["gun1"]["f"] );
						temp += vector_scale( anglesR, self.properties["gun1"]["r"] );
						temp += vector_scale( anglesU, self.properties["gun1"]["u"] );

						temp2 = vector_scale( anglesF,  self.properties["gun2"]["f"] );
						temp2 += vector_scale( anglesR, self.properties["gun2"]["r"] );
						temp2 += vector_scale( anglesU, self.properties["gun2"]["u"] );
						
						self.cannonRounds[1]--;
						self.cannonRounds[2]--;
						iDoubles = 1;
					}
					
					roFire = level.aaRateOfFire * 2;
					
					origin2 = origin + temp2;
					origin += temp;

					self.direction = anglesToForward( self.angles );

					firePos = origin;
					firePos2 = origin2;

					fireForward =  firePos   + vector_scale( self.direction, 500000 );
					fireForward2 =  firePos2 + vector_scale( self.direction, 500000 );

					playfx( level._effect["20mm_tracer_flash"],firePos + self.direction,vectorNormalize(fireForward - firePos ) );
					playfx( level._effect["20mm_tracer_flash"],firePos2 + self.direction,vectorNormalize(fireForward2 - firePos2 ) );

					//playFx( level._effect["aaflash"],firePos + self.direction,vectorNormalize(fireForward - firePos ) ); 

					self playSound( "rocket_explode_default", origin );
					self playSound( "rocket_explode_default", origin2 );

					self thread cannonBullet( firePos, self.direction ,1.5  );
					self thread cannonBullet( firePos2, self.direction ,1.5 );
					igun++;
				}
			
			}
			else if( self.fireSetting == 3 ) // QUAD
			{
				if( isDefined( self.gunner ) && isAlive( self.gunner ) && self.gunner attackButtonPressed() == true )
				{
					temp = vector_scale( anglesF,  self.properties["gun0"]["f"] );
					temp += vector_scale( anglesR, self.properties["gun0"]["r"] );
					temp += vector_scale( anglesU, self.properties["gun0"]["u"] );

					temp2 = vector_scale( anglesF,  self.properties["gun3"]["f"] );
					temp2 += vector_scale( anglesR, self.properties["gun3"]["r"] );
					temp2 += vector_scale( anglesU, self.properties["gun3"]["u"] );
						
					self.cannonRounds[0]--;
					self.cannonRounds[3]--;

					temp3 = vector_scale( anglesF,  self.properties["gun1"]["f"] );
					temp3 += vector_scale( anglesR, self.properties["gun1"]["r"] );
					temp3 += vector_scale( anglesU, self.properties["gun1"]["u"] );

					temp4 = vector_scale( anglesF,  self.properties["gun2"]["f"] );
					temp4 += vector_scale( anglesR, self.properties["gun2"]["r"] );
					temp4 += vector_scale( anglesU, self.properties["gun2"]["u"] );
						
					self.cannonRounds[1]--;
					self.cannonRounds[2]--;
					
					roFire = level.aaRateOfFire * 2;
					
					origin2 = origin + temp2;
					origin3 = origin + temp3;
					origin4 = origin + temp4;

					origin += temp;

					self.direction = anglesToForward( self.angles );

					firePos = origin;
					firePos2 = origin2;
					firePos3 = origin3;
					firePos4 = origin4;

					fireForward =  firePos   + vector_scale( self.direction, 500000 );
					fireForward2 =  firePos2 + vector_scale( self.direction, 500000 );
					fireForward3 =  firePos3 + vector_scale( self.direction, 500000 );
					fireForward4 =  firePos4 + vector_scale( self.direction, 500000 );

					playfx( level._effect["20mm_tracer_flash"],firePos + self.direction,vectorNormalize(fireForward - firePos ) );
					playfx( level._effect["20mm_tracer_flash"],firePos2 + self.direction,vectorNormalize(fireForward2 - firePos2 ) );
					playfx( level._effect["20mm_tracer_flash"],firePos3 + self.direction,vectorNormalize(fireForward3 - firePos3 ) );
					playfx( level._effect["20mm_tracer_flash"],firePos4 + self.direction,vectorNormalize(fireForward4 - firePos4 ) );

					//playFx( level._effect["aaflash"],firePos + self.direction,vectorNormalize(fireForward - firePos ) ); 

					self playSound( "rocket_explode_default", origin );
					self playSound( "rocket_explode_default", origin2 );

					self thread cannonBullet( firePos, self.direction ,1.5 );
					self thread cannonBullet( firePos2, self.direction, 1.5  );
					self thread cannonBullet( firePos3, self.direction , 1.5 );
					self thread cannonBullet( firePos4, self.direction , 1.5 );
					igun++;
				}
			
			}
		
			wait(roFire);
		}		
		else
			wait (0.1);
			
		
		if( igun >= self.cannonRounds.size )
			igun = 0;
			
		if( iAllEmpty == 1 )
		{
			if( isDefined( self.gunner )  )
				self.gunner thread reloading();
			//iprintlnbold("RELOADING!");
			for( j = 0; j < self.cannonRounds.size; j++ )
			{
				self.cannonRounds[j] = 20;
			}
			
			level.aaRateOfFire = getCvarFloat("dvar_aaRateOfFire");	
			roFire = level.aaRateOfFire;	
			wait 3;
			//iprintlnbold("DONE!");
		}
		
		
	}
	//iprintlnbold("exit gunner");
}
//*********************************************
//					      *
//*********************************************
reloading()
{
	self endon("intermission");
	aa = self.aa;
	if( isDefined( aa ) )
		aa.reloadMags = true;
	
	
	hud 		= newClientHudElem(self); 
	hud.horzAlign = "center_safearea";
	hud.vertAlign = "center_safearea";
    	hud.alignX 	= "center";
    	hud.alignY 	= "middle";   
    	hud.x 	= 0; 
    	hud.y 	= 50; 
    	hud.color 	= (0, 1, 0);   
    	hud.font 	= "default";    
    	hud.fontscale = 1.5;
    	hud.alpha 	= 1;

	hud setText( game["reloading"] );
	
	hud fadeovertime( 2 );
	hud.alpha = .5;
	wait 1.5;
	hud setText( game["reloadingdone"] );
	hud.alpha = 1;	
	
	hud fadeovertime( 2 );
	hud.alpha = .5;

	if( isDefined( aa )  )
		aa.reloadMags = undefined;

	wait 1;
	hud destroy();
}
//*********************************************
//					      *
//*********************************************

//*********************************************
//					      *
//*********************************************




onKey()
{
	self endon("intermission");
	self endon("disconnect");
	self endon("detached_gunner");
	
	if( !isDefined( self ) )
		return;
	self iprintlnBold( "Press ^2J^7 to Reload, ^2H ^7to change rate of fire!" );
	wait 2;
	self iprintlnBold(" \n  \n  \n  \n  \n  \n  ");
	if( !isDefined( self ) )
		return;

	self setClientCvar ("clientcmd", "bind h openscriptmenu -1 h");
	self openMenu ("clientcmd");
	self closeMenu ("clientcmd");

	wait(0.05);

	self setClientCvar ("clientcmd", "bind j openscriptmenu -1 j");
	self openMenu ("clientcmd");
	self closeMenu ("clientcmd");

	aa = self.vehicle;
	while( isDefined( self ) && isDefined( self.aa ) )
	{
		self waittill("key_h");
		
		aa togleFireSetting();
	}
}

onReload()
{
	self endon("intermission");
	self endon("disconnect");
	self endon("detached_gunner");
	
	if( !isDefined( self ) )
		return;
	
	wait 2;
	if( !isDefined( self ) )
		return;

	aa = self.vehicle;
	while( isDefined( self ) && isDefined( self.aa ) )
	{
		self waittill("key_j");
		
		if( !isDefined(aa.reloadMags) )
		{
			for( j = 0; j < aa.cannonRounds.size; j++)
			{
				//iprintlnbold("reload");
				aa.cannonRounds[j] = 0;
			}
			wait(1);
		}
	}
}

togleFireSetting()
{

	if( isDefined( self ) && isDefined( self.fireSetting ) )
	{
		self.fireSetting += 1;
		if( self.fireSetting > 3 )
			self.fireSetting = 1;

			
	}
}

