main()
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
    other.spawnprotected = true;
    other setorigin(entTarget.origin);
    other setplayerangles(entTarget.angles);
    other iprintlnbold ("You have been captured!!! HAHAHA!");
    wait(0.10);
    other.spawnprotected = undefined;
  }
}
