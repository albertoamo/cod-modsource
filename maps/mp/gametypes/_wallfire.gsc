main()
{
	level.effects["bark"]=loadfx("fx/impacts/large_woodhit.efx");
	level.effects["brick"]=loadfx("fx/impacts/small_brick.efx");
	level.effects["carpet"]=loadfx("fx/impacts/default_hit.efx");
	level.effects["cloth"]=loadfx("fx/impacts/cloth_hit.efx");
	level.effects["concrete"]=loadfx("fx/impacts/small_concrete.efx");
	level.effects["dirt"]=loadfx("fx/impacts/small_dirt.efx");
	level.effects["flesh"]=loadfx("fx/impacts/flesh_hit.efx");
	level.effects["foliage"]=loadfx("fx/impacts/small_foliage.efx");
	level.effects["glass"]=loadfx("fx/impacts/small_glass.efx");
	level.effects["grass"]=loadfx("fx/impacts/small_grass.efx");
	level.effects["gravel"]=loadfx("fx/impacts/small_gravel.efx");
	level.effects["ice"]=loadfx("fx/impacts/small_snowhit.efx");
	level.effects["metal"]=loadfx("fx/impacts/small_metalhit.efx");
	level.effects["mud"]=loadfx("fx/impacts/small_mud.efx");
	level.effects["paper"]=loadfx("fx/impacts/default_hit.efx");
	level.effects["plaster"]=loadfx("fx/impacts/small_concrete.efx");
	level.effects["rock"]=loadfx("fx/impacts/small_rock.efx");
	level.effects["sand"]=loadfx("fx/impacts/small_dirt.efx");
	level.effects["snow"]=loadfx("fx/impacts/small_snowhit.efx");
	level.effects["water"]=loadfx("fx/impacts/small_waterhit.efx");
	level.effects["wood"]=loadfx("fx/impacts/large_woodhit.efx");
	level.effects["asphalt"]=loadfx("fx/impacts/small_concrete.efx");
	level.effects["default"]=loadfx("fx/impacts/default_hit.efx");
	level thread waitforconnect();
}

waitforconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread waitforspawn();
		player thread spawneye();
	}
}

waitforspawn()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if(self.pers["team"] != "spectator")
			self thread wallfire();
	}
}


wallfire()
{
	self endon("disconnect");
	self endon("killed_player");
	ammo=self getweaponslotclipammo(self getcurrentweaponslot());
	oldammo=ammo;
	oldangles=self getplayerangles();
	weap=self getcurrentweapon();
	oldweap=weap;
	for(;;)
	{
		weap=self getcurrentweapon();
		ammo=self getweaponslotclipammo(self getcurrentweaponslot());
		if(self attackbuttonpressed()&&ammo<oldammo&&oldweap==weap&&wallpenetrating(weap)>0)
		{
			angles=self getplayerangles();
			newangles=((oldangles[0]*1+angles[0]*2)/3,angles[1],angles[2]);
			forward=maps\mp\_utility::vectorscale(anglestoforward(newangles),10000);
			smallforward=vectornormalize(forward);
			point=self geteyepos();
			getpoint=bullettrace(point,point-smallforward,false,undefined);
			point=getpoint["position"];
			players=bullettrace(point,point+forward,true,self);
			firsttrace=bullettrace(point,point+forward,false,undefined);
			if(firsttrace["fraction"]<1&&!isplayer(players["entity"]))
			{
				maxdist=wallpenetrating(weap);
				{
					secondtrace=bullettrace(firsttrace["position"]+smallforward,firsttrace["position"]+forward,true,self);
					traceback=bullettrace(secondtrace["position"],firsttrace["position"],false,undefined);
					wall=distance(firsttrace["position"],traceback["position"]);
					if(!isdefined(secondtrace["entity"])&&secondtrace["fraction"]<1&&distance(secondtrace["position"],point)<maxrange(weap))
						placebullethole(secondtrace,firsttrace["position"]);
					if(traceback["fraction"]<1&&wall<maxdist)
						placebullethole(traceback,secondtrace["position"]);
				}
				if(isplayer(secondtrace["entity"]))
				{
					maxdmg=getthroughwalldamage(weap);
					dmgmulti=(maxdist-wall)/maxdist;
					mxrange=maxrange(weap);
					distancemulti=(mxrange-distance(secondtrace["position"],point))/mxrange;
					damage=int(maxdmg*dmgmulti*distancemulti);
					if(damage>0&&secondtrace["entity"]!=self)
					{
						iDflags=0;
						sMeansofDeath=getweaponMOD(weap);
						vDir=vectornormalize(secondtrace["position"]-self.origin);
						if(distancesquared(secondtrace["entity"] geteyepos(),secondtrace["position"])<8*8)
						{
							damage=int(damage*2);
							sHitloc="head";
						}
						else
							sHitloc="none";
						secondtrace["entity"] maps\mp\gametypes\_callbacksetup::CodeCallback_PlayerDamage(self, self, damage, iDFlags, sMeansOfDeath, weap, secondtrace["entity"].origin, vDir, sHitLoc, 0);
					}
				}
			}
		}
		oldammo=ammo;
		oldweap=weap;
		oldangles=self getplayerangles();
		wait 0.05;
	}
}
		
getcurrentweaponslot()
{
	if(self getcurrentweapon()!=self getweaponslotweapon("primaryb"))
		return "primary";
	else
		return "primaryb";
}

getthroughwalldamage(weap)
{
	switch(weap)
	{
	case "springfield_mp":
	case "enfield_scope_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	case "mosin_nagant_mp":
	case "enfield_mp":
	case "kar98k_mp":
	case "barret_mp":
	case "remington_mp":
	case "m14_scoped_mp":
		return 100;
	case "m1carbine_mp":
	case "m1garand_mp":
	case "SVT40_mp":
	case "g43_mp":
		return 38;
	case "bar_mp":
	case "bren_mp":
	case "mp44_mp":
	case "rpd_mp":
	case "ak47_mp":
	case "winchester":
	case "sig_mp":
	case "tesla_mp":
	case "ak74_mp":
	case "g36_mp":
	case "uzi_mp":
	case "m14_mp":
		return 40;
	case "thompson_mp":
	case "sten_mp":
	case "greasegun_mp":
	case "mp40_mp":
	case "benelli_mp":
		return 36;
	case "ppsh_mp":
		return 30;
	case "PPS42_mp":
		return 40;
	case "shotgun_mp":
		return 40;
	case "TT30_mp":
		return 20;
	case "webley_mp":
		return 20;
	case "colt_mp":
	case "glock_mp":
		return 20;
	case "luger_mp":
		return 20;
	default:
		return 70;
	}
}

wallpenetrating(weap)
{
	switch(weap)
	{
	case "rpd_mp":
	case "ak47_mp":
	case "barret_mp":
	case "winchester":
	case "sig_mp":
	case "tesla_mp":
	case "ak74_mp":
	case "g36_mp":
	case "uzi_mp":
	case "remington_mp":
	case "m14_mp":
	case "m14_scoped_mp":
	case "springfield_mp":
	case "enfield_scope_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	case "mosin_nagant_mp":
	case "kar98k_mp":
	case "enfield_mp":
	case "m1carbine_mp":
	case "m1garand_mp":
	case "SVT40_mp":
	case "g43_mp":
	case "bar_mp":
	case "bren_mp":
	case "mp44_mp":
	case "thompson_mp":
	case "sten_mp":
	case "greasegun_mp":
	case "mp40_mp":
	case "ppsh_mp":
	case "PPS42_mp":
	case "shotgun_mp":
	case "benelli_mp":
		return 25;
	case "TT30_mp":
	case "webley_mp":
	case "colt_mp":
	case "luger_mp":
	case "glock_mp":
		return 15;
	case "panzerschreck_mp":
	case "panzerfaust_mp":
		return 0;

	default:
		return 0;
	}
}

maxrange(weap)
{
	switch(weap)
	{
	case "springfield_mp":
	case "enfield_scope_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	case "mosin_nagant_mp":
	case "barret_mp":
	case "m14_scoped_mp":
		return 10000;
	case "kar98k_mp":
	case "enfield_mp":
	case "remington_mp":
		return 5000;
	case "m1carbine_mp":
	case "m1garand_mp":
		return 4000;
	case "SVT40_mp":
	case "g43_mp":
		return 4000;
	case "bar_mp":
	case "bren_mp":
	case "mp44_mp":
	case "rpd_mp":
	case "ak47_mp":
	case "winchester":
	case "sig_mp":
	case "tesla_mp":
	case "ak74_mp":
	case "g36_mp":
	case "uzi_mp":
	case "m14_mp":
		return 3500;
	case "thompson_mp":
	case "sten_mp":
	case "greasegun_mp":
	case "mp40_mp":
	case "benelli_mp":
		return 3000;
	case "ppsh_mp":
	case "PPS42_mp":
		return 2500;
	case "shotgun_mp":
		return 1000;
	case "TT30_mp":
	case "webley_mp":
	case "colt_mp":
	case "luger_mp":
	case "glock_mp":
		return 1000;
	case "panzerschreck_mp":
	case "panzerfaust_mp":
		return 0;
	default:
		return 0;
	}
}

getweaponMOD(weap)
{
	switch(weap)
	{
	case "springfield_mp":
	case "enfield_scope_mp":
	case "mosin_nagant_sniper_mp":
	case "kar98k_sniper_mp":
	case "mosin_nagant_mp":
	case "kar98k_mp":
	case "enfield_mp":
	case "barret_mp":
	case "remington_mp":
	case "m14_scoped_mp":
		return "MOD_RIFLE_BULLET";
	case "m1carbine_mp":
	case "m1garand_mp":
	case "SVT40_mp":
	case "g43_mp":
	case "bar_mp":
	case "bren_mp":
	case "mp44_mp":
	case "thompson_mp":
	case "sten_mp":
	case "greasegun_mp":
	case "mp40_mp":
	case "ppsh_mp":
	case "PPS42_mp":
	case "shotgun_mp":
	case "rpd_mp":
	case "ak47_mp":
	case "winchester":
	case "sig_mp":
	case "tesla_mp":
	case "ak74_mp":
	case "g36_mp":
	case "uzi_mp":
	case "m14_mp":
	case "benelli_mp":
		return "MOD_RIFLE_BULLET";
	case "TT30_mp":
	case "webley_mp":
	case "colt_mp":
	case "luger_mp":
	case "glock_mp":
		return "MOD_PISTOL_BULLET";
	case "panzerschreck_mp":
	case "panzerfaust_mp":
		return"MOD_PROJECTILE";
	default:
		return "MOD_UNKNOWN";
	}
}

		
spawneye()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		wait 0.05;
		if(isalive(self))
		{
			self.eyemarker=spawn("script_origin",self.origin);
			self.eyemarker linkto(self,"tag_origin",(0,0,0),(0,0,0));
		}
		while(isalive(self))
			wait 0.05;
		self.eyemarker unlink();
		self.eyemarker delete();
	}
}

		


geteyepos()
{
	if(isdefined(self.eyemarker))
	{
		if(distancesquared(self.eyemarker.origin,self.origin)>0)
			return self.eyemarker.origin;
		else
			return self geteye();
	}
	else
	{
		return self geteye();
	}
}

placebullethole(trace,startpoint)
{
	fx=trace["surfacetype"];
	if(isdefined(level.effects[fx]))
		effect=level.effects[fx];
	else
		effect=level.effects["default"];

	normal=vectornormalize(trace["normal"]);

	if(normal != (0,0,0))
		playfx(effect,trace["position"],normal);
	else
		playfx(effect,trace["position"]);
}