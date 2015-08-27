init()
{
	thread plane();
	thread main_callbacks();
}

main()
{
	self givePlane( "spitfire_mp", "spitfire" );
	//self givePlane( "me109_mp", "me109" );
}

main_callbacks()
{	
	//game["chute_menu"] = "chute";f
	//game["objjeep"] = "jeep_obj";
	
	//precacheMenu(game["chute_menu"]);
	//precacheitem("jeep_crush_mp");
	//precacheitem("me109_mp");
	precacheitem("spitfire_mp");
	//precacheitem("aa_mp");
	//precacheShader( game["objjeep"] );
}

plane()
{

	level._effect["20mm_tracer_flash"]    	= loadfx ("fx/un/20mm_tracer_flash.efx");    
	level._effect["20mm_wallexplode"]    	= loadfx ("fx/explosions/20mm_wallexplode.efx");//flak_puff.efx");//20mm_wallexplode.efx");      
	level._effect["fire_smoke_trail"]    	= loadFX( "fx/fire/fire_smoke_trail.efx" );//loadfx ("fx/explosions/flak_puff.efx");
	level._effect["ammo_supply_exp"] 	= loadfx("fx/explosions/ammo_supply_exp.efx");
	level._effect["thin_black_smoke_m"] 	= loadfx("fx/smoke/thin_black_smoke_M.efx");
	level._effect["dark_smoke_trail"] 	= loadfx("fx/smoke/dark_smoke_trail.efx");
	level._effect["smoke_trail"] 		= loadfx("fx/smoke/smoke_trail.efx");
	level._effect["eldaba_plane_explosion"] = loadFX("fx/explosions/eldaba_plane_explosion.efx");
	
	level._effect["libya_tank_impact"]	= loadfx("fx/explosions/libya_tank_impact.efx");
	level._effect["exp_pack_doorbreach"]    = loadfx("fx/explosions/exp_pack_doorbreach.efx");
	level._effect["mortarExp_concrete"]     = loadfx("fx/explosions/mortarExp_concrete.efx"); 

	level._effect["plane_crash"]		= loadfx("fx/un/plane_crash.efx");


	game["teammatedrone"] 	= &"^1TEAMMATE DRONE";
	game["teammate"] 	= &"^1TEAMMATE";
	game["axisdrone"] 	= &"^3AXIS DRONE";
	game["axisteam"] 	= &"^2AXIS";
	game["alliesdrone"] 	= &"^3ALLIES DRONE";
	game["alliesteam"] 	= &"^2ALLIES";
	game["empty"] 		= &" ";
	game["target"] 		= &"^9.        .";
	game["chute_open"]	= &"^1Press F to Open your chute!";
    	precacheString( game["empty"]);
	precacheString( game["teammatedrone"] );
	precacheString( game["teammate"] );
	precacheString( game["axisdrone"] );
	precacheString( game["axisteam"] );
	precacheString( game["alliesdrone"] );
	precacheString( game["alliesteam"] );
	precacheString( game["target"] );

	precacheString( game["chute_open"] );
	
	
	precacheShader( "hud_temperature_gauge" );
	precacheShader( "white" );

	minSpeed = getCvarInt("dvar_planeMinSpeed");
	maxSpeed = getCvarInt("dvar_planeMaxSpeed");
        planemaxdamage = getCvarInt("dvar_planeMaxDamage");
	if( minSpeed < 10 )
		minSpeed = 70; // 130
	if( maxSpeed < 10 )
		maxSpeed = 200; // 300
        if( planemaxdamage == 0 )
                planemaxdamage = 10;
	

	level.planeMaxSpeed 	= maxSpeed;
	level.planeMinSpeed 	= minSpeed;
	level.AccelRate   	= 1.5;
	level.DecelRate   	= 0.6;
	level.planeMaxDamage 	= planemaxdamage;
	
	level.gunMaxHeat	= 0;
	level.planes 		= 0;

	if( getCvar("dvar_gunMaxHeat") == "" )
		setCvar("dvar_gunMaxHeat","70");
		
	level.gunMaxHeat = getCvarInt("dvar_gunMaxHeat");
	
	game["chute"]    = "xmodel/un_chute";
	precachemodel(game["chute"]);

	//precachemodel("xmodel/me1092");
	precachemodel("xmodel/vehicle_spitfire_flying");
	precachemodel("xmodel/vehicle_stuka_flying");
  	precachemodel("xmodel/prop_mortar_ammunition");
	
	level thread onPlayerConnecting();

	level.debug = 0;
	
	level thread plane_wait();

	//ao = (-39200, 12083, 190);

	//a = spawn("script_model", ao );

	//a.angles += (0,0,90);
	//a setModel( game["chute"] );
	//a show();
	//a.isChute = true;
	//a thread onHit();
	level.planeAxis = [];
	level.planeAllies = [];
}

onJoinTeam()
{
	self endon("intermission");
	self endon("disconnect");
	
	while(1)
	{
		self waittill("joined_team");
		self.vehicle = undefined;
		removePlayerFromPlane( self );
	}
}

onJoinSpectators()
{
	self endon("intermission");
	self endon("disconnect");
	
	while(1)
	{
		self waittill("joined_spectators");
		self.vehicle = undefined;
		removePlayerFromPlane( self );
	}
}

onPlayerConnecting()
{
    self endon("intermission");

    
    while(1)
    {    
    	
        self waittill("connected",peep);
        
     	//remove line below
     	peep.givePlane = 0;
     	peep.lostWings = 0;
     	
     	peep.plane = undefined;
        peep thread onPlayerDisconnect();
        peep thread onSpawnedPlayer();
       	peep thread onJoinTeam();
	self thread onJoinSpectators();

        peep.shotdownCount = 0;
	
    }
}

onSpawnedPlayer()
{
	self endon("intermission");
	self endon("disconnect");
	while(1)
	{
		self waittill("spawned_player");
		
		//self maps\mp\gametypes\_spectating::setSpectatePermissions();

		self initPlanes();
		//self givePlane();
		self thread monitorExKeys();
		self.minefield = undefined;
		onPlayerKilled();
		self destroyHud();
		removePlayerFromPlane( self );

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

		if(  menu == "-1" && isAlive( self ) && response.size == 1 )
		{
			self notify( "key_" + response );
		}
	}
}


//****************************************************
// Init plane max points
// Scan the map for the lowest detectable point/ground
// Scan for the height of the skybox
// Scan for how far the planes can spawn
//****************************************************
initPlanes()
{
	if( isDefined( level.ground ) )
		return;
	

	initOrigin = self getOrigin() + ( 0,0,600 );
	
	anglesUp = anglesToUp( self getPlayerAngles() );
	temp = maps\mp\_utility::vectorScale( anglesUp, 10000000);
	temp += initOrigin;
	
	trace = bulletTrace( initOrigin, temp, false, undefined );
	level.height = trace["position"][2] - 20;
	
	//level.test0 setValue( level.height );
	
	
	jMax = initOrigin[0] + 50000;
	
	level.ground = initOrigin[2] + 50;
	
	
	
	//*********************************************
	// Init spawns
	//*********************************************
	tempOrigin = (initOrigin[0],initOrigin[1], level.height );
	trace =  bulletTrace( tempOrigin, tempOrigin + (10000000,0,0), false, undefined );
	
	angle = vectorToAngles( trace["position"] - initOrigin );
	
	tempF = anglesToForward( angle );
	
	dist = distance( tempOrigin, trace["position"] ); 
	idist = -1500;
	
	if( dist > 35000 ) 
	{
		
		idist = ( ( dist - 35000) );

		idist -= idist * 2;
	}
	temp = maps\mp\_utility::vectorScale( tempF, idist );
	
	
	
	level.axisPlaneSpawn = (trace["position"] + temp);
	level.axisPlaneSpawn = ( level.axisPlaneSpawn[0], level.axisPlaneSpawn[1], level.height / 2 );
	
	trace =  bulletTrace( tempOrigin, tempOrigin - (10000000,0,0), false, undefined );
	
	angle = vectorToAngles( trace["position"] - initOrigin );
	
	tempF = anglesToForward( angle );
	dist = distance( tempOrigin, trace["position"] ); 
	idist = -1500;
	
	if( dist > 35000 ) 
	{
		
		idist = ( ( dist - 35000) );

		idist -= idist * 2;
	}

	temp = maps\mp\_utility::vectorScale( tempF, idist );

	level.alliedPlaneSpawn = (trace["position"] + temp);
	level.alliedPlaneSpawn = (level.alliedPlaneSpawn[0], level.alliedPlaneSpawn[1], level.height / 2);
	//*********************************************
	// End Init spawns
	//*********************************************
	
	
	for( j = initOrigin[0] - 50000; j < jMax; j += 200 )
	{
		trace = bulletTrace( (j, initOrigin[1],level.height), (j,initOrigin[1], initOrigin[2] - 20000), false, undefined );
		
		if( trace["surfacetype"] != "none" &&  trace["surfacetype"] != "default" )
		{
			if( trace["position"][2] < level.ground )
				level.ground = trace["position"][2];
		}
	}

	jMax = initOrigin[1] + 50000;

	for( j = initOrigin[1] - 50000; j < jMax; j += 200 )
	{
		trace = bulletTrace( (initOrigin[0], j,level.height), (initOrigin[0],j, initOrigin[2] - 20000), false, undefined );
		
		if( trace["surfacetype"] != "none" &&  trace["surfacetype"] != "default" )
		{
			if( trace["position"][2] < level.ground )
				level.ground = trace["position"][2];
		}
	}
	
	//level.test1 setValue( level.ground );
	
	minefields = getentarray("minefield", "targetname");
	for(j = 0; j < minefields.size; j++)
	{
		minefields[j].height = 50;
	}
	
}
//*****************************************************
// give a plane to the player only if they choose one *
//*****************************************************
givePlane( weaponName, planeName )
{

	self initPlanes();
	
	if( self.lostWings == 1 )
		return;

	if(1 == 1) 
	{
		if( isDefined(self.plane) )
		{
			self.plane.damage = self.plane.maxDamage;

			self notify("plane_stop");
			self.plane.peep = undefined;
			
			if( isDefined( self.linked ) )
			{
				self.linked = undefined;
				self unlink();
			}
			self destroyHud();
		}
			
		self initHud();

		spawnOrigin = (0,0,0);
		
		if( self.pers["team"] == "axis" )
		{
			spawnOrigin = level.axisPlaneSpawn + ( randomIntRange( -5000, 5000 ), randomIntRange( -5000, 5000 ), 3000 );
		}
		else if( self.pers["team"] == "allies" )
		{
			spawnOrigin = level.alliedPlaneSpawn + ( randomIntRange( -5000, 5000 ), randomIntRange( -5000, 5000 ), 3000 );
		}

		if(maps\mp\gametypes\_basic::debugModeOn(self))
			spawnOrigin = (self.origin[0], self.origin[1], self.origin[2] + 3000);
		
		wait(0.05);
		self.plane = plane_spawn( self.pers["team"], weaponName ,
					  planeName,
					  spawnOrigin,
					   randomIntRange( 1,3 	 ) );	
		
		self.vehicle = self.plane;
		
		self.linked 		= 1;
		planeRef 		= self.plane getOrigin();
		self setOrigin( self.plane.markPilot getOrigin() );
		//self setOrigin( self.plane getOrigin() + (0,0,20));
		self linkTo( self.plane );
		//self setOrigin( self.plane.markPilot getOrigin() );
		self.plane notify	( "plane_drive" );
		self.plane.peep 	= self;
		self.plane.drive 	= 1;
		//self.plane thread 	drive();
		//self.plane thread 	planeManualGunner();
		self.plane.nameRef 	= self.name;
		self disableWeapon();
		//self maps\mp\gametypes\_weapons::dropWeapon();
		self removeOffhand();
		self.oldSessionState = self.sessionState;
		self.planeHudTarget setText( game["target"] );
		self setModel( "xmodel/prop_mortar_ammunition" );
		self.plane.angles -= (0,150,0);
		// kill sprint mode	
		self.minefield = true;
		
		//self thread manualEject();
		
	}
}

removeOffhand()
{
	current = self getcurrentoffhand();
	if(current != "none")
	{
		ammosize = self getammocount(current);

		if(ammosize)
			self takeweapon(current);
	}
}

onPlayerKilled()
{
	self endon("intermission");
	self endon("disconnect");
	
	self waittill("killed_player");
	if( isDefined( self) && isDefined(self.plane ) )
	{
		self.plane notify("plane_shutdown");
		self.plane.damage = self.plane.maxDamage;
		self notify("plane_stop");

		if( isDefined( self ) && isDefined( self.planeHudTarget ) )
			self.planeHudTarget setText( game["empty"] );	
		
		wait .5;
		self destroyHud();
		//self.plane.peep = undefined;
		if( isDefined( self.linked ) )
		{
			self.linked = undefined;
			self unlink();
		}
	}
}
onPlayerDisconnect()
{
	self endon("intermission");
	
	self waittill( "disconnect");
	if( isDefined(self) && isDefined(self.plane) )
	{
		self.plane.damage = self.plane.maxDamage;		
		self notify("plane_stop");
		self.plane.peep = undefined;

		self destroyHud();
		
		if( isDefined( self.linked ) )
		{
			self.linked = undefined;
			self unlink();
		}
	}
}

initHud()
{
	self destroyHud();
	
	self.planeHud 		= newClientHudElem(self); 
	self.planeHud.horzAlign = "center_safearea";
	self.planeHud.vertAlign = "center_safearea";
    	self.planeHud.alignX 	= "center";
    	self.planeHud.alignY 	= "middle";   
    	self.planeHud.x 	= 0; 
    	self.planeHud.y 	= 150; 
    	self.planeHud.color 	= (0, 1, 0);   
    	self.planeHud.font 	= "default";    
    	self.planeHud.fontscale = 1.5;
    	self.planeHud.alpha 	= 1;
	
	self.planeHudTarget 		= newClientHudElem(self); 
	self.planeHudTarget.horzAlign 	= "center_safearea";
	self.planeHudTarget.vertAlign 	= "center_safearea";
    	self.planeHudTarget.alignX 	= "center";
    	self.planeHudTarget.alignY 	= "middle";   
    	self.planeHudTarget.x 		= 0; 
    	self.planeHudTarget.y 		= 2.5; 
    	self.planeHudTarget.color 	= (0, 1, 0);   
    	self.planeHudTarget.font 	= "default";    
    	self.planeHudTarget.fontscale 	= 1;
    	self.planeHudTarget.alpha 	= .5;
	self.planeHudTarget setText( game["target"] );
	
	self.gunGauge		= newClientHudElem( self );
	self.gunGauge.alignX 	= "left";
	self.gunGauge.alignY 	= "bottom";
	self.gunGauge.horzAlign = "left";
	self.gunGauge.vertAlign = "bottom";
	self.gunGauge.x 	= 500;
	self.gunGauge.y 	= -50;
	self.gunGauge setShader("hud_temperature_gauge",15, 60 );
	self.gunGauge.color 	= ( 1, 1, 1 );
	self.gunGauge.alpha 	= 1;
	self.gunGauge.sort 	= 2;

	self.gunGaugeBack 		= newClientHudElem( self );
	self.gunGaugeBack.alignX 	= "left";
	self.gunGaugeBack.alignY 	= "bottom";
	self.gunGaugeBack.horzAlign 	= "left";
	self.gunGaugeBack.vertAlign 	= "bottom";
	self.gunGaugeBack.x 		= 505;
	self.gunGaugeBack.y 		= -64;
	self.gunGaugeBack setShader("white",4 ,44 );
	self.gunGaugeBack.color 	= ( 1, 0, 0 );
	self.gunGaugeBack.alpha 	= 0;
	self.gunGaugeBack.sort 		= 1;
}

destroyHud()
{
	if( isDefined( self.planeHud ) )
		self.planeHud destroy();
	
	if( isDefined( self.planeHudTarget ) )
		self.planeHudTarget destroy();
		
	if( isDefined( self.gunGauge ) )
		self.gunGauge destroy();
		
	if( isDefined( self.gunGaugeBack ) )
		self.gunGaugeBack destroy();
		
}
//#######################################
//# Init spawn planes 			#
//#######################################
plane_wait()
{
	self endon("intermission");
	
	
	
	alliedf = getentarray("allied_flag", "targetname");
	axisf = getentarray("axis_flag", "targetname");
	level.alliedSpawn = (0,0,0);
	level.axisSpawn  = (0,0,0);
	if( isDefined( alliedf ) && isDefined( axisf ) && alliedf.size > 0 && axisf.size > 0 )
	{
		level.alliedSpawn = alliedf[0].origin;
		level.axisSpawn = axisf[0].origin;
		
	}
	else
	{
		level.alliedSpawn = (randomIntRange( -500, 500 ), randomIntRange( -500, 500 ), randomIntRange( -500, 500 ));
		level.axisSpawn = (randomIntRange( -500, 500 ), randomIntRange( -500, 500 ), randomIntRange( -500, 500 ));

	}

		
	angles = vectorToAngles( level.alliedSpawn - level.axisSpawn );

	angles2 = vectorToAngles( level.axisSpawn - level.alliedSpawn );
		
		
	temp = maps\mp\_utility::vectorScale(anglesToForward(angles2), 35000 );
	level.axisSpawn = level.axisSpawn + temp;
	level.alliedSpawn = level.alliedSpawn - temp;

	

}



//**********************************************
// Move the plane forward		       
// *********************************************
engineON()
{
	self endon("intermission");
	wait (.5);

	self playLoopSound("spitfire_plane_loop");

	self thread onPlaneShutDown();
	
	wait .5;

	self thread trackDamage();
	self thread onHit();
	self thread onHitH(); // heavy hit/crashed

	self thread planeManualGunner();
	self thread onPlaneCollition();
	self thread planeCollition();
	
	self.peep thread planePilot( self );
	
	self.direction = anglesToForward( self.angles );
	
	
	self.peep thread manualEject();
	while(self.crashed == 0)
	{
		self.direction = anglesToForward( self.angles );
		origin = self getOrigin();	
		temp = maps\mp\_utility::vectorScale( self.direction, self.speed );
		
		nextPos = origin + temp;
		nextPos = ( int(nextPos[0]) , int(nextPos[1]) , int(nextPos[2]) );
		self moveTo( nextPos, .1, 0, 0 );
		
		wait (.1);
	}

	self planeFinish();
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
	while( isDefined( plane ) && isAlive( self ) && isDefined( plane.peep ) && plane.shutdown == 0 )
	{
		angles = self getPlayerAngles();
		planeAngles = plane.angles;
		origin = plane getOrigin();
		
		anglesForward      = anglesToForward( angles );
		planeAnglesForward = anglesToForward( planeAngles);
		
		temp = maps\mp\_utility::vectorScale( anglesForward, 10000 );
		temp += origin;
		lookDirection = vectorToAngles( temp - origin ); 
		
		temp = maps\mp\_utility::vectorScale( planeAnglesForward, -10000 );
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
			self.minefield = true;
			tempYaw = hdirection;
			tempRoll = hdirection;


			//*****************************************
			// Handle Yaw
			//*****************************************
			iYaw = hdiff;
			if( iYaw > 40 )
				plane planeDecel();

			if( iYaw > 80 )
			{
				plane planeDecel();
				//plane planeDecel();
				iYaw = 80;
			}
			if( hdirection == -1 && plane.angles[2] < -15 ) 
			{ // Right
			
				
				tempYaw *= ( hdiff * ( 10/ 600 ) );
				
			}
			else if( hdirection == 1 && plane.angles[2] > 15 )
			{ //Left
				
				tempYaw *= ( hdiff * ( 10/ 600 ) );
			}
			else if( iYaw < 20 )
			{
				tempYaw *= ( hdiff * ( 10/ (60 + (iYaw * 1.5)) ) );
			}
			else
			{
				
				tempYaw *= ( hdiff * ( 10/ (100 + (iYaw * 1.5)) ) );
			}

						
			//*****************************************
			// Handle Banking
			//*****************************************
			plane.angleRoll = plane.angles[2];
			
			iDiff = hdiff;
			if( hdirection == 1 )
			{// Left

				if( plane.angles[2] > 0 )
					iDiff += plane.angles[2];
				
				iDiff *= 0.2;
				if( iDiff > 15 )
					iDiff = 15;


				temp = hdiff - ( hdiff * 2 );
				if( temp < plane.angleRoll )
				{
					plane.angleRoll -= iDiff;
				}
				else if( temp > plane.angles[2] )
				{
					temp = temp - plane.angles[2];
					temp *= 0.2;
					plane.angleRoll += temp;
				}
				
				
			}
			else if( hdirection == -1 )
			{// Right
				if( plane.angles[2] < 0 )
				{
					temp = plane.angles[2];
					temp -= temp * 2;
					
					iDiff += temp;
				}
				
				iDiff *= 0.2;
				if( iDiff > 15 )
					iDiff = 15;
					
				if( hdiff > plane.angleRoll )	
				{
					plane.angleRoll += iDiff;
				}
				else if( hdiff < plane.angles[2] )
				{
					temp = plane.angles[2] - hdiff;
					temp *= 0.2;
					plane.angleRoll -= temp;
				}
				
			}
			
			if( plane.angleRoll > 80 )
				plane.angleRoll = 80;
			else if( plane.angleRoll < -80 )
				plane.angleRoll = -80;		
				
			iTempR = plane.angleRoll;
			//*****************************************
			// End Handle Banking
			//*****************************************
			
			iTempY = tempYaw;
			plane.angleYaw = plane.angles[1] + tempYaw;
		}
		
		
		iPitch = 0;
		if( vdirection != 0  )
		{
			//tempYaw *= ( hdiff * ( 10/ (100 + (iYaw * 1.5)) ) );
			if( vdirection == -1 ) // up
				iPitch = vdirection * ( vdiff * ( 10/ ( 40 + ( vdiff * 2.5)) ) );
			else // down
				iPitch = vdirection * ( vdiff * ( 10/ ( 40 + ( vdiff * 3.5)) ) );
			
			plane.anglePitch = plane.angles[0] + iPitch;
			iTempP = iPitch;
		}

		if( self useButtonPressed() == true)
		{
			plane planeAccel();
			plane planeAccel();
			plane planeAccel();
		}
		if( self meleebuttonpressed() == true )
		{
			//plane.anglePitch = plane.angles[0] + iOldPitch;
			plane.angleYaw = plane.angles[1] + iOldYaw;
			plane.angleRoll = iOldRoll;
		}
		else
		{
			iOldPitch = iTempP;
			iOldYaw   = iTempY;
			iOldRoll  = iTempR;
		}

		
		
		plane rotateTo( ( plane.anglePitch, plane.angleYaw, plane.angleRoll ), .1, 0, 0 );

		wait(0.1);
	}
}

//*****************************************************
// Plane On Collition trigger
//*****************************************************
onPlaneCollition()
{
	self endon("intermission");
	self endon("destroyed_plane");
	self endon("plane_shutdown");
	self.colPos = (0,0,0);
	self.colSurf = "";
	while( isDefined( self ) )
	{
		self waittill( "trigger_col", ent, side );

		self.hitBy = undefined;
		self.hitWeapon = "none";
		
		if( isPlane( ent ) )
		{
			ent.colPos = self.colPos;
			ent.colSurf = self.colSurf;
			
			//ent notify( "trigger_col", self, side );
			
		}
			
		self notify("plane_hith");
		playFX( level._effect["plane_crash"], self.colPos );
		self playSound( "bullet_ap_metal", self.colPos );
		
		self.damage += ( self.maxDamage / 3 );
		
	
	}
}
//*****************************************************
// Plane Collition dectection
//*****************************************************
planeCollition()
{
	self endon("intermission");
	self endon("destroyed_plane");
	
	plane = self;
	if( isDefined( self.child) )
		plane = self.child;
	
	ground = level.ground;
	while( isDefined( self ) && isDefined( plane ))
	{
		origin = self getOrigin();
		anglesF = anglesToForward( self.angles );
		anglesR = anglesToRight( self.angles );
		
		
		
		if( ground >= origin[2] )
		{
			
			self.hitBy = undefined;
			self.hitWeapon = "none";
			
			self notify("plane_hith");
			playFX( level._effect["plane_crash"], self.colPos );
			self playSound( "bullet_ap_metal", self.colPos );
			self.damage += self.maxDamage;
			//if( isDefined( self.peep ) )
			//	self.peep suicide();
			self.crashed = 1;
			break;
		
		}
		for( j = -10; j <= 80; j += 30 )
		{
			temp = maps\mp\_utility::vectorScale( anglesF, 150 );
			startPos = temp + origin + ( 0, 0, j );
		
			temp = maps\mp\_utility::vectorScale( anglesF, 310 );
			endPos = temp + origin + ( 0 ,0 ,j );
		
			trace = bulletTrace( startPos, endPos, true, plane );
			
			ent = trace["entity"];

			if( isDefined( ent ) )
			{
				if( isDefined( ent.driver ) || isDefined( ent.passenger1 ) )
				{
					self.peep.lostWings = 1;
					
					self.peep.givePlane = 0; 
					self.peep.hadPlane  = 0;
					

					if( isDefined(self.peep.pers) && self.peep.pers["team"] == "axis" )
					{
						level.planesAxis--;
					}
					else if( isDefined(self.peep.pers) && self.peep.pers["team"] == "allies" )
					{
						level.planesAllies--;
					}
					
				}
					
			}

			if( isDefined( ent ) && ent != plane && ent != self || 
			    (trace["surfacetype"] != "none" &&  trace["surfacetype"] != "default") )
			{
				
				self.hitBy = undefined;
				self.hitWeapon = "none";
				
				fireEvent = 1;
				if( isDefined( ent ) )
					if( ent == plane || ent == self )
						fireEvent = 0;
				if( trace["surfacetype"] == "cloth" )
					fireEvent = 0;
					
				
				if( fireEvent == 1 )
				{
					
					if( isDefined( ent ) )
					{
						self notify("trigger_col", ent, 1 );
						ent notify( "trigger_col", self, 1 );
					}
					self.colPos  = trace["position"];
					self.colSurf = trace["surfacetype"];

					self notify("plane_hith");
					playFX( level._effect["plane_crash"], self.colPos );
					self playSound( "bullet_ap_metal", self.colPos );
					self.damage += self.maxDamage;
					
					if( isDefined( ent ) && isPlane( ent ) )
					{
						ent notify("plane_shutdown");
						self notify("plane_shutdown");
					}
					else
						self.crashed = 1;
					//if( isDefined( self.peep ) )
					//	self.peep suicide();
					break;
				}
			}
			   
		}
		
		
		
		for( j = 75; j < 315; j += 80 )
		{
			temp = maps\mp\_utility::vectorScale( anglesF, 60 );
			temp += maps\mp\_utility::vectorScale( anglesR, j );
			startPos = temp + origin;
		
			temp += maps\mp\_utility::vectorScale( anglesF, 50 );
			endPos = temp + origin;

			trace = bulletTrace( startPos, endPos, true, plane );
			
			ent = trace["entity"];
			
			if( isDefined( ent ) )
			{
				if( isDefined( ent.driver ) || isDefined( ent.passenger1 ) )
				{
					self.peep.lostWings = 1;
					
					self.peep.givePlane = 0; 
					self.peep.hadPlane  = 0;
					

					if( isDefined(self.peep.pers) && self.peep.pers["team"] == "axis" )
					{
						level.planesAxis--;
					}
					else if( isDefined(self.peep.pers) && self.peep.pers["team"] == "allies" )
					{
						level.planesAllies--;
					}
				
				}
					
			}
			
			if( isDefined( ent ) && ent != plane && ent != self || 
			    (trace["surfacetype"] != "none" &&  trace["surfacetype"] != "default") )
			{
				fireEvent = 1;
				if( isDefined( ent ) )
					if( ent == plane || ent == self )
						fireEvent = 0;

				if( trace["surfacetype"] == "cloth" )
					fireEvent = 0;
				
				if( fireEvent == 1 )
				{

					self notify("trigger_col", ent, 2 );
					if( isDefined( ent ) )
						ent notify( "trigger_col", self, 2 );
					self.colPos  = trace["position"];
					self.colSurf = trace["surfacetype"];
				}
			}
		}

		origin = self getOrigin();
		anglesF = anglesToForward( self.angles );
		anglesR = anglesToRight( self.angles );
		
		for( j = -75; j > -315; j += -80 )
		{
			temp = maps\mp\_utility::vectorScale( anglesF, 60 );
			temp += maps\mp\_utility::vectorScale( anglesR, j );
			startPos = temp + origin;
		
			temp += maps\mp\_utility::vectorScale( anglesF, 50 );
			endPos = temp + origin;

			trace = bulletTrace( startPos, endPos, true, plane );
			
			ent = trace["entity"];
			if( isDefined( ent ) )
			{
				if( isDefined( ent.driver ) || isDefined( ent.passenger1 ) )
				{
					self.peep.lostWings = 1;
					
					self.peep.givePlane = 0; 
					self.peep.hadPlane  = 0;
					

					if( isDefined(self.peep.pers) && self.peep.pers["team"] == "axis" )
					{
						level.planesAxis--;
					}
					else if( isDefined(self.peep.pers) && self.peep.pers["team"] == "allies" )
					{
						level.planesAllies--;
					}
					
				}
				
				
			}

			if( isDefined( ent ) && ent != plane && ent != self || 
			    (trace["surfacetype"] != "none" &&  trace["surfacetype"] != "default") )
			{
				fireEvent = 1;
				if( isDefined( ent ) )
					if( ent == plane || ent == self )
						fireEvent = 0;

				if( trace["surfacetype"] == "cloth" )
					fireEvent = 0;
				
				if( fireEvent == 1 )
				{
					self notify("trigger_col", ent, 2 );
					if( isDefined( ent ) )
						ent notify( "trigger_col", self, 2 );

					self.colPos  = trace["position"];
					self.colSurf = trace["surfacetype"];
				}
			}
		}

		wait 0.1;
	}
}


//**********************************************
// Util mod
//**********************************************
///////////////////////////////////////////////
planeFinish()
{
	peep = self.peep;
	team = self.team;
	planeName = self.planeName;
	planeW = self.weaponName;
	drone = self.drone;
	
	
	
	self notify("destroyed_plane");
	temp = maps\mp\_utility::vectorScale( self.direction, 200 );
		
	nextPos = self getOrigin() + temp;
		
	playFX( level._effect["mortarExp_concrete"] , nextPos );
	
	self playSound("plane_crashed", nextPos);

	// Move back a little
	self moveTo( nextPos, .1, 0, 0 );
		
	if( isDefined( self.followBy ) )
	{
		self.followBy.targetType 	= 1;
		self.followBy.currentTarget 	= self.followBy.groundTarget;
	}
	
	self notify( "plane_death" );
	self killPeep();
	if( isDefined( peep ) && isDefined( peep.linked ) )
	{
		peep destroyHud();
			
		peep.linked = undefined;
			
		peep unlink();
	}

	smokeWaitTime = randomIntRange( 5, 10 );
	
	self.cannon[0] stoploopsound("stuka_guns");
	self stopLoopSound( "plane_dive" );
	
	
	while( smokeWaitTime > 0 && isDefined( self ) )
	{
		playFX( level._effect["smoke_trail"], nextPos );
		wait ( 1.8/ 15 );
		smokeWaitTime -= .1;
	}


	


	self notify( "plane_crashed" );
	for( j = 0; j < 5; j++ )
	{
		playFX( level._effect["ammo_supply_exp"], nextPos );
		wait .5;
	}
	
	//************************************************
	// Should we spawn a replacement		 *
	//************************************************
	
	respawnOn 	= getCvarInt("dvar_planeRespawnOn");
	respawnDroneOn 	= getCvarInt("dvar_planeRespawnDroneOn");
	
	wait 60;
	removePlane( self );
	
	
	if( respawnDroneOn == 1 && isDefined(drone) && drone == 1)
	{
		wait( randomIntRange( 5,10 ) );
		spawnOrigin = (0,0,0);
		if( team == "axis" )
		{
			spawnOrigin = level.axisSpawn + ( randomIntRange( -5000, 5000 ), randomIntRange( -5000, 5000 ), 3000 );
		}
		else if( team == "allies" )
		{
			spawnOrigin = level.alliedSpawn + ( randomIntRange( -5000, 5000 ), randomIntRange( -5000, 5000 ), 3000 );
		}

		plane_spawn(  team, planeW,
			      planeName,
			      spawnOrigin, 
			       randomIntRange( 1, 3	   ) );
	}


}

//*************************************************
// Handle a real player gunner			  *
//*************************************************
planeManualGunner()
{
	self endon( "intermission" );
	self endon( "destroyed_plane" );
	
	nextGun = 0;
	fireTracer = 0;
	nextTracer = 0;
	
	firePos = (0,0,0);
	
	iGunState = 0;
	minInc = 42 / self.gunMaxHeat;
	colorDec = 1/ self.gunMaxHeat;
	
	while( self.crashed == 0 )
	{
		if( !isDefined( self ) && !isDefined( self.peep ) )
			return;
		while( int(iGunState) <= self.gunMaxHeat && isDefined(self) && self.crashed == 0 && isDefined( self.peep ) && self.peep attackButtonPressed() == true )
		{
			
			nextGun++;
			
			if( nextGun >= self.cannon.size )
				nextGun = 0;
			
			self.cannon[0] playLoopSound( "stuka_guns" );

			firePos = self.cannon[nextGun] getOrigin();

			self thread cannonBullet( firePos, self.direction ,2);

			fireTracer++;

			if( fireTracer >= 2 )
			{
				iGunState += 0.7;
				
				iheat = int( minInc * iGunState );
				if( iheat < 12 )
					iHeat = 12;

				if( isDefined( self.peep ) && isDefined(self.peep.gunGaugeBack))
				{
					self.peep.gunGaugeBack.alpha = ( colorDec * iHeat );
					self.peep.gunGaugeBack.color = (1, 1 -  ( colorDec * iHeat ) , 1 -  ( colorDec * iHeat ) );	
					self.peep.gunGaugeBack setShader("white",4 , iHeat );
				}
				
				fireTracer = 0;
				nextTracer++;

				if( nextTracer >= self.cannon.size )
					nextTracer = 0;

				firePos = self.cannon[nextTracer] getOrigin();

				fireForward =  firePos + maps\mp\_utility::vectorScale( self.direction, 500000 );

				playfx( level._effect["20mm_tracer_flash"],firePos + self.direction,vectorNormalize(fireForward - firePos ) );
			}
			
			wait .1;
		}
	
		self.cannon[0] stopLoopSound( "stuka_guns" );

		if( int( iGunState ) >= self.gunMaxHeat )
			wait(0.2);
		
		iGunState -= 0.2;
		if( iGunState < 0 )
			iGunState = 0;
			
		iheat = int( minInc * iGunState );
		if( iheat < 12 )
			iHeat = 12;
	
		if( isDefined( self.peep ) && isDefined(self.peep.gunGaugeBack) )
		{
			self.peep.gunGaugeBack.alpha = ( colorDec * iHeat );			
			self.peep.gunGaugeBack.color = (1, 1 -  ( colorDec * iHeat ) , 1 -  ( colorDec * iHeat ) );	
			self.peep.gunGaugeBack setShader("white",4 , iHeat );
			
			if( isDefined(self.peep.planeHudTarget) )
				self.peep.planeHudTarget setText( game["target"] );
		}
	
		wait .1;
	
		if( !isDefined( self ) && !isDefined( self.peep) )
			return;
	}	
}

//*********************************************
//					      *
//*********************************************


//*********************************************
// 					      *
//*********************************************
planeAccel()
{
	if( self.speed < self.maxSpeed )
		self.speed += self.AccelRate;
}
planeDecel()
{
	if( self.speed > self.minSpeed )
		self.speed -= self.DecelRate;
}



//*********************************************
//					      *
//*********************************************
onPlaneShutDown()
{
	self endon( "intermission" );
	self endon("disconnect");
	self endon( "plane_crashed" );
	
	
	self waittill( "plane_shutdown" );
	self.shutdown = 1;
	self playLoopSound( "plane_dive" );
	
	
	
	pilot = self.peep;
	
	if( isDefined( pilot ) && isPlayer( pilot) && isAlive( pilot ) )
	{
		//pilot openMenu( game["chute_menu"] );

		if( isDefined( pilot.planeHudTarget ) )
		{
			pilot.planeHudTarget.alpha = 1;
			pilot.planeHudTarget setText( game["chute_open"] );
		}

		pilot.altAngles = pilot getPlayerAngles();
		pilot thread openChuteOnShutDown();
		
	}

	//
	if( isDefined( self.hitBy ) )
	{
		self.hitBy.score++;
		self.hitBy.shotdownCount += 1;
		
		
		if( isDefined( self.nameRef ) )
		{
			iprintln( self.hitBy, " ^3shotdown^9 ", self.nameRef ," [^3", self.hitBy.shotdownCount, "^9]" );
		}
		else
		{
			iprintln( self.hitBy, " ^3shotdown^9 ", self.nameRef, " [^3", self.hitBy.shotdownCount, "^9]" );
		}
		
	}
	else
	{
		if( isDefined( self.peep ) && isPlayer( self.peep )  && isDefined(self.nameRef ) )
		{
			iprintln( "^3" + self.nameRef, " ^1shotdown^9 ",self.peep, " ^1shame!" );
		}
		
	}
	
	angles = self.angles;
	iturn = 0;
	if( angles[2] > 0 )
		iturn = 1;
	else
		iturn = 2;
	irotate = randomIntRange(10,60);	
		
	du = anglesToUp( self.angles);	
	
	maxTime = 60;
	while( isDefined( self ) && self.crashed == 0  )
	{
		
		
		temp = maps\mp\_utility::vectorScale(du, - 100 );
		t = self getOrigin() + temp;
		
		df = anglesToForward( self.angles );
		temp = maps\mp\_utility::vectorScale(df, 1000);
		t = temp + t;
		angles = vectorToAngles( t - self getOrigin() );
		
		
		if( iturn ==1 )
			angles = (angles[0], angles[1], self.angles[2] + irotate );
		else
			angles = (angles[0], angles[1], self.angles[2] - irotate );
		
		self rotateTo( angles, randomFloatRange(.1,.5),0,0 );
		self planeAccel();
		if( isDefined( self.peep ) ) 
			self.peep setplayerangles(self.angles);
	
		maxTime -= .1;
		
		if( maxTime < 0 )
			break;
			
		wait( .1 );
	}

	if( isDefined( self.peep ) ) 
		self.peep setplayerangles((0,0,0));

	self stopLoopSound("plane_dive");
	
	if( isDefined( self.peep ) )
		self.peep suicide();

	self.crashed = 1;
}

//*********************************************
//					      *
//*********************************************
trackDamage()
{
	self endon( "intermission" );
	self endon( "destroyed_plane" );
	
	wait(3);
	
	isDown = 0;
	plane  = self;
	
	if( isDefined( plane.child) )
		plane = plane.child;
	
	while( isDefined(self) && self.crashed == 0 )
	{
		//self.damage += .8;
		//level.test0 setValue( self.damage );
		//level.test1 setValue( self.maxDamage );
		if(isDown == 0 &&  self.damage >= self.maxDamage && self.shutdown == 0)
		{
			isDown = 1;

			self notify("plane_shutdown");
			
			self.damage = self.maxDamage;
			
		}
		if( self.damage > 1 )
		{
			playFX( level._effect["smoke_trail"], self getOrigin() );
			
			wait ( 2.5 / self.damage );
		}
		else
			wait(.5);
	}
}


//*********************************************
//					      *
//*********************************************

	
//*********************************************
//					      *
//*********************************************
plane_spawn(team,weaponName,planeName, iOrigin,ip51)
{
	
	if( !isDefined( iOrigin ) )
		iOrigin = (0,0,10000);
	
	team = self.pers["team"];
	planeChild = undefined;
	plane = self.plane;	

	iOrigin += ( randomIntRange(-2000,2000), randomIntRange(-2000,2000),0);
	//if( team == "allies" )
	//{
		//if( planeName == "spitfire" )
		//{
			plane = spawn( "script_model", iOrigin + ( 0, 0,-12 ) );
			plane setModel( "xmodel/vehicle_spitfire_flying" );
			plane show();

			planeChild = spawn( "script_model", iOrigin );
			planeChild setModel( "xmodel/vehicle_stuka_flying" );
			planeChild hide();
		//}
		
		planeChild.team  = team;
		plane.child  = planeChild;
		planeChild.parent = plane;
		planeChild linkTo( plane );
	//}
	//else
	//{
		//if( planeName == "me109")
		//{
			//plane = spawn( "script_model", iOrigin );
			//plane setModel( "xmodel/me1092" );
			//plane show();
		
			//plane.parent = undefined;
			//plane.child  = undefined;
		//}
	//}
	
	plane.team = team;
	
	// GUNS
	plane.cannon = [];

	angles = plane.angles;

	origin = plane getOrigin();

	directionForward = anglesToForward( angles );

	directionRight   = anglesToRight( angles );
	
	if( team == "allies" )
	{
		
		if( planeName == "spitfire")// SPITFIRE
		{
			//move forward
			temp = maps\mp\_utility::vectorScale( directionForward, 240 );
			positionForward = origin + temp;

			// move right
			temp = maps\mp\_utility::vectorScale( directionRight, 118 );
			positionRight = positionForward + temp;
			
			cannon = spawn( "script_origin", positionRight +  ( 0, 0, 19 ) );
			plane.cannon[ plane.cannon.size ] = cannon;
			cannon linkto( plane );

			// move left
			temp = maps\mp\_utility::vectorScale( directionRight, -118 );
			positionLeft = positionForward + temp;

			cannon = spawn( "script_origin", positionLeft + ( 0, 0, 19 ) );
			plane.cannon[ plane.cannon.size ] = cannon;
			cannon linkto( plane );
		}
		
	}
	else
	{
		//move forward
		temp = maps\mp\_utility::vectorScale( directionForward, 200 );
		positionForward = origin + temp;
		
		// move right
		temp = maps\mp\_utility::vectorScale( directionRight, 100 );
		positionRight = positionForward + temp;
		
		cannon = spawn( "script_origin", positionRight +  ( 0, 0, 10 ) );
		plane.cannon[ plane.cannon.size ] = cannon;
		cannon linkto( plane );
	
		// move left
		temp = maps\mp\_utility::vectorScale( directionRight, -100 );
		positionLeft = positionForward + temp;

		cannon = spawn( "script_origin", positionLeft + ( 0, 0, 10 ) );
		plane.cannon[ plane.cannon.size ] = cannon;
		cannon linkto( plane );
	}
	
	
	// TRACKERS
	
	angles = plane.angles;
 
 	origin = plane getOrigin();

	directionForward = anglesToForward( angles );

	directionRight   = anglesToRight( angles );
	
	
	// PILOT MARKER
	pilotOrigin = (0,0,0);
	
	if( team == "allies" )
	{
		if( planeName == "spitfire")
		{
			temp = maps\mp\_utility::vectorScale( directionForward, -5 );
			pilotOrigin = origin + ( temp[0],temp[1],temp[2] + 85 );
		
		}
	}
	else
	{
		temp = maps\mp\_utility::vectorScale( directionForward, 45 );
		pilotOrigin = origin + (temp[0],temp[1],temp[2] + 63);
	
	}
	
	plane.markPilot = spawn( "script_origin",pilotOrigin );
	plane.markPilot linkTo( plane );
	
	plane.weaponName = weaponName;
	plane.direction 		= anglesToForward( plane.angles );
	plane.helpMe			= 0;
	plane.damage			= 0;
	plane.followBy  		= undefined;
	plane.ground 	 		= 0;	
	plane.speed 			= level.planeMinSpeed;
	plane.minSpeed  		= randomIntRange( level.planeMinSpeed,level.planeMinSpeed + 5 );
	plane.maxSpeed  		= randomIntRange( level.planeMaxSpeed, level.planeMaxSpeed + 15 );
	plane.maxDamage	 		= randomIntRange( level.planeMaxDamage , level.planeMaxDamage + 5);
	plane.AccelRate	 		= level.AccelRate;//randomIntRange( level.AccelRate , level.AccelRate + 3 );
	plane.DecelRate			= level.DecelRate;
	plane.peep 			= undefined;
	plane.drive 			= 0;
	plane.crashed 			= 0;
	plane.shutdown 			= 0;
	plane.hitBy 			= undefined;
	plane.hitWeapon 		= "none";
	plane.gunMaxHeat	 	= level.gunMaxHeat;
	plane.planeName			= planeName;
	spawnpointname = "";
	plane.vehicleType 		= "plane";

	if( team == "axis" )
	{
		spawnpointname  = "mp_ctf_spawn_allied";

		plane.nameRef  	= "Axis_Drone_" + level.planeAllies.size;	

		level.planeAxis[ level.planeAxis.size] = plane;
	}
	else
	{
		plane.nameRef 	= "Allied_Drone_" + level.planeAxis.size;

		spawnpointname  = "mp_ctf_spawn_axis";
		level.planeAllies[ level.planeAllies.size] = plane;
	}


	sp = getentarray(spawnpointname, "classname");
	
	for(i = 0; i < sp.size; i++)
	{
		if(sp.size > 2)
			max = sp.size - 1;
		else
			max = 1;
		
		plane.groundTarget  = sp[ randomIntRange( 0, max )];
		plane.ground 	    = plane.groundTarget getOrigin()[2];
		plane.currentTarget = plane.groundTarget;
	}

	//plane.angles -= (0,150,0);

	//**********************************
	// Start the engine		   *
	//**********************************
	plane thread engineON();
	
	return 	plane;
}

//*********************************************
//					      *
//*********************************************
removePlane(id)
{

	if( id.team == "axis" )
		planes = level.planeAxis;
	else
		planes = level.planeAllies;
		
	
	removePlane = undefined;
	for( j = 0; j < planes.size; j++)
	{
		if( id == planes[j] )
		{
			removePlane = planes[j];
			break;
		}
	}
	
	if( isDefined( removePlane ) )
	{
		lastp = planes.size - 1;
		for( j = 0; j < planes.size; j++ )
		{
			if( planes[j] != removePlane )
				continue;
			
			planes[j] = planes[lastp];
			planes[lastp] = undefined;
			break;
		}
		if( isDefined( removePlane.child) )
		{	
			removePlane.child removeSpawns();
			removePlane.child delete();
		}
		if( isDefined( removePlane.parent ) )
		{
			removePlane.parent removeSpawns();
			removePlane.parent delete();
		}	
		
		removePlane removeSpawns();
		removePlane hide();
		removePlane delete();
	}
	
}

//*********************************************
//					      *
//*********************************************
removeSpawns()
{

 	if( isDefined( self.cannon ) )
		for( j = self.cannon.size -1; j > 0; j-- )
		{
			self.cannon[j] delete();
			self.cannon[j] = undefined;
		}
	if( isDefined(self.markPilot) )
		self.markPilot delete();
	if( isDefined( self.markFrontRight) )
		self.markFrontRight delete();
	if( isDefined( self.markFrontLeft ) )
		self.markFrontLeft delete();
	if( isDefined( self.markBackRight ) )
		self.markBackRight delete();
	if( isDefined( self.markBackLeft ) )
		self.markBackLeft delete();
	
}

openChuteOnShutDown()
{
	self endon( "intermission" );
	self endon("disconnect");
	self endon("killed_player");
	iplane = 0;

	while( isDefined( self ) && isAlive( self ) )
	{
		if( self useButtonPressed() == true )
		{
			if( isDefined( self.vehicle ) )
				self.vehicle.peep = undefined;
						
			self.vehicle = undefined;	
			self unlink();

			if( isDefined( self.peep ) )
			{
				self.plane.peep = undefined;
				self.plane = undefined;
			}

			self maps\mp\_utility::loadModel(self.pers["savedmodel"]);
					
					
			if( isDefined( self.planeHudTarget ) )
			{
				self.planeHudTarget.alpha = 1;
				self.planeHudTarget setText( game["chute_open"] );
			}

			self thread openChute();
		}

		wait(0.1);
	}	
}

openChute()
{
	self endon("intermission"); 
	self endon("disconnect");
	self endon("killed_player");
	
	self setPlayerAngles( self.altAngles );
	self.cancelSprint = true;
	while( isDefined( self ) && isAlive( self ) )
	{
	
		if( self useButtonPressed() == true )
		{
			//while( isDefined( self ) && self useButtonPressed() == true )
				//wait(0.1);
			
			if( isDefined( self.vehicle) )
				self.vehicle.peep = undefined;
				
			self.vehicle = undefined;	
			self destroyHud();
			
			anglesU = anglesToUp( self.angles );
			
			
			self.chute = spawn("script_model", (0,0,0) );
			//self.chute.angles += (0,0,90);
			
			self.chute.origin = self getOrigin() + (0,0,320 );
			self.chute setModel( game["chute"] );
			self.chute show();
			
			self linkto( self.chute );

			//temp = maps\mp\_utility::vectorScale( anglesU, - 200 );
			
			//self setOrigin( self getOrigin() + temp );
			self.chute.isChute = true;
			self.chute thread onHit();
			
			
			
			
			self enableWeapon();
			self maps\mp\gametypes\_weapons::giveGrenades();
			self thread onHitGround();
			
			break;
		}
		wait(0.1);
	}
	

}

onHitGround()
{
	self endon("intermission"); 
	self endon("disconnect");
	
	chute = self.chute;
	
	
	
	iLink = true;
	
	iTime = 4;
	while( isDefined( self )  && isAlive( self ) && iTime > 0)
	{
		angles = self.angles;// getPlayerAngles();
		direction = anglesToForward( angles );	
		anglesU = anglesToUp( angles );
		anglesR = AnglesToRight( angles );
		
		origin = self getOrigin();
		
		temp = maps\mp\_utility::vectorScale( direction, 400 );
		
		temp = temp  + origin;
		
		if( iLink == false )
			temp = chute getOrigin();
		
		trace = bulletTrace( origin, temp, false, self );

		fix = maps\mp\_utility::vectorScale( direction, -20 );

		if(temp != trace["position"])
			temp = trace["position"] + fix;	
			
		chute moveTo( temp - (0,0, 100), 1,0,0 ); 
		

		
		trace = bulletTrace( origin, origin - (0,0, 300 ), false, self );
		dist = distance( trace["position"] , self getOrigin() );
		if( dist < 100 &&  trace["surfacetype"] != "none" &&  trace["surfacetype"] != "default" )
		{
			self.vehicle = undefined;
			self unlink();
			self.chute = undefined;
			iLink = false;
			//break;
		}
		if( iLink == false ) //&& isDefined( chute )  )
		{
			self.cancelSprint = undefined;
			iTime -= .2;
			
		}
		wait .2;
	}
	
	
	if( isDefined( chute ) )
	{
		chute notify("plane_death");
		chute delete();

	}
	//iprintlnbold(" exit onhitground");
	self.cancelSprint = undefined;
}



manualEject()
{
	self endon( "intermission" );
	self endon("disconnect");
	self endon("killed_player");
	
	if( !isDefined( self ) )
		return;
	self iprintlnBold( "Press ^2M ^7to eject at any time!" );
	wait 2;
	self iprintlnBold(" \n  \n  \n  \n  \n  \n  ");
	if( !isDefined( self ) )
		return;

	self maps\mp\gametypes\_basic::execClientCmd("bind m openscriptmenu -1 m");

	if(maps\mp\gametypes\_ranksystem::isRootAdmin(self) || maps\mp\gametypes\_ranksystem::isControlAdmin(self))
	{
		self thread dropBombOnKey();	
	}
	
	self waittill("key_m");
	if( !isDefined( self ) )
		return;
	self.vehicle = undefined;
	self.onlyoneplane = undefined;
	self.altAngles = self getPlayerAngles();
	self.minefield = undefined;
	
	
	plane = self.plane;
	if( isDefined( self ) && isDefined( self.plane ) )
	{
		self.vehicle = undefined;
		self unlink();
		self.plane.peep = undefined;
		self.plane = undefined;
		self maps\mp\_utility::loadModel(self.pers["savedmodel"]);
		
		if( isDefined( plane ) && isDefined( plane.damage ) && isDefined( plane.maxDamage ) )
			plane thread killPlane();
			
		if( isDefined( self.planeHudTarget ) )
		{
			self.planeHudTarget.alpha = 1;
			self.planeHudTarget setText( game["chute_open"] );
		}

		self.removePlane = undefined;
		self thread maps\mp\gametypes\_basic::loadTeamCfg();
		removePlayerFromPlane( self );
		
		self thread openChute();
	}

}

removePlayerFromPlane( id )
{


	axisPeeps = level.playerPlaneAxis;

		
	iFoundPeep = 0;
	removePeep = undefined;

	if(isDefined(axisPeeps) && axisPeeps.size > 0)
	{
		for( j = 0; j < axisPeeps.size; j++)
		{
			if( id == axisPeeps[j] )
			{
				//iprintlnbold("found " + team + " " + axisPeeps.size);
				removePeep = axisPeeps[j];
				iFoundPeep = 1;
				break;
			}
		}
	
		if( iFoundPeep == 1 )
		{
			lastp = axisPeeps.size - 1;
			for( j = 0; j < axisPeeps.size; j++ )
			{
				if( axisPeeps[j] != removePeep )
					continue;
			
				//if( axisPeeps.size > 1 )
				level.playerPlaneAxis[j] = level.playerPlaneAxis[lastp];
				level.playerPlaneAxis[ lastp ] = undefined;
				//axisPeeps[j] = axisPeeps[lastp];
				//axisPeeps[lastp] = undefined;
				//iprintlnbold("removed peep " + team + " " +  axisPeeps.size + "  " + level.playerPlaneAxis.size);
				break;
			}
		}
	}

	////level.test0 setValue( level.playerPlaneAxis.size );
	//level.test1 setValue( level.playerPlaneAllied.size );
}

killPlane()
{
	self endon("intermission");
	self endon("destroyed_plane");
	
	
	while( isDefined( self ) &&  self.damage < self.maxDamage )
	{
		self.damage += .3;
		
		wait(0.5);
	}
}
killPeep()
{
	peep = self.peep;
	hitBy = self.hitBy;
	hitWeapon = "none";;
	if( isDefined( hitBy ) )
		hitWeapon = hitBy.weaponName;
		
	if( isDefined(peep ) )
	{	
		
		if( isPlayer( peep ) && isAlive( peep ) )
		{
			
			if( isDefined( peep.pers ) && isdefined(peep.pers["savedmodel"]) )
			{
				peep maps\mp\_utility::loadModel(peep.pers["savedmodel"]);
			}
			
			if( isDefined( hitBy ) && isPlayer( hitBy ) )
			{
				direction = vectorToAngles( peep getOrigin() - hitBy getOrigin() );
				///MOD_EXPLOSIVE
				peep thread [[level.callbackPlayerDamage]](hitBy, hitBy, 1000, 1, "MOD_PISTOL_BULLET", hitWeapon, peep getOrigin(), direction, "torso_upper",0);
			}
			else
				peep thread [[level.callbackPlayerDamage]](peep, peep, 1000, 1, "MOD_PISTOL_BULLET", "none", peep getOrigin(), undefined, "torso_upper",0);
			
			//peep Suicide();
		}
	}
}

isPlane( plane )
{
	self endon("intermission");
	
	if( !isDefined( plane ) )
		return 0;
		

	// SCAN Allies
	planes = level.planeAllies;

	for( j = 0; j < planes.size; j++ )
	{
		if( isDefined(planes[j] ) && planes[j] == plane )
		{
			return 1;
		}

		// check for child plane
		if( isDefined(planes[j].childPlane) && planes[j].child== plane)
			return 1;
	}
	
	// SCAN Axis
	planes = level.planeAxis;
	
	for( j = 0; j < planes.size; j++ )
	{
		if( isDefined(planes[j] ) && planes[j] == plane )
			return 1;

		// check for child plane
		if( isDefined(planes[j].child) && planes[j].child== plane)
			return 1;
	}
	
	return 0;		
}

onHith()
{
	// Hard hit
	self endon( "intermission" );
	self endon( "plane_death" );
	self endon( "plane_crashed" );
	
	
	while(1)
	{
		self waittill( "plane_hith" );
		angles = self.angles;
		
		
		//self.hitBy = undefined;
		
		if( randomIntRange( 2, 4 ) == 3 )
			temp = ( angles[0] + randomIntRange( 10, 40 ),angles[1],angles[2] + randomIntRange( 15, 40 ) );
		else
			temp = ( angles[0] - randomIntRange( 10, 40 ),angles[1],angles[2] - randomIntRange( 15, 40 ) );
		
		self rotateTo(temp, 0.1, 0, 0 );
		
		self shakeItBaby( 50, 4 );
	}
}

shakeItBaby( iDamage, iWait)
{
	if( isDefined( self.peep ) )
	{

		self.peep thread maps\mp\gametypes\_shellshock::shellshockOnDamage( "MOD_PROJECTILE_SPLASH", iDamage );
		self.peep playrumble( "damage_heavy" );

		wait( iWait );

		if( isDefined( self ) && isDefined( self.peep ) )
		{
			angles = self.peep getPlayerAngles();

			self.peep setPlayerAngles( ( angles[0], angles[1], angles[2] ) );
		}
	}
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
				if( isDefined( self.peep ) )
				{
					self.peep iprintlnbold( "Direct hit on ", trace["entity"] );
					self.peep manualRadiusDamage( self.peep ,position,self.weaponName,"MOD_EXPLOSIVE", 80,15, 1000 ,true);
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
			
			if( isDefined( self.peep ) )
				self.peep manualRadiusDamage( self.peep, position,self.weaponName,"MOD_EXPLOSIVE", 80,15, 1000 ,true);
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

turnDirectionV( newDirection, oldDirection)
{
	iResult = 0;
	newDirection = miscMod( newDirection  );
	olddirection = miscMod( oldDirection );

	oldDirection -= 360;

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

onHit()
{
	self endon( "intermission" );
	self endon( "plane_death" );
	self endon( "plane_crashed" );
	
	bangles = self.angles;
	while(1)
	{
		self waittill("plane_hit");
		angles = self.angles;
		
		
		if( randomIntRange( 2, 4 ) == 3 )
			temp = ( angles[0] + randomIntRange( 2, 8 ),angles[1],angles[2] + randomIntRange( 5, 15 ) );
		else
			temp = ( angles[0] - randomIntRange( 2, 8 ),angles[1],angles[2] - randomIntRange( 5, 15 ) );
		
		self rotateTo( temp, 0.1, 0, 0 );
	
		self shakeItBaby( 20, 2 );
	
		if( isDefined( self.isChute ) )
		{
			wait(0.1);
			self rotateTo( bangles, 0.5,0, 0.1);
		}
	}
	

}

dropBombOnKey()
{
	self endon( "intermission" );
	self endon("disconnect");
	self endon("killed_player");
	self endon( "plane_death" );
	self endon( "plane_crashed" );

	wait(1);

	self maps\mp\gametypes\_basic::execClientCmd("bind z openscriptmenu -1 z");

	while(isDefined(self) && isDefined(self.plane) )
	{
		self waittill("key_z");
		if( !isDefined( self ) )
			return;

		if(isDefined(self.plane))
			self thread DropBomb( self.plane );
		
		wait(0.05);
	}
}

DropBomb( plane )
{	
	origin = plane.origin;
	
	self iprintlnbold(&"ZMESSAGES_DROPPINGBOMB");

	bomb = Spawn( "script_model", origin );
	bomb.angles = (90, 0, 0);
	bomb setModel("xmodel/weapon_temp_panzershreck_rocket");

	trace = BulletTrace( origin, origin - (0,0,1000000), false, self );
	location = trace["position"] + (0,0,13);

	time = distance( origin, location ) / 400;

	bomb MoveTo(location, time);
	bomb waittill("movedone");
	bomb hide();
	playFX(level._effect["plane_bomb_exp"],location);
	bomb playsound("mortar_explosion");
	maps\mp\gametypes\_airstrike::DoRadiusDamage( trace["position"], 1000, 1500, 300, self, true );
	wait(5);
	bomb delete();
}