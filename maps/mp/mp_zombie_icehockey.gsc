main()
{
maps\mp\_load::main();

setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
ambientPlay("ambient_france");

game["allies"] = "american";
game["axis"] = "german";
game["attackers"] = "allies";
game["defenders"] = "axis";
game["american_soldiertype"] = "normandy";
game["german_soldiertype"] = "normandy";

setCvar("r_glowbloomintensity0", ".25");
setCvar("r_glowbloomintensity1", ".25");
setcvar("r_glowskybleedintensity0",".3");

thread teleportenter();
thread elevator();
thread elevator2();
thread elevator3();
thread elevator4();
thread boat();
thread telefix();
}

telefix()
{
	volume = [];
	volume[0] = 2150; // min (x)
	volume[1] = 919; // min (y)
	volume[2] = 8; // min  (z)
	volume[3] = 2200; // max  (x)
	volume[4] = 1007; // max  (y)
	volume[5] = 400; // max  (z)

	trigger = sim\_sf_triggers::spawnTrigger(  volume, "multiple");
	trigger._color = (1,0,0);

	while(1)
	{
		trigger waittill("trigger", player);

      		player setorigin((2207, 1039, 804));
	}
}

teleportenter()
{
  entTransporter = getentarray("vstup","targetname");
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
thread elevator();
}

elevator()
{
elevator=GetEnt("nextlvl","targetname");
trig=GetEnt("trig_next","targetname");
while(1)
{
wait(10);
trig waittill ("trigger");
elevator movez (2096,10,2,2);
elevator waittill ("movedone");
wait(10);
trig waittill ("trigger");
elevator movez (-2096,10,2,4);
elevator waittill ("movedone");
}
thread elevator2();
}

elevator2()
{
elevator=GetEnt("nextlvl2","targetname");
trig=GetEnt("trig_next2","targetname");
while(1)
{
wait(10);
trig waittill ("trigger");
elevator movez (2096,10,2,2);
elevator waittill ("movedone");
wait(10);
trig waittill ("trigger");
elevator movez (-2096,10,2,4);
elevator waittill ("movedone");
}
thread elevator3();
}

elevator3()
{
elevator=getent("trap2","targetname");
trig=getent("trig_trap2","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (131,9,1,1);
elevator waittill ("movedone");
wait(12);
elevator movez (-131,9,1,1);
elevator waittill ("movedone");
}
thread elevator4();
}

elevator4()
{
elevator=getent("kill","targetname");
trig=getent("trig_kill","targetname");
while(1)
{
trig waittill ("trigger");
elevator movez (737,12,1,1);
elevator waittill ("movedone");
wait(12);
elevator movez (-737,12,1,1);
elevator waittill ("movedone");
}
thread boat();
}

boat()
{
elevator=getent("trap","targetname");
trig=getent("trig_trap","targetname");
while(1)
{
trig waittill ("trigger");
elevator movex (-1704,15,3,2);
elevator waittill ("movedone");
wait(15);
elevator movex (1704,12,3,4);
elevator waittill ("movedone");
}
}