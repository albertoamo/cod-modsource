main()
{
level thread windmolen();
level thread teleporters();
level thread teleporters2();
level thread teleporters3();
level thread teleporters4();
level thread teleporters5();
level thread teleporters6();
level thread teleporters7();
thread maps\mp\mario_wwlift1::main();
thread maps\mp\mario_wwlift2::main();
thread maps\mp\mario_wwlift2::main();
thread maps\mp\mario_plateau1::main();
thread maps\mp\mario_railtrain::main();
thread maps\mp\mario_facelift1::main();
thread maps\mp\mario_facelift2::main();
thread maps\mp\mario_wolk1::main();
thread maps\mp\mario_wolk2::main();
thread maps\mp\mario_wolk3::main();
thread maps\mp\mario_wolk4::main();
thread maps\mp\mario_wolk5::main();
thread maps\mp\mario_wolk6::main();
thread maps\mp\mario_drown::main();

maps\mp\_load::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_mp_supermarioww");

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


windmolen()
{
rotate_obj = getentarray("mario_rad1","targetname");
if(isdefined(rotate_obj))
{
for(i=0;i<rotate_obj.size;i++)
{
rotate_obj[i] thread molen_rotate();
}
}
}

molen_rotate()
{
if (!isdefined(self.speed))
self.speed = 10;
if (!isdefined(self.script_noteworthy))
self.script_noteworthy = "x";

while(true)
{
if (self.script_noteworthy == "y")
self rotateYaw(360,self.speed);
else if (self.script_noteworthy == "x")
self rotateRoll(360,self.speed);
else if (self.script_noteworthy == "z")
self rotatePitch(360,self.speed);
wait ((self.speed)-0.1);
}
}


teleporters()
{

entteleporter = getentarray("mario_teleporter1","targetname");
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


teleporters2()
{

entteleporter = getentarray("mario_teleporter2","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter2();

}
}


teleporter2()
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


teleporters3()
{

entteleporter = getentarray("mario_teleporter3","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter3();

}
}


teleporter3()
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


teleporters4()
{

entteleporter = getentarray("mario_teleporter4","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter4();

}
}


teleporter4()
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


teleporters5()
{

entteleporter = getentarray("mario_teleporter5","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter5();

}
}


teleporter5()
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


teleporters6()
{

entteleporter = getentarray("mario_teleporter6","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter6();

}
}


teleporter6()
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


teleporters7()
{

entteleporter = getentarray("mario_teleporter7","targetname");
if(isdefined(entteleporter))
{
for(lp=0;lp<entteleporter.size;lp=lp+1)entteleporter[lp] thread teleporter7();

}
}


teleporter7()
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