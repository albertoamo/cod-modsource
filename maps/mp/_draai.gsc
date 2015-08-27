main()
{

level thread motor();
level thread propeller();

}

motor()
{
rotate_obj = getentarray("motor","targetname");
if(isdefined(rotate_obj))
{
for(i=0;i<rotate_obj.size;i++)
{
rotate_obj[i] thread motor_rotate();
}
}
}

motor_rotate()
{
if (!isdefined(self.speed))
self.speed = 12;
if (!isdefined(self.script_noteworthy))
self.script_noteworthy = "z";

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

propeller()
{
rotate_obj = getentarray("fen","targetname");
if(isdefined(rotate_obj))
{
for(i=0;i<rotate_obj.size;i++)
{
rotate_obj[i] thread pro();
}
}
}

pro()
{
if (!isdefined(self.speed))
self.speed = 1;
if (!isdefined(self.script_noteworthy))
self.script_noteworthy = "z";

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