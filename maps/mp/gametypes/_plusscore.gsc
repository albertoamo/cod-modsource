// Created by IzNoGod
init()
{
	precachestring(&"+");
}

onSpawn()
{
	self.scoretoshow=0;
	self.scoresize=0.5;
	self.scorealpha=0.3;
}

CleanUp()
{
	self.scoretoshow=0;
	self notify("hudscore_restart");

	if(isDefined(self.hud_plusscore))
		self.hud_plusscore destroy();
}

blinkhud()
{
	self endon("disconnect");
	self endon("hudscore_restart");

	//enlarge the score element
	while(self.scoresize<2.0&&isdefined(self.hud_plusscore))
	{
		wait 0.05;
		self.scoresize+=0.35;
		if(isDefined(self.hud_plusscore)) self.hud_plusscore.fontscale = self.scoresize;
	}
	//make score element smaller
	while(self.scoresize>1.8&&isdefined(self.hud_plusscore))
	{
		wait 0.05;
		self.scoresize-=0.2;
		if(isDefined(self.hud_plusscore)) self.hud_plusscore.fontscale = self.scoresize;
	}
	self.scoresize=1.5;
	if(isDefined(self.hud_plusscore)) self.hud_plusscore.fontscale=self.scoresize;
}

fadehud()
{
	self endon("disconnect");
	self endon("hudscore_restart");
	//make alpha bigger
	while(self.scorealpha<=0.9&&isdefined(self.hud_plusscore))
	{
		self.hud_plusscore.alpha=self.scorealpha;
		self.hud_plusscore fadeovertime(0.05);
		self.scorealpha+=0.1;
		self.hud_plusscore.alpha = self.scorealpha;
		wait 0.05;
	}
	wait 1;
	//make score element smaller
	while(self.scorealpha>0.05&&isdefined(self.hud_plusscore))
	{
		self.hud_plusscore.alpha=self.scorealpha;
		self.hud_plusscore fadeovertime(0.05);
		self.scorealpha-=0.1;
		self.hud_plusscore.alpha = self.scorealpha;
		wait 0.05;
	}
}


plusscore(plus)
{
	self notify("hudscore_restart");
	self.scoretoshow+=plus;
	self endon("disconnect");
	self endon("hudscore_restart");
	if(isDefined(self.hud_plusscore))
		self.hud_plusscore destroy();
	self.hud_plusscore = newClientHudElem(self);
	self.hud_plusscore.alignX = "center";
	self.hud_plusscore.alignY = "middle";
	self.hud_plusscore.vertalign="center_safearea";
	self.hud_plusscore.horzalign="center_safearea";

	self.hud_plusscore.x = 0;
	self.hud_plusscore.y = -20;
	self.hud_plusscore.fontscale = self.scoresize; //cod4 starts@small score
	self.hud_plusscore.alpha = self.scorealpha;

	if(self.pers["team"] == "allies")
		self.hud_plusscore.color = (1,230/255,125/255);	//cod4 like rgb values
	else
		self.hud_plusscore.color = (1,0,0); // red

	if(self.scoretoshow > 0)
		self.hud_plusscore.label = &"+";

	self.hud_plusscore setValue(self.scoretoshow);
	self thread blinkhud();
	self fadehud();
	self.scoresize=0.5;
	self.scorealpha=0.3;
	wait 0.5;
	CleanUp();
}