//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
maps\mp\_load::main();

	game["allies"] = "american";
	game["axis"] = "german";

	game["british_soldiertype"] = "normandy";
	game["british_soldiervariation"] = "normandy";
	game["german_soldiertype"] = "wehrmacht";
	game["german_soldiervariation"] = "normandy";

	game["attackers"] = "allies";
	game["defenders"] = "axis";

thread boat2();
thread slidedoor_slider();
thread teleportenter();
maps\mp\mp_zombox_final_elevator::main();
maps\mp\mp_zombox_final_door::main();
maps\mp\mp_zombox_final_trampillas::main();
maps\mp\mp_zombox_final_stukas::main();
maps\mp\mp_zombox_final_trampilla::main();
maps\mp\mp_zombox_final_rotate::main();
maps\mp\mp_zombox_final_ascensor::main();
maps\mp\mp_zombox_final_drown::main();
maps\mp\mp_zombox_final_speed::main();
maps\mp\mp_zombox_final_speed2::main();
maps\mp\mp_zombox_final_speed3::main();
maps\mp\mp_zombox_final_elevator123::main();
maps\mp\mp_zombox_final_zeppelin::main();
maps\mp\mp_zombox_final_fx::main();
maps\mp\mp_zombox_final_secret::main();
maps\mp\mp_zombox_final_puertas::main();
maps\mp\mp_zombox_final_axafador::main();
maps\mp\mp_zombox_final_slow_death::main();
maps\mp\mp_zombox_final_puentes::main();
maps\mp\mp_zombox_final_secreto::main();
maps\mp\mp_zombox_final_puertas1::main();
maps\mp\mp_zombox_final_blocker::main();
maps\mp\mp_zombox_final_help1::main();
maps\mp\mp_zombox_final_help2::main();
maps\mp\mp_zombox_final_piedra::main();
maps\mp\mp_zombox_final_logitech::main();
maps\mp\mp_zombox_final_secretblocks::main();
maps\mp\mp_zombox_final_box::main();
maps\mp\mp_zombox_final_bomba::main();
maps\mp\mp_zombox_final_powerles::main();
maps\mp\mp_zombox_final_quadro::main();
maps\mp\mp_zombox_final_kemao::main();
maps\mp\mp_zombox_final_bamm::main();
maps\mp\mp_zombox_final_bomba2::main();
maps\mp\mp_zombox_final_panther::main();
maps\mp\mp_zombox_final_jeep1::main_callbacks();
maps\mp\mp_zombox_final_jeep1::main();
maps\mp\mp_zombox_final_flanguns::main();
maps\mp\mp_zombox_final_panther2::main();
maps\mp\mp_zombox_final_cuerpos::main();
maps\mp\mp_zombox_final_radio::main();
thread backward(2200);
thread shrecks();

ents = getentarray("trigger_hurt", "classname");
ents[6] delete();
}

shrecks()
{
	weps = getentarray("weapon_panzerschreck_mp", "classname");

	for(i=0;i<weps.size;i++)
	{
		if(weps[i] checkLocation((664,672,-1336)) || weps[i] checkLocation((680,712,-1336)))
		{
			trace = BulletTrace(weps[i].origin, weps[i].origin - (0,0,100000), false, weps[i]);
			wep = spawn("script_model", trace["position"] + (0,0,8));
			wep setModel("xmodel/weapon_panzerschreck");
			wep.angles = (0,270,0);
			weps[i] delete();
		}
		else if(weps[i] checkLocation((632,744,-1336)) || weps[i] checkLocation((632,712,-1336)) || weps[i] checkLocation((632,680,-1336)))
		{
			trace = BulletTrace(weps[i].origin, weps[i].origin - (0,0,100000), false, weps[i]);
			wep = spawn("script_model", trace["position"] + (0,0,8));
			wep setModel("xmodel/weapon_panzerschreck");
			weps[i] delete();
		}
	}
}

checkLocation(startorigin)
{
	if(self.origin == startorigin)
		return true;

	return false;
}

backward(dmg)
{	
	volume = [];
	volume[0] = 5199; // min (x)
	volume[1] = 1341; // min (y)
	volume[2] = -1647; // min  (z)
	volume[3] = 5234; // max  (x)
	volume[4] = 1466; // max  (y)
	volume[5] = -1450; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if(isDefined(player) && isPlayer(player))
		{
			if(isDefined(player.debugmode))
			{
				player iprintln("Backwards trigger");
			}
		}
		angles = VectorToAngles( (5000, player.origin[1], player.origin[2]) - player.origin );
		player.health += dmg;
		player FinishPlayerDamage( player, player, dmg, 1, "MOD_EXPLOSIVE", "none", player.origin, maps\mp\_utility::vectorScale(AnglesToForward(angles), -1000), "none", 0 );

		wait(0.05);
	}
}

boat2()
{
liftpad2=getent("boat2","targetname");
//trig=getent("boat3","targetname");
while(1)
{
wait (4);
liftpad2 movex (-1086,18,4,5);
liftpad2 waittill ("movedone");
wait (4);
liftpad2 movex(1086,18,4,5);
liftpad2 waittill ("movedone");
}
}

slidedoor_slider()
{
slidedoor=getent("slidedoor","targetname");
trig=getent("slideopen","targetname");
while(1)
{
trig waittill ("trigger");
slidedoor PlaySound("lmfao");
//wait (4);
slidedoor movey (1224,8,0.5,0.5);
slidedoor waittill ("movedone");
wait (4);
//trig waittill ("trigger");
slidedoor playsound("lmfao");
slidedoor movey(-1224,8,0.5,0.5);
slidedoor waittill ("movedone");
}
}

teleportenter()
{
  entTransporter = getentarray("enter","targetname");
  if(isdefined(entTransporter))
  {
    for(lp=0;lp<entTransporter.size;lp=lp+1)
      entTransporter[lp] thread Transporter();
  }


}


Transporter()
{
  while(true)
  {
    self waittill("trigger",other);
    entTarget = getent(self.target, "targetname");

    wait(0.10);
    other setorigin(entTarget.origin);
    other setplayerangles(entTarget.angles);
    //iprintlnbold ("You have been teleported !!!");");
    wait(0.10);
}
}

