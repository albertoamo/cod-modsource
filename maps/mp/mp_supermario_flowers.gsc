//Scripted by cavie
//xfire:hoogerss
//email hoogers.jeroen@gmail.com

FlowerInit()
{
	flower = getentarray("flower","targetname");
	for(i=0;i<flower.size;i++)
	{
		flower[i] thread Flower(i);
	}
}

Flower(i)
{
	leafr = getentarray("flower_leafr","targetname");
	leafl = getentarray("flower_leafl","targetname");
	
	self.leafr = leafr[i];
	self.leafl = leafl[i];
	
	self thread FlowerLeafRot();
	self thread FlowerMoveup();
}

FlowerLeafRot()
{	
	self.leafr rotateroll(25,0.05);
	self.leafl rotateroll(-25,0.05);
	self.leafr waittill("rotatedone");
	
	for(;;)
	{
		self waittill("FlowerMoveUp");
		wait 1;
		self.leafr rotateroll(-30,0.5);
		self.leafl rotateroll(30,0.5);
		self.leafr waittill("rotatedone");
		self.leafr rotateroll(30,0.5);
		self.leafl rotateroll(-30,0.5);
		self.leafr waittill("rotatedone");
		self.leafr rotateroll(-30,0.5);
		self.leafl rotateroll(30,0.5);
		self.leafr waittill("rotatedone");
		self.leafr rotateroll(30,0.5);
		self.leafl rotateroll(-30,0.5);
		self.leafr waittill("rotatedone");
	}
}

FlowerMoveup()
{
	self thread FlowerKill();
	self notsolid();
	self.leafr notsolid();
	self.leafl notsolid();	
	
	
	for(;;)
	{
		
		self movez (88,2);
		self.leafl movez (88,2);
		self.leafr movez (88,2);
		self notify("FlowerMoveUp");
		self waittill("movedone");
		wait 1;
		self movez (-88,2);
		self.leafl movez (-88,2);
		self.leafr movez (-88,2);
		self waittill("movedone");	
		wait 3;
	}
}

FlowerKill()
{
	flowerkill = getent(self.target, "targetname");
	flowerkill enablelinkto();
	flowerkill linkto(self);	
}