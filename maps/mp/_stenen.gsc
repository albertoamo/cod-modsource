main()

{

thread regen();
thread elevator17();
level thread ruimtedraai1();
level thread ruimtedraai2();
level thread draai2();
level thread stenen();
level thread megasteen();
level thread steen5();
level thread steen6();
}

regen()
{
regen = getent("regengroot","targetname");
while(1)
{
regen movey (60000,26,0,0);
regen waittill ("movedone");
regen movez (5000,4,0,0);
regen waittill ("movedone");
regen movey (-70000,32,0,0);
regen waittill ("movedone");
regen movez (-5000,20,0,0);
regen waittill ("movedone");
regen movey (10000,8,0,0);
regen waittill ("movedone");
} 
} 


ruimtedraai1()
{
rotate_obj = getentarray("ruimtedraai1","targetname");
if(isdefined(rotate_obj))
{
for(i=0;i<rotate_obj.size;i++)
{
rotate_obj[i] thread ruimte1();
}
}
}

draai2()
{
rotate_obj = getentarray("draai2","targetname");
if(isdefined(rotate_obj))
{
for(i=0;i<rotate_obj.size;i++)
{
rotate_obj[i] thread ruimte1();
}
}
}

ruimte1()
{
if (!isdefined(self.speed))
self.speed = 50;
if (!isdefined(self.script_noteworthy))
self.script_noteworthy = "y";

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

ruimtedraai2()
{
rotate_obj = getentarray("ruimtedraai2","targetname");
if(isdefined(rotate_obj))
{
for(i=0;i<rotate_obj.size;i++)
{
rotate_obj[i] thread steen();
}
}
}

megasteen()
{
rotate_obj = getentarray("fall2","targetname");
if(isdefined(rotate_obj))
{
for(i=0;i<rotate_obj.size;i++)
{
rotate_obj[i] thread steen();
}
}
}

stenen()
{
rotate_obj = getentarray("stenen","targetname");
if(isdefined(rotate_obj))
{
for(i=0;i<rotate_obj.size;i++)
{
rotate_obj[i] thread steen();
}
}
}

steen()
{
if (!isdefined(self.speed))
self.speed = 60;
if (!isdefined(self.script_noteworthy))
self.script_noteworthy = "y";

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

elevator17()
{
elevator17 = getent("fall1","targetname");
while(1)
{
elevator17 movey (30000,16,0,0);
elevator17 waittill ("movedone");
elevator17 movez (5000,4,0,0);
elevator17 waittill ("movedone");
elevator17 movey (-40000,24,0,0);
elevator17 waittill ("movedone");
elevator17 movez (-5000,20,0,0);
elevator17 waittill ("movedone");
elevator17 movey (10000,8,0,0);
elevator17 waittill ("movedone");
} 
} 


steen5()
{
elevator = getent("steen5","targetname");
while(1)
{
elevator movey (-40000,30,0,6);
elevator waittill ("movedone");
elevator movey (50000,36,3,3);
elevator waittill ("movedone");
elevator movey (-10000,6,6,0);
elevator waittill ("movedone");
} 
} 


steen6()
{
elevator = getent("steen6","targetname");
while(1)
{
elevator movey (-40000,20,0,6);
elevator waittill ("movedone");
elevator movey (50000,25,3,3);
elevator waittill ("movedone");
elevator movey (-10000,5,6,0);
elevator waittill ("movedone");
} 
} 