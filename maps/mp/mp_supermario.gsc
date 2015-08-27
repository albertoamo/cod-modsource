#include maps\mp\_utility;

main()
{
	thread teleporters();
if(getCvar("mario_goombas") == "")
	setCvar("mario_goombas", "1");
	
	thread maps\mp\mp_supermario_water::water();
	thread maps\mp\mp_supermario_flowers::FlowerInit();
	thread maps\mp\mp_supermario_goomba::GoombaInit();
	thread maps\mp\mp_supermario_pipeteleports::pipes();

	thread maps\mp\mp_supermario_lift::main();
	thread maps\mp\mp_supermario_lift2::main();
	thread maps\mp\mp_supermario_lift3::main();
	thread maps\mp\mp_supermario_lift4::main();
	thread maps\mp\mp_supermario_lift5::main();
	
	thread maps\mp\mp_supermario_lift6::main();
	thread maps\mp\mp_supermario_lift7::main();
	thread maps\mp\mp_supermario_lift8::main();
	thread maps\mp\mp_supermario_lift9::main();
	thread maps\mp\mp_supermario_lift10::main();
	
	thread maps\mp\mp_supermario_wolk1::main();
	thread maps\mp\mp_supermario_wolk2::main();
	thread maps\mp\mp_supermario_wolk3::main();
	thread maps\mp\mp_supermario_wolk4::main();
	thread maps\mp\mp_supermario_wolk5::main();
	thread maps\mp\mp_supermario_platform1::main();
	thread maps\mp\mp_supermario_platform2::main();

	thread fix();
	thread fix2();
	

maps\mp\_load::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_mp_supermario");

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");



}

fix()
{
	volume = [];
	volume[0] = 56; // min (x)
	volume[1] = -426; // min (y)
	volume[2] = -1667; // min  (z)
	volume[3] = 1357; // max  (x)
	volume[4] = 109; // max  (y)
	volume[5] = -1127; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		player suicide();
	}
}

fix2()
{
	volume = [];
	volume[0] = -550; // min (x)
	volume[1] = -521; // min (y)
	volume[2] = -500; // min  (z)
	volume[3] = -400; // max  (x)
	volume[4] = -400; // max  (y)
	volume[5] = -300; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

		if ( RandomInt( 100 ) > 50 && player.pers["team"] == "allies" )
			player suicide();
		else
		{
			player.spawnprotected = true;
			spawnpoints = getentarray("mp_tdm_spawn","classname");
			spawnpoint = player maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnpoints);
			player setorigin(spawnpoint.origin);
			player SetPlayerAngles(spawnpoint.angles);
			wait(1);
			player.spawnprotected = undefined;
		}
	}
}


teleporters()
{

entteleporter = getentarray("teleporter","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();
}

entteleporter = getentarray("teleporter1","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();
}

entteleporter = getentarray("teleporter2","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();
}

entteleporter = getentarray("teleporter3","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();
}

entteleporter = getentarray("teleporter4","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();
}

entteleporter = getentarray("teleporter5","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();
}

entteleporter = getentarray("teleporter6","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter();
}
}

teleporter()
{
while(true)
{
self waittill("trigger",other);
entTarget = getent(self.target, "targetname");

wait(0.10);
other setorigin(entTarget.origin);
other setplayerangles(entTarget.angles);
wait(0.10);
}
}






