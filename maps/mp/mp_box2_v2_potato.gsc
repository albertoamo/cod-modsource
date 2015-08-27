main()
{
weaponrespawner("potato", 1);
}






	weaponrespawner(targetname, defaultrespawndelay)
{
	weapons = getentarray(targetname, "targetname");
	if(weapons.size > 0)
{
	for(i=0; i < weapons.size; i++) 
{
	if(!isdefined(weapons[i].script_timescale))
	weapons[i].script_timescale = defaultrespawndelay;

	weapons[i] thread 		
	weapon_think(weapons[i].script_timescale);
}
}
}

 

	weapon_think(delaytime)
{
	classname = self.classname;
	model = self.model;
	count = self.count;
	org = self.origin;
	angles = self.angles;
	targetname = self.targetname;
	self waittill("trigger");
	wait delaytime;
	weapon = spawn(classname, org);
	weapon.angles = angles;
	weapon.count = count;
	weapon setmodel(model); 
	weapon.script_timescale = delaytime;
	weapon.targetname = targetname;
	weapon thread weapon_think(delaytime);

}


