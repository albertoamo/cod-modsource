//Scripted By PwN3R
//Xfire:punishman1993
//Edited 23-2-09
main()
{
stukas();
}

stukas()
{
soundent = getent ("stuka1","targetname");
soundent = getent ("stuka2","targetname");
soundent = getent ("stuka3","targetname");
soundent = getent ("stuka4","targetname");
sound = randomint(2);
if (sound == 0)
soundent playsound ("stuka");
if (sound == 1)
soundent playsound ("stuka");
self.origin = self.start;
level thread planes();
}

planes()
{
level.PlaneSpeed = 5;

stuka1 = getent ("stuka1","targetname");
stuka2 = getent ("stuka2","targetname");
stuka3 = getent ("stuka3","targetname");
stuka4 = getent ("stuka4","targetname");


temp = getent (stuka1.target,"targetname");
stuka1.dest = temp.origin;
stuka1.start = stuka1.origin;
stuka1 hide();
temp = getent (stuka2.target,"targetname");
stuka2.dest = temp.origin;
stuka2.start = stuka2.origin;
stuka2 hide();
temp = getent (stuka3.target,"targetname");
stuka3.dest = temp.origin;
stuka3.start = stuka3.origin;
stuka3 hide();
temp = getent (stuka4.target,"targetname");
stuka4.dest = temp.origin;
stuka4.start = stuka4.origin;
stuka4 hide();


wait 60;
stuka1 thread plane_flyby("stuka_flyby");
stuka2 thread plane_flyby("stuka_flyby");
wait 60;
stuka3 thread plane_flyby("stuka_flyby");
stuka4 thread plane_flyby("stuka_flyby");
while (1)
{

wait 60;
stuka1 thread plane_flyby("stuka_flyby");
stuka2 thread plane_flyby("stuka_flyby");
wait 60;
stuka3 thread plane_flyby("stuka_flyby");
stuka4 thread plane_flyby("stuka_flyby");


}
}

plane_flyby(sound)
{
if (isdefined (sound))
self playsound (sound);
wait 60;
self show();
self moveto(self.dest, level.PlaneSpeed, 0.1, 0.1);
wait level.PlaneSpeed;
self hide();
self.origin = self.start;
} 

