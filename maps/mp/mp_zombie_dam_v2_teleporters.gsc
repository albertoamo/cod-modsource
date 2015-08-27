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
    wait(0.001);
    other linkto (entTarget);
    wait(0.001);
    other setorigin(entTarget.origin);
    other setplayerangles(entTarget.angles);
    other linkto (entTarget);
    other iprintlnbold ("^1You have been teleported");
    wait(0.001);
    other unlink();
  }
}
