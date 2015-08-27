init()
{
	precacheShader("damage_feedback");

	//level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);

		player.hud_damagefeedback = newClientHudElem(player);
		player.hud_damagefeedback.horzAlign = "center";
		player.hud_damagefeedback.vertAlign = "middle";
		player.hud_damagefeedback.x = -12;
		player.hud_damagefeedback.y = -12;
		player.hud_damagefeedback.alpha = 0;
		player.hud_damagefeedback.archived = true;
		player.hud_damagefeedback setShader("damage_feedback", 24, 24);
	}
}

updateDamageFeedback(color)
{
	self notify("damagefeedback");

	if(isPlayer(self))
	{
		if(!isDefined(color))
			color = (1, 1, 1);

		self CreateHud(self);

		self.hud_damagefeedback.color = color;
		self.hud_damagefeedback.alpha = 1;
		self.hud_damagefeedback fadeOverTime(1);
		self.hud_damagefeedback.alpha = 0;
		if(!isDefined(self.soundspamdelayfull)) 
			self playlocalsound("MP_hit_alert");

		self CleanUp();
	}
}

CreateHud(player)
{
	if(!isDefined(player.hud_damagefeedback))
	{
		player.hud_damagefeedback = newClientHudElem(player);
		player.hud_damagefeedback.horzAlign = "center";
		player.hud_damagefeedback.vertAlign = "middle";
		player.hud_damagefeedback.x = -12;
		player.hud_damagefeedback.y = -12;
		player.hud_damagefeedback.archived = true;
		player.hud_damagefeedback setShader("damage_feedback", 24, 24);
	}
}

CleanUp()
{
	self endon("damagefeedback");
	wait(1);
	if(isDefined(self.hud_damagefeedback)) self.hud_damagefeedback Destroy();
}