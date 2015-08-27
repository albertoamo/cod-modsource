main()
{
	level.woodmovetime = 0.75;
	level.waitabit = 0.25;
	thread fixstrings();
	thread init();
	thread init2();
	thread init3();
}

fixstrings()
{
	trigger = getentarray("allyfix","targetname");

	for(i=0; i<trigger.size; i++)
	{
			trigger[i] setHintString("Fix Barricade ");
	}
}

init()
{
	level.wawtrig = getentarray("zomdmg1","targetname");
	
	level.board1 = getentarray("zomwood1","targetname");
	level.board2 = getentarray("zomwood2","targetname");
	level.board3 = getentarray("zomwood3","targetname");
	level.board4 = getentarray("zomwood4","targetname");
	level.board5 = getentarray("zomwood5","targetname");
	
	level.alltrig = getentarray("allyfix","targetname");
	
	for(i=0; i<level.wawtrig.size; i++)
	{
		level.wawtrig[i] thread axis_start(i);
	}
}

init2()
{
	for(i=0; i<level.alltrig.size; i++)
	{
		level.alltrig[i] thread allies(i);
	}
}

init3()
{
	for(i=0; i<level.board1.size; i++)
	{
		level.board1[i] thread applyfixingstate(i);
	}
}

applyfixingstate(entnum)
{
	level.board1[entnum].wawfixing = 0;
	level.board2[entnum].wawfixing = 0;
	level.board3[entnum].wawfixing = 0;
	level.board4[entnum].wawfixing = 0;
	level.board5[entnum].wawfixing = 0;
	
	level.board1[entnum].wawfixed = 1;
	level.board2[entnum].wawfixed = 1;
	level.board3[entnum].wawfixed = 1;
	level.board4[entnum].wawfixed = 1;
	level.board5[entnum].wawfixed = 1;
	
	level.wood1org[entnum] = self getorigin();
	level.wood2org[entnum] = level.board2[entnum] getorigin();
	level.wood3org[entnum] = level.board3[entnum] getorigin();
	level.wood4org[entnum] = level.board4[entnum] getorigin();
	level.wood5org[entnum] = level.board5[entnum] getorigin();
	
	level.wood1brokenorg[entnum] = level.wood1org[entnum] - (0,0,500);
	level.wood2brokenorg[entnum] = level.wood2org[entnum] - (0,0,500);
	level.wood3brokenorg[entnum] = level.wood3org[entnum] - (0,0,500);
	level.wood4brokenorg[entnum] = level.wood4org[entnum] - (0,0,500);
	level.wood5brokenorg[entnum] = level.wood5org[entnum] - (0,0,500);
}

broken()
{
	wait(0.1);
	self hide();
}

broken_show()
{
	wait(0.6);
	self show();
}

axis_start(entnum)
{	
	while(1)
	{
		self waittill("damage",dmg,other);
		if(other.pers["team"] == "axis" && dmg > 40)
		{
			if( (level.board1[entnum].wawfixed == 1) && (level.board1[entnum].wawfixing == 0) )
			{
					level.board1[entnum].wawfixing = 1;
					
					level.board1[entnum] notsolid();
					
					if( isdefined(level.board1[entnum].target) && level.board1[entnum].target == "broken")
					{
						level.board1[entnum] thread broken();
					}
					
					//level.board1[entnum] movey(-10,level.woodmovetime);
					//level.board1[entnum] movez(level.movenegz,level.woodmovetime);
					level.board1[entnum] moveto(level.wood1brokenorg[entnum],level.woodmovetime);
					wait(level.waitabit);
					level.board1[entnum] waittill("movedone");
					
					level.board1[entnum].wawfixed = 0;
					level.board1[entnum].wawfixing = 0;
			}
			else if( (level.board2[entnum].wawfixed == 1) && (level.board2[entnum].wawfixing == 0) )
			{
					level.board2[entnum].wawfixing = 1;
					
					level.board2[entnum] notsolid();
					
					if( isdefined(level.board2[entnum].target) && level.board2[entnum].target == "broken")
					{
						level.board2[entnum] thread broken();
					}
					
					//level.board2[entnum] movey(-10,level.woodmovetime);
					//level.board2[entnum] movez(level.movenegz,level.woodmovetime);
					level.board2[entnum] moveto(level.wood2brokenorg[entnum],level.woodmovetime);
					//level.board2[entnum] waittill("movedone");
				//	wait(level.woodmovetime);
					wait(level.waitabit);
					level.board2[entnum] waittill("movedone");
					
					level.board2[entnum].wawfixed = 0;
					level.board2[entnum].wawfixing = 0;
			}
			else if( (level.board3[entnum].wawfixed == 1) && (level.board3[entnum].wawfixing == 0) )
			{
					level.board3[entnum].wawfixing = 1;
					
					level.board3[entnum] notsolid();
					
					if( isdefined(level.board3[entnum].target) && level.board3[entnum].target == "broken")
					{
						level.board3[entnum] thread broken();
					}
					
					//level.board3[entnum] movey(-10,level.woodmovetime;
					//level.board3[entnum] movez(level.movenegz,level.woodmovetime);
					level.board3[entnum] moveto(level.wood3brokenorg[entnum],level.woodmovetime);
					//level.board3[entnum] waittill("movedone");
					//wait(level.woodmovetime);
					wait(level.waitabit);
					level.board3[entnum] waittill("movedone");
					
					level.board3[entnum].wawfixed = 0;
					level.board3[entnum].wawfixing = 0;
			}
			else if( (level.board4[entnum].wawfixed == 1) && (level.board4[entnum].wawfixing == 0) )
			{
					level.board4[entnum].wawfixing = 1;
					
					level.board4[entnum] notsolid();
					
					if( isdefined(level.board4[entnum].target) && level.board4[entnum].target == "broken")
					{
						level.board4[entnum] thread broken();
					}
					
					//level.board4[entnum] movey(-10,level.woodmovetime);
					//level.board4[entnum] movez(level.movenegz,level.woodmovetime);
					level.board4[entnum] moveto(level.wood4brokenorg[entnum],level.woodmovetime);
					//level.board4[entnum] waittill("movedone");
					//wait(level.woodmovetime);
					wait(level.waitabit);
					level.board4[entnum] waittill("movedone");
					
					level.board4[entnum].wawfixed = 0;
					level.board4[entnum].wawfixing = 0;
			}
			else if( (level.board5[entnum].wawfixed == 1) && (level.board5[entnum].wawfixing == 0) )
			{
					level.board5[entnum].wawfixing = 1;
					
					level.board5[entnum] notsolid();
					
					if( isdefined(level.board5[entnum].target) && level.board5[entnum].target == "broken")
					{
						level.board5[entnum] thread broken();
					}
					
					//level.board5[entnum] movey(-10,level.woodmovetime);
					//level.board5[entnum] movez(level.movenegz,level.woodmovetime);
					level.board5[entnum] moveto(level.wood5brokenorg[entnum],level.woodmovetime);
					//level.board5[entnum] waittill("movedone");
					//wait(level.woodmovetime);
					wait(level.waitabit);
					level.board5[entnum] waittill("movedone");
					
					level.board5[entnum].wawfixed = 0;
					level.board5[entnum].wawfixing = 0;
			}
			
		}
	}
}

allies(entnum)
{
	while(1)
	{
	self waittill("trigger",user);
	if( (user.pers["team"] == "allies") && (user getstance() != 2) )
	{
		if( (level.board5[entnum].wawfixed == 0) && (level.board5[entnum].wawfixing == 0) )
		{	
			level.board5[entnum].wawfixing = 1;
			wait(.5);
			
			if( isdefined(level.board5[entnum].target) && level.board5[entnum].target == "broken")
			{
				level.board5[entnum] thread broken_show();
			}
			
			//level.board5[entnum] movey(10,level.woodmovetime);
			//level.board5[entnum] movez(level.moveposz,level.woodmovetime);
			level.board5[entnum] moveto(level.wood5org[entnum],level.woodmovetime);
			//level.board5[entnum] waittill("movedone");
		//	wait(level.woodmovetime);
			wait(level.waitabit);
			level.board5[entnum] waittill("movedone");
			level.board5[entnum] solid();
			
			if(isdefined(user))
			{
				user thread maps\mp\gametypes\_basic::updatePower(10);
			}
				
			level.board5[entnum].wawfixed = 1;
			level.board5[entnum].wawfixing = 0;
		}
		else if( (level.board4[entnum].wawfixed == 0) && (level.board4[entnum].wawfixing == 0) )
		{	
			level.board4[entnum].wawfixing = 1;
			wait(.5);
			
			if( isdefined(level.board4[entnum].target) && level.board4[entnum].target == "broken")
			{
				level.board4[entnum] thread broken_show();
			}
			
		  //level.board4[entnum] movey(10,level.woodmovetime);
			//level.board4[entnum] movez(level.moveposz,level.woodmovetime);
			//wait(level.woodmovetime);
			level.board4[entnum] moveto(level.wood4org[entnum],level.woodmovetime);
			//level.board4[entnum] waittill("movedone");
			//wait(level.woodmovetime);
			wait(level.waitabit);
			level.board4[entnum] waittill("movedone");
			level.board4[entnum] solid();
			
			if(isdefined(user))
			{
				user thread maps\mp\gametypes\_basic::updatePower(10);
			}
				
			level.board4[entnum].wawfixed = 1;
			level.board4[entnum].wawfixing = 0;
		}
		else if( (level.board3[entnum].wawfixed == 0) && (level.board3[entnum].wawfixing == 0) )
		{	
			level.board3[entnum].wawfixing = 1;
			wait(.5);
			
			if( isdefined(level.board3[entnum].target) && level.board3[entnum].target == "broken")
			{
				level.board3[entnum] thread broken_show();
			}
			
			//level.board3[entnum] movey(10,level.woodmovetime);
			//level.board3[entnum] movez(level.moveposz,level.woodmovetime);
			//wait(level.woodmovetime);
			level.board3[entnum] moveto(level.wood3org[entnum],level.woodmovetime);
			//level.board3[entnum] waittill("movedone");
		//	wait(level.woodmovetime);
		wait(level.waitabit);
		level.board3[entnum] waittill("movedone");
			level.board3[entnum] solid();
			
			if(isdefined(user))
			{
				user thread maps\mp\gametypes\_basic::updatePower(10);
			}
				
			level.board3[entnum].wawfixed = 1;
			level.board3[entnum].wawfixing = 0;
		}
		else if( (level.board2[entnum].wawfixed == 0) && (level.board2[entnum].wawfixing == 0) )
		{	
			level.board2[entnum].wawfixing = 1;
			wait(.5);
			
			if( isdefined(level.board2[entnum].target) && level.board2[entnum].target == "broken")
			{
				level.board2[entnum] thread broken_show();
			}
			
		//	level.board2[entnum] movey(10,level.woodmovetime);
			//level.board2[entnum] movez(level.moveposz,level.woodmovetime);
			//wait(level.woodmovetime);
			level.board2[entnum] moveto(level.wood2org[entnum],level.woodmovetime);
			//level.board2[entnum] waittill("movedone");
			//wait(level.woodmovetime);
			wait(level.waitabit);
					level.board2[entnum] waittill("movedone");
			level.board2[entnum] solid();
			
			if(isdefined(user))
			{
				user thread maps\mp\gametypes\_basic::updatePower(10);
			}
				
			level.board2[entnum].wawfixed = 1;
			level.board2[entnum].wawfixing = 0;
		}
		else if( (level.board1[entnum].wawfixed == 0) && (level.board1[entnum].wawfixing == 0) )
		{	
			level.board1[entnum].wawfixing = 1;
			wait(.5);
			
			if( isdefined(level.board1[entnum].target) && level.board1[entnum].target == "broken")
			{
				level.board1[entnum] thread broken_show();
			}
			
			//level.board1[entnum] movey(10,level.woodmovetime);
			//level.board1[entnum] movez(level.moveposz,level.woodmovetime);
			//wait(level.woodmovetime);
			level.board1[entnum] moveto(level.wood1org[entnum],level.woodmovetime);
			//level.board1[entnum] waittill("movedone");
		//	wait(level.woodmovetime);
		wait(level.waitabit);
					level.board1[entnum] waittill("movedone");
			level.board1[entnum] solid();
			
			if(isdefined(user))
			{
				user thread maps\mp\gametypes\_basic::updatePower(10);
			}
				
			level.board1[entnum].wawfixed = 1;
			level.board1[entnum].wawfixing = 0;
		}
		
	}
	}
}

GetStance(checkjump)
{
	if(!isDefined(checkjump))
		checkjump = false;

	if( checkjump && !self isOnGround() ) 
		return 3;

	if(isdefined(self.awe_spinemarker))
	{
		distance = self.awe_spinemarker.origin[2] - self.origin[2];
//		distance2 = self.awe_eyemarker.origin[2] - self.origin[2];
//		self iprintln("distance2: " + distance2);
		if(distance<18)
			return 2;
		else if(distance<43)
			return 1;
		else
			return 0;
	}
	else
	{
/*		trace = bulletTrace( self.origin, self.origin + ( 0, 0, 80 ), false, undefined );
		top = trace["position"] + ( 0, 0, -1);//find the ceiling, if it's lower than 80

		bottom = self.origin + ( 0, 0, -12 );
		forwardangle = maps\mp\_utility::vectorScale( anglesToForward( self.angles ), 12 );

		leftangle = ( -1 * forwardangle[1], forwardangle[0], 0 );//a lateral vector

		//now do traces at different sample points
		//there are 9 sample points, forming a 3x3 grid centered on player's origin
		//and oriented with the player's facing
		trace = bulletTrace( top + forwardangle,bottom + forwardangle, true, undefined );
		height1 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top - forwardangle, bottom - forwardangle, true, undefined );
		height2 = trace["position"][2] - self.origin[2];
	
		trace = bulletTrace( top + leftangle, bottom + leftangle, true, undefined );
		height3 = trace["position"][2] - self.origin[2];
	
		trace = bulletTrace( top - leftangle, bottom - leftangle, true, undefined );
		height4 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top + leftangle + forwardangle, bottom + leftangle + forwardangle, true, undefined );
		height5 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top - leftangle + forwardangle, bottom - leftangle + forwardangle, true, undefined );
		height6 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top + leftangle - forwardangle, bottom + leftangle - forwardangle, true, undefined );
		height7 = trace["position"][2] - self.origin[2];	

		trace = bulletTrace( top - leftangle - forwardangle, bottom - leftangle - forwardangle, true, undefined );
		height8 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top, bottom, true, undefined );
		height9 = trace["position"][2] - self.origin[2];	

		//find the maximum of the height samples
		heighta = getMax( height1, height2, height3, height4 );
		heightb = getMax( height5, height6, height7, height8 );
		maxheight = getMax( heighta, heightb, height9, 0 );

		//categorize stance based on height
		if( maxheight < 25 )
			stance = 2;
		else if( maxheight < 52 )
			stance = 1;
		else
			stance = 0;

		//self iprintln("Height: "+maxheight+" Stance: "+stance);
		return stance;*/
		return 0;
	}
}

checkroundrestart()
{
level.place1 = [];
level.place2 = [];
level.place3 = [];
level.place4 = [];
level.place5 = [];
level.place6 = [];

level.monitor = [];
level.action = [];

	while(1)
	{
	level waittill("waw_round_restart");
	for(i=0; i<level.board1.size; i++)
	{
		if(level.monitor[i] == 1 && level.action[i] == 0)
		{
			level notify("kill_axis" + i);
			
			level.action[i] = 1;
			level.board1[i] moveto(level.place1[i],0.0001);
			level.board1[i] rotateto((0,0,0),0.0001);
			level.board1[i] solid();
			level.board1[i] show();
			
			level.monitor[i] = 0;
			level.trig1[i] thread axis_start(i);
		}
		else if(level.monitor[i] == 2 && level.action[i] == 0)
		{
			level notify("kill_axis" + i);
			
			level.action[i] = 1;
			level.board2[i] moveto(level.place2[i],0.0001);
			level.board2[i] rotateto((0,0,0),0.0001);
			level.board2[i] solid();
			level.board2[i] show();
			
			level.board1[i] moveto(level.place1[i],0.0001);
			level.board1[i] rotateto((0,0,0),0.0001);
			level.board1[i] solid();
			level.board1[i] show();
			
			level.monitor[i] = 0;
			level.trig1[i] thread axis_start(i);
		}
		else if(level.monitor[i] == 3 && level.action[i] == 0)
		{
			level notify("kill_axis" + i);
			
			level.action[i] = 1;
			level.board3[i] moveto(level.place3[i],0.0001);
			level.board3[i] rotateto((0,0,0),0.0001);
			level.board3[i] solid();
			level.board3[i] show();
			
			level.board2[i] moveto(level.place2[i],0.0001);
			level.board2[i] rotateto((0,0,0),0.0001);
			level.board2[i] solid();
			level.board2[i] show();
			
			level.board1[i] moveto(level.place1[i],0.0001);
			level.board1[i] rotateto((0,0,0),0.0001);
			level.board1[i] solid();
			level.board1[i] show();
			
			level.monitor[i] = 0;
			level.trig1[i] thread axis_start(i);
		}
		else if(level.monitor[i] == 4 && level.action[i] == 0)
		{
			level notify("kill_axis" + i);
			
			level.action[i] = 1;
			level.board4[i] moveto(level.place4[i],0.0001);
			level.board4[i] rotateto((0,0,0),0.0001);
			level.board4[i] solid();
			level.board4[i] show();
			
			level.board3[i] moveto(level.place3[i],0.0001);
			level.board3[i] rotateto((0,0,0),0.0001);
			level.board3[i] solid();
			level.board3[i] show();
			
			level.board2[i] moveto(level.place2[i],0.0001);
			level.board2[i] rotateto((0,0,0),0.0001);
			level.board2[i] solid();
			level.board2[i] show();
			
			level.board1[i] moveto(level.place1[i],0.0001);
			level.board1[i] rotateto((0,0,0),0.0001);
			level.board1[i] solid();
			level.board1[i] show();
			
			level.monitor[i] = 0;
			level.trig1[i] thread axis_start(i);
		}
		else if(level.monitor[i] == 5 && level.action[i] == 0)
		{
			level notify("kill_axis" + i);
			
			level.action[i] = 1;
			level.board5[i] moveto(level.place5[i],0.0001);
			level.board5[i] rotateto((0,0,0),0.0001);
			level.board5[i] solid();
			level.board5[i] show();
			
			level.board4[i] moveto(level.place4[i],0.0001);
			level.board4[i] rotateto((0,0,0),0.0001);
			level.board4[i] solid();
			level.board4[i] show();
			
			level.board3[i] moveto(level.place3[i],0.0001);
			level.board3[i] rotateto((0,0,0),0.0001);
			level.board3[i] solid();
			level.board3[i] show();
			
			level.board2[i] moveto(level.place2[i],0.0001);
			level.board2[i] rotateto((0,0,0),0.0001);
			level.board2[i] solid();
			level.board2[i] show();
			
			level.board1[i] moveto(level.place1[i],0.0001);
			level.board1[i] rotateto((0,0,0),0.0001);
			level.board1[i] solid();
			level.board1[i] show();
			
			level.monitor[i] = 0;
			level.trig1[i] thread axis_start(i);
		}
	}
	}
}