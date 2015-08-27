//Scripted by cavie
//xfire:hoogerss
//email hoogers.jeroen@gmail.com


#include maps\mp\_utility;

GoombaInit()
{
	goomba = getentarray("goomba_body","targetname");
	for(i=0;i<goomba.size;i++)
	{
		goomba[i] thread Goomba(i);
	}
}

GoombaGetMoveDir() 
{
	MoveDir = randomInt(360);
	return (MoveDir);
}

/*
GoombaGetMoveDir()  //causes too much lagg :(
{
	StartOrigin = self.origin;
	angles = self.angles;
	count = 0;
	MoveDir = [];
	
	for(i=0;i<360;i++)
	{
		angles = (self.angles[0],(self.angles[1] + i),self.angles[2]);
		direction = AnglesToForward(angles);
		direction = vectorscale(direction, 10000);
		StopOrigin = StartOrigin + direction;

		Trace = bulletTrace( StartOrigin, StopOrigin, false, self );
		
		ImpactOrig = Trace["position"];
		dist = Distance(StartOrigin,ImpactOrig);
		if(dist > 100)
		{
			MoveDir[count] = (i+1);
			count++;
		}
	}
	iprintln("arraysize = " + MoveDir.size);
	rand = randomInt(MoveDir.size);
	iprintln("direction = " + MoveDir[rand]);
	return(MoveDir[rand]);
}
*/

GoombaGetForwardOrig()
{
	StartOrigin = self.origin;
	forward = AnglesToForward(self.angles);
	forward = vectorscale(forward, 99999);
	StopOrigin = startOrigin + forward;

	ForwardOrig = bulletTrace( StartOrigin, StopOrigin, false, self );
	
	return (ForwardOrig["position"]);
}

GoombaGetLeftOrig()
{
	
	StartOrigin = self.origin;
	Direction = AnglesToRight(self.angles);
	Direction = vectorscale(Direction, -99999);
	StopOrigin = startOrigin + Direction;

	ForwardOrig = bulletTrace( StartOrigin, StopOrigin, false, self );
	
	return (ForwardOrig["position"]);
	
	/*
	Direction = AnglesToRight(self.angles);
	Direction = vectorscale(Direction, -20);
	vLeftOrig = self.origin + Direction;
	return(vLeftOrig);
	*/
}

GoombaGetRightOrig()
{
	
	StartOrigin = self.origin;
	Direction = AnglesToRight(self.angles);
	Direction = vectorscale(Direction, 99999);
	StopOrigin = startOrigin + Direction;

	ForwardOrig = bulletTrace( StartOrigin, StopOrigin, false, self );
	
	return (ForwardOrig["position"]);
	/*
	Direction = AnglesToRight(self.angles);
	Direction = vectorscale(Direction, 20);
	vRightOrig = self.origin + Direction;
	return(vRightOrig);
	*/
}

Goomba(i) //create goomba
{
	FootL = getentarray("goomba_lfoot","targetname");
	FootR = getentarray("goomba_rfoot","targetname");
	KillTrig = getentarray("goomba_die","targetname");
	DieTrig = getentarray("goomba_kill","targetname");
	WallTrig = getentarray("goomba_wall","targetname");
	
	self.FootL = FootL[i];
	self.FootR = FootR[i];
	self.KillTrig = KillTrig[i];
	self.DieTrig = Dietrig[i];
	self.WallTrig = Walltrig[i];
	
	//variables
	self.IsOnGround = true;
	self.TooClose = false;
	self.IsWalking = false;
	self.SwitchLastOrig = false;
	self.spawnplace = self.origin;
	self.Died = false;
	
	//treads
	if(getCvar("mario_goombas") == "1")
	{
		self thread GoombaStep();
		self thread GoombaDie();
		self thread GoombaMove();
		self thread GoombaCheckIfOnGround();
		self thread GoombaWaitWhileWalk();
		self thread GoombaCheckIfTooCloseToWall();
		self thread GoombaWallDamage();
		self thread GoombaCheckIfStuck();
	}
	else
		self thread GoombaDelete();
}


GoombaMove()
{
	self endon("goomba_death");
	
	if(!self.Died) //check if the goomba has died already if not link triggers
	{
		self.DieTrig enableLinkTo();
		self.DieTrig linkto(self);
		self.KillTrig enableLinkTo();
		self.KillTrig linkto(self.DieTrig);
		self.WallTrig enableLinkTo();
		self.WallTrig linkto(self.KillTrig);
		
	}
	
	for(;;)
	{
		StartOrig = self.origin;
		StopOrig = GoombaGetForwardOrig();
		dist = Distance(StartOrig,StopOrig);
		speed = (dist * 0.01);

		if(speed == 0) 
		{
			speed = 0.01;
		}
		self.IsWalking = true;	
		self moveto(StopOrig,speed);
		self.FootR moveto(StopOrig,speed);
		self.FootL moveto(StopOrig,speed);
		
		for(;;)
		{
			if((!self.IsOnGround)||(!self.IsWalking)||(self.TooClose))
			{
				if(self.SwitchLastOrig)
				{
					self moveto(self.LastPosOnGround,0.1);
					self.FootR moveto(self.LastPosOnGround,0.1);
					self.FootL moveto(self.LastPosOnGround,0.1);
					self waittill("movedone");
				}
				else
				{
					self moveto(self.LastPosOnGround1,0.1);
					self.FootR moveto(self.LastPosOnGround1,0.1);
					self.FootL moveto(self.LastPosOnGround1,0.1);
					self waittill("movedone");
				}
				
				break;
			}
			
			if(self.SwitchLastOrig) 
			{
				self.SwitchLastOrig = false;
				self.LastPosOnGround = self.origin;
			}
			else
			{
				self.SwitchLastOrig = true;
				self.LastPosOnGround1 = self.origin;
			}
			wait 0.05;
		}
		wait 0.1;
		Dir = GoombaGetMoveDir();	
		
		/*
		//calculate rotation speed
		if(self.angles[2] < Dir) 
			rotSpeed = (Dir - self.angles[2]) * 0.05;
		else
			rotSpeed = (self.angles[2] - Dir) * 0.05;
		*/
		/*
		for(;;)
		{
			wait 0.05;
			StartOrig = self.origin;
			StopOrig = GoombaGetForwardOrig();
			OrigR = GoombaGetRightOrig();
			OrigL = GoombaGetLeftOrig();
			dist = Distance(StartOrig,StopOrig);
			speed = (dist * 0.01);
			CheckR = BulletTracePassed( OrigR, StopOrig, false, self);
			CheckL = BulletTracePassed( OrigL, StopOrig, false, self);
			if(CheckR && CheckL)
				break;
		}
		*/
		self rotateto((0,Dir,0),.3);
		self.FootR rotateto((0,Dir,0),.3);
		self.FootL rotateto((0,Dir,0),.3);
		self waittill("rotatedone");
	}
}

GoombaStep()
{
	//self endon("goomba_death");
	for(;;)
	{
		self.FootR rotateto((-30,self.angles[1],self.angles[2]),.4);
		self.FootL rotateto((30,self.angles[1],self.angles[2]),.4);
		self.FootR waittill("rotatedone");

		self.FootR rotateto((30,self.angles[1],self.angles[2]),.4);
		self.FootL rotateto((-30,self.angles[1],self.angles[2]),.4);
		self.FootR waittill("rotatedone");
	}
}

GoombaDie()
{
	for(;;)
	{
		self.DieTrig waittill("trigger",user);
		self notify("goomba_death");
		user iprintlnbold("you've killed a goomba!");
		user.score = user.score + 5;
		wait 0.1;
		self movez(-100,3);
		self.FootR movez(-100,3);
		self.FootL movez(-100,3);
		self waittill("movedone");
		self hide();
		self.FootL hide();
		self.FootR hide();
		self thread GoombaRespawn();
	}
	return;
}

GoombaCheckIfStuck()
{
	for(;;)
	{
		self.stuckorig = self.origin;
		wait 5;
		if(self.origin == self.stuckorig)
			self thread GoombaStuck();
	}
}

GoombaStuck()
{
	self notify("goomba_death");
	wait 0.1;
	self movez(-500,10);
	self.FootR movez(-500,10);
	self.FootL movez(-500,10);
	self waittill("movedone");
	self hide();
	self.FootL hide();
	self.FootR hide();
	self thread GoombaRespawn();
	return;
}

GoombaRespawn()
{
	self.Died = true;
	wait 20;
	self moveto(self.spawnplace,0.1);
	self.FootL moveto(self.spawnplace,0.1);
	self.FootR moveto(self.spawnplace,0.1);
	self waittill("movedone");

	self show();
	self.FootL show();
	self.FootR show();
	
	//variables
	self.LastPosOnGround1 = self.origin;
	self.LastPosOnGround = self.origin;
	
	//treads
	self thread GoombaMove();
//	self thread GoombaStep();
	self thread GoombaDie();
	self thread GoombaCheckIfOnGround();
	self thread GoombaWaitWhileWalk();
	self thread GoombaCheckIfTooCloseToWall();
	self thread GoombaWallDamage();
}

GoombaCheckIfOnGround()
{
	self endon("goomba_death");
	for(;;)
	{
		self.IsOnGround = true;
		StartOrigin = self.origin;
		down = AnglesToUp(self.angles);
		down = vectorscale(down, -99999);
		StopOrigin = StartOrigin + down;
		check = bulletTrace( StartOrigin, StopOrigin, false, self );
		HitOrig = check["position"];
		dist =(StartOrigin[2] - HitOrig[2]);
		
		if (dist > 20)
		{
			self.IsOnGround = false;
		}
		wait 0.05;
	}
}


GoombaCheckIfTooCloseToWall()
{
self endon("goomba_death");
	for(;;)
	{
		self.TooClose = false;
		self.WallTrig waittill("damage", amount);
		if((isdefined(amount)) && (amount == 1))
			self.TooClose = true;
		wait 0.05;
	}
}

GoombaWallDamage() 
{
	self endon("goomba_death");
	for(;;)
	{
		level.wall = spawn("script_origin",(0,0,0));
		orig = GoombaGetForwardOrig();			//Creates damage on walls if the goombas triggers get too close they will turn.
		origleft = GoombaGetLeftOrig();			//There must be a better way to do this but it works 
		origright = GoombaGetRightOrig();		
		RadiusDamage( orig, 6, 1, 1, level.wall);
		RadiusDamage( origright, 1, 1, 1, level.wall);
		RadiusDamage( origleft, 1, 1, 1, level.wall);
		level.wall delete();
		wait 0.01;
	}
}

GoombaWaitWhileWalk()
{
	self endon("goomba_death");
	for(;;)
	{
		if(self.IsWalking)
		{
			self waittill("movedone");
			self.IsWalking = false;
		}
		wait 0.05;
	}
}

GoombaDelete()
{
	wait(0.05);

	if(isDefined(self)) self.FootR Delete();
	if(isDefined(self)) self.FootL Delete();
	if(isDefined(self)) self.KillTrig Delete();
	if(isDefined(self)) self.DieTrig Delete();
	if(isDefined(self)) self.WallTrig Delete();
	if(isDefined(self)) self Delete();
	return;
}
