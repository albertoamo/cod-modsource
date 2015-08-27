main()
{
level thread windmolen();

maps\mp\_load::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_mp_devilscreek");

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
rotate_obj = getentarray("cowboymolen","targetname");
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